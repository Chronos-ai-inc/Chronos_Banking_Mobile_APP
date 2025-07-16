import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FaceScanWidget extends StatefulWidget {
  final Function(XFile?) onFaceScanCompleted;
  final bool isRequired;

  const FaceScanWidget({
    Key? key,
    required this.onFaceScanCompleted,
    this.isRequired = true,
  }) : super(key: key);

  @override
  State<FaceScanWidget> createState() => _FaceScanWidgetState();
}

class _FaceScanWidgetState extends State<FaceScanWidget>
    with TickerProviderStateMixin {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _isScanning = false;
  bool _scanCompleted = false;
  XFile? _capturedFace;
  String _instructionText = 'Position your face in the oval';

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _scanController;
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _pulseController.dispose();
    _scanController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _scanController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _scanAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scanController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true);
  }

  Future<bool> _requestCameraPermission() async {
    if (kIsWeb) return true;
    return (await Permission.camera.request()).isGranted;
  }

  Future<void> _initializeCamera() async {
    try {
      if (!await _requestCameraPermission()) return;

      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;

      final camera = _cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first,
      );

      _cameraController = CameraController(
          camera, kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high);

      await _cameraController!.initialize();
      await _applySettings();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
  }

  Future<void> _applySettings() async {
    if (_cameraController == null) return;

    try {
      await _cameraController!.setFocusMode(FocusMode.auto);
    } catch (e) {
      debugPrint('Focus mode error: $e');
    }
  }

  Future<void> _startFaceScan() async {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _isScanning) return;

    setState(() {
      _isScanning = true;
      _instructionText = 'Hold still while scanning...';
    });

    _scanController.forward();

    // Simulate face detection process
    await Future.delayed(const Duration(seconds: 3));

    try {
      final XFile photo = await _cameraController!.takePicture();
      setState(() {
        _capturedFace = photo;
        _scanCompleted = true;
        _instructionText = 'Face scan completed successfully!';
      });
      widget.onFaceScanCompleted(photo);
    } catch (e) {
      debugPrint('Face scan error: $e');
      setState(() {
        _instructionText = 'Scan failed. Please try again.';
      });
    } finally {
      setState(() {
        _isScanning = false;
      });
      _scanController.reset();
    }
  }

  void _retakeScan() {
    setState(() {
      _capturedFace = null;
      _scanCompleted = false;
      _instructionText = 'Position your face in the oval';
    });
    widget.onFaceScanCompleted(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'face',
                color: AppTheme.accentGold,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Face Verification',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              widget.isRequired
                  ? Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: AppTheme.errorRed.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Required',
                        style:
                            AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.errorRed,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 2.h),
          _buildFaceScanView(),
          SizedBox(height: 2.h),
          _buildInstructionText(),
          SizedBox(height: 2.h),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildFaceScanView() {
    if (!_isCameraInitialized || _cameraController == null) {
      return Container(
        height: 30.h,
        decoration: BoxDecoration(
          color: AppTheme.secondaryDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.dividerColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'face',
                color: AppTheme.textSecondary,
                size: 48,
              ),
              SizedBox(height: 1.h),
              Text(
                'Initializing face scanner...',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _scanCompleted ? AppTheme.successGreen : AppTheme.accentGold,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(_cameraController!),
            ),
            // Face oval overlay
            Center(
              child: AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _isScanning ? 1.0 : _pulseAnimation.value,
                    child: Container(
                      width: 50.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _scanCompleted
                              ? AppTheme.successGreen
                              : _isScanning
                                  ? AppTheme.warningAmber
                                  : AppTheme.accentGold,
                          width: 3,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Scanning animation
            if (_isScanning)
              AnimatedBuilder(
                animation: _scanAnimation,
                builder: (context, child) {
                  return Positioned(
                    top: 5.h + (20.h * _scanAnimation.value),
                    left: 25.w,
                    right: 25.w,
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppTheme.accentGold,
                            Colors.transparent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.accentGold.withValues(alpha: 0.5),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            // Success indicator
            if (_scanCompleted)
              Center(
                child: Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen,
                    shape: BoxShape.circle,
                  ),
                  child: CustomIconWidget(
                    iconName: 'check',
                    color: AppTheme.textPrimary,
                    size: 32,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionText() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            _instructionText,
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (!_scanCompleted && !_isScanning) ...[
            SizedBox(height: 1.h),
            Text(
              '• Look straight at the camera\n• Remove glasses if wearing\n• Ensure good lighting',
              textAlign: TextAlign.center,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    if (_scanCompleted) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: _retakeScan,
          icon: CustomIconWidget(
            iconName: 'refresh',
            color: AppTheme.accentGold,
            size: 20,
          ),
          label: Text('Retake Scan'),
          style: AppTheme.darkTheme.outlinedButtonTheme.style,
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isScanning ? null : _startFaceScan,
        icon: _isScanning
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppTheme.primaryDark),
                ),
              )
            : CustomIconWidget(
                iconName: 'face_retouching_natural',
                color: AppTheme.primaryDark,
                size: 20,
              ),
        label: Text(_isScanning ? 'Scanning...' : 'Start Face Scan'),
        style: AppTheme.darkTheme.elevatedButtonTheme.style,
      ),
    );
  }
}
