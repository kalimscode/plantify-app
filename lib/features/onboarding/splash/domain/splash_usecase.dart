
import 'package:plantify/features/onboarding/splash/domain/repository/splash_repository.dart';

class SplashUseCase {
  final SplashRepository repository;

  SplashUseCase(this.repository);

  Future<void> execute() async {
    await repository.loadSplashData();
  }
}
