import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plantify/core/theme/app_colors.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../router.dart';
import '../widgets/loading_widget.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {

    await Future.delayed(const Duration(seconds: 2));

    final tokenStorage = ref.read(tokenStorageProvider);
    final token = await tokenStorage.getAccessToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {

      Navigator.pushReplacementNamed(
        context,
        AppRouter.mainWrapper,
      );

    } else {

      Navigator.pushReplacementNamed(
        context,
        AppRouter.onboarding,
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main500,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logos/plantify_logo.png',
                    width: 280.w,
                    fit: BoxFit.contain,
                  ),
                ),

                Positioned(
                  bottom: 86.h,
                  left: 0,
                  right: 0,
                  child: const Center(
                    child: LoadingWidget(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}