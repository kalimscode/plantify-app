import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PlantScanCameraScreen extends StatefulWidget {
  const PlantScanCameraScreen({super.key});

  @override
  State<PlantScanCameraScreen> createState() =>
      _PlantScanCameraScreenState();
}

class _PlantScanCameraScreenState
    extends State<PlantScanCameraScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final status = await Permission.camera.request();

      if (!status.isGranted) {
        debugPrint('❌ Camera permission denied');
        return;
      }

      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        debugPrint('❌ No cameras available');
        return;
      }

      final backCamera = cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      _controller = CameraController(
        backCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();

      if (!mounted) return;

      setState(() {
        _ready = true;
      });

      debugPrint('✅ Camera initialized');
    } catch (e) {
      debugPrint('🔥 CAMERA ERROR: $e');
    }
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: (_controller != null &&
      _controller!.value.isInitialized)
          ? CameraPreview(_controller!)
          : const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
          ),

          Positioned(
            top: 330.h,
            left: 70.w,
            right: 70.w,
            child: Column(
              children: [
                SizedBox(
                  height: 360.h,
                  child: Stack(
                    children: [
                      _corner(top: 0, left: 0),
                      _corner(top: 0, right: 0),
                      _corner(bottom: 0, left: 0),
                      _corner(bottom: 0, right: 0),
                    ],
                  ),
                ),

                SizedBox(height: 121.h),

                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          image: const DecorationImage(
                            image: AssetImage(
                              'assets/images/sansevieria.png',
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sansevieria Care',
                              style: AppTypography.bodyMediumBold.copyWith(
                                color: AppColors.dark500,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Sansevieria are characterized by their stiff, upright, sword-like leaves.....',
                              style: AppTypography.bodySmallRegular.copyWith(
                                color: AppColors.dark500,
                                height: 1.38,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _corner({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border(
            top: top != null
                ? const BorderSide(color: Colors.white, width: 3)
                : BorderSide.none,
            bottom: bottom != null
                ? const BorderSide(color: Colors.white, width: 3)
                : BorderSide.none,
            left: left != null
                ? const BorderSide(color: Colors.white, width: 3)
                : BorderSide.none,
            right: right != null
                ? const BorderSide(color: Colors.white, width: 3)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
