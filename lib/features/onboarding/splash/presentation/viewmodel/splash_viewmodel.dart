import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/splash_usecase.dart';

class SplashViewModel extends StateNotifier<bool> {
  final SplashUseCase useCase;

  SplashViewModel({required this.useCase}) : super(false);

  Future<void> startSplash(Function onFinish) async {
    await useCase.execute();
    state = true;
    onFinish();
  }
}
