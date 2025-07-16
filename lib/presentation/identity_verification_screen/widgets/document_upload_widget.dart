import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DocumentUploadWidget extends StatefulWidget {
  final Function(XFile?) onDocumentCaptured;
  final String documentType;
  final bool isRequired;

  const DocumentUploadWidget({
    Key? key,
    required this.onDocumentCaptured,
    required this.documentType,
    this.isRequired = true,
  }) : super(key: key);

  @override
  State<DocumentUploadWidget> createState() => _DocumentUploadWidgetState();
}

class _DocumentUploadWidgetState extends State<DocumentUploadWidget> {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _isCapturing = false;
  XFile? _capturedImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
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

      final camera = kIsWeb
          ? _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.front,
              orElse: () => _cameras.first)
          : _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.back,
              orElse: () => _cameras.first);

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

    if (!kIsWeb) {
      try {
        await _cameraController!.setFlashMode(FlashMode.auto);
      } catch (e) {
        debugPrint('Flash mode error: $e');
      }
    }
  }

  Future<void> _capturePhoto() async {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _isCapturing) return;

    setState(() {
      _isCapturing = true;
    });

    try {
      final XFile photo = await _cameraController!.takePicture();
      setState(() {
        _capturedImage = photo;
      });
      widget.onDocumentCaptured(photo);
    } catch (e) {
      debugPrint('Photo capture error: $e');
    } finally {
      setState(() {
        _isCapturing = false;
      });
    }
  }

  Future<void> _selectFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _capturedImage = image;
        });
        widget.onDocumentCaptured(image);
      }
    } catch (e) {
      debugPrint('Gallery selection error: $e');
    }
  }

  void _retakePhoto() {
    setState(() {
      _capturedImage = null;
    });
    widget.onDocumentCaptured(null);
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
                iconName: 'credit_card',
                color: AppTheme.accentGold,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Upload ${widget.documentType}',
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
          _capturedImage != null ? _buildImagePreview() : _buildCameraView(),
          SizedBox(height: 2.h),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildCameraView() {
    if (!_isCameraInitialized || _cameraController == null) {
      return Container(
        height: 25.h,
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
                iconName: 'camera_alt',
                color: AppTheme.textSecondary,
                size: 48,
              ),
              SizedBox(height: 1.h),
              Text(
                'Initializing camera...',
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
      height: 25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.accentGold,
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
            // ID Card outline guide
            Center(
              child: Container(
                width: 70.w,
                height: 15.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.accentGold,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    // Corner guides
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: AppTheme.accentGold, width: 3),
                            left: BorderSide(
                                color: AppTheme.accentGold, width: 3),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: AppTheme.accentGold, width: 3),
                            right: BorderSide(
                                color: AppTheme.accentGold, width: 3),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppTheme.accentGold, width: 3),
                            left: BorderSide(
                                color: AppTheme.accentGold, width: 3),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppTheme.accentGold, width: 3),
                            right: BorderSide(
                                color: AppTheme.accentGold, width: 3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Instruction text
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: AppTheme.primaryDark.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Align your ${widget.documentType.toLowerCase()} within the frame',
                  textAlign: TextAlign.center,
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      height: 25.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.successGreen,
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
              child: kIsWeb
                  ? CustomImageWidget(
                      imageUrl: _capturedImage!.path,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      _capturedImage!.path,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            // Success indicator
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  color: AppTheme.successGreen,
                  shape: BoxShape.circle,
                ),
                child: CustomIconWidget(
                  iconName: 'check',
                  color: AppTheme.textPrimary,
                  size: 16,
                ),
              ),
            ),
            // Quality indicator
            Positioned(
              bottom: 12,
              left: 12,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.successGreen.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Good Quality',
                  style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _selectFromGallery,
            icon: CustomIconWidget(
              iconName: 'photo_library',
              color: AppTheme.accentGold,
              size: 20,
            ),
            label: Text('Gallery'),
            style: AppTheme.darkTheme.outlinedButtonTheme.style,
          ),
        ),
        SizedBox(width: 3.w),
        Expanded(
          child: _capturedImage != null
              ? OutlinedButton.icon(
                  onPressed: _retakePhoto,
                  icon: CustomIconWidget(
                    iconName: 'refresh',
                    color: AppTheme.accentGold,
                    size: 20,
                  ),
                  label: Text('Retake'),
                  style: AppTheme.darkTheme.outlinedButtonTheme.style,
                )
              : ElevatedButton.icon(
                  onPressed: _isCapturing ? null : _capturePhoto,
                  icon: _isCapturing
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.primaryDark),
                          ),
                        )
                      : CustomIconWidget(
                          iconName: 'camera_alt',
                          color: AppTheme.primaryDark,
                          size: 20,
                        ),
                  label: Text(_isCapturing ? 'Capturing...' : 'Capture'),
                  style: AppTheme.darkTheme.elevatedButtonTheme.style,
                ),
        ),
      ],
    );
  }
}
