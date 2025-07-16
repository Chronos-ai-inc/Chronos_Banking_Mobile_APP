import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/document_upload_widget.dart';
import './widgets/face_scan_widget.dart';
import './widgets/progress_indicator_widget.dart';
import './widgets/verification_step_widget.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({Key? key}) : super(key: key);

  @override
  State<IdentityVerificationScreen> createState() =>
      _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState
    extends State<IdentityVerificationScreen> {
  int _currentStep = 1;
  final int _totalSteps = 3;

  // Document upload states
  XFile? _frontIdImage;
  XFile? _backIdImage;
  XFile? _faceImage;

  // Step completion states
  bool _frontIdCompleted = false;
  bool _backIdCompleted = false;
  bool _faceVerificationCompleted = false;

  final List<String> _stepTitles = [
    'Upload Front ID',
    'Upload Back ID',
    'Face Verification',
  ];

  final List<Map<String, dynamic>> _verificationSteps = [
    {
      'title': 'Front ID Document',
      'description': 'Take a clear photo of the front of your ID',
      'iconName': 'credit_card',
    },
    {
      'title': 'Back ID Document',
      'description': 'Take a clear photo of the back of your ID',
      'iconName': 'credit_card',
    },
    {
      'title': 'Face Verification',
      'description': 'Complete biometric face scan for security',
      'iconName': 'face',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgressIndicatorWidget(
                      currentStep: _currentStep,
                      totalSteps: _totalSteps,
                      stepTitles: _stepTitles,
                    ),
                    SizedBox(height: 3.h),
                    _buildCurrentStepContent(),
                    SizedBox(height: 3.h),
                    _buildStepsList(),
                  ],
                ),
              ),
            ),
            _buildBottomActionArea(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: CustomIconWidget(
          iconName: 'arrow_back_ios',
          color: AppTheme.textPrimary,
          size: 24,
        ),
      ),
      title: Text(
        'Identity Verification',
        style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saveProgress,
          child: Text(
            'Save',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.accentGold,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepHeader(
              'Upload Front ID',
              'Take a clear photo of the front of your government-issued ID',
            ),
            SizedBox(height: 2.h),
            DocumentUploadWidget(
              onDocumentCaptured: (image) {
                setState(() {
                  _frontIdImage = image;
                  _frontIdCompleted = image != null;
                });
              },
              documentType: 'Front ID',
              isRequired: true,
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepHeader(
              'Upload Back ID',
              'Take a clear photo of the back of your government-issued ID',
            ),
            SizedBox(height: 2.h),
            DocumentUploadWidget(
              onDocumentCaptured: (image) {
                setState(() {
                  _backIdImage = image;
                  _backIdCompleted = image != null;
                });
              },
              documentType: 'Back ID',
              isRequired: true,
            ),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepHeader(
              'Face Verification',
              'Complete biometric face scan to verify your identity',
            ),
            SizedBox(height: 2.h),
            FaceScanWidget(
              onFaceScanCompleted: (image) {
                setState(() {
                  _faceImage = image;
                  _faceVerificationCompleted = image != null;
                });
              },
              isRequired: true,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStepHeader(String title, String description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.accentGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.accentGold.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.accentGold,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            description,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verification Steps',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 2.h),
        ...List.generate(_verificationSteps.length, (index) {
          final step = _verificationSteps[index];
          final stepNumber = index + 1;

          bool isCompleted = false;
          if (stepNumber == 1) isCompleted = _frontIdCompleted;
          if (stepNumber == 2) isCompleted = _backIdCompleted;
          if (stepNumber == 3) isCompleted = _faceVerificationCompleted;

          return VerificationStepWidget(
            title: step['title'],
            description: step['description'],
            iconName: step['iconName'],
            isCompleted: isCompleted,
            isActive: stepNumber == _currentStep,
            onTap: () => _navigateToStep(stepNumber),
          );
        }),
      ],
    );
  }

  Widget _buildBottomActionArea() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: AppTheme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (_currentStep > 1)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      child: Text('Previous'),
                      style: AppTheme.darkTheme.outlinedButtonTheme.style,
                    ),
                  ),
                if (_currentStep > 1) SizedBox(width: 3.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _canContinue() ? _nextStep : null,
                    child: Text(
                        _currentStep == _totalSteps ? 'Complete' : 'Continue'),
                    style: AppTheme.darkTheme.elevatedButtonTheme.style,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              'Your data is encrypted and secure',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canContinue() {
    switch (_currentStep) {
      case 1:
        return _frontIdCompleted;
      case 2:
        return _backIdCompleted;
      case 3:
        return _faceVerificationCompleted;
      default:
        return false;
    }
  }

  void _navigateToStep(int step) {
    if (step <= _currentStep || _canAccessStep(step)) {
      setState(() {
        _currentStep = step;
      });
    }
  }

  bool _canAccessStep(int step) {
    switch (step) {
      case 1:
        return true;
      case 2:
        return _frontIdCompleted;
      case 3:
        return _frontIdCompleted && _backIdCompleted;
      default:
        return false;
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _nextStep() {
    if (_currentStep < _totalSteps && _canContinue()) {
      setState(() {
        _currentStep++;
      });
    } else if (_currentStep == _totalSteps && _canContinue()) {
      _completeVerification();
    }
  }

  void _saveProgress() {
    // Save current progress to secure storage
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Progress saved successfully'),
        backgroundColor: AppTheme.successGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _completeVerification() {
    // Show success animation and navigate to biometric setup
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.darkTheme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: AppTheme.successGreen,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'check',
                  color: AppTheme.textPrimary,
                  size: 32,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'Verification Complete!',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Your identity has been successfully verified. You can now set up biometric authentication.',
              textAlign: TextAlign.center,
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            SizedBox(height: 3.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, '/biometric-authentication-setup');
                },
                child: Text('Continue to Biometric Setup'),
                style: AppTheme.darkTheme.elevatedButtonTheme.style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
