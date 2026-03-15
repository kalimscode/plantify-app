import '../domain/repository/splash_repository.dart';
import 'dart:async';

class SplashRepositoryImpl implements SplashRepository {
  @override
  Future<void> loadSplashData() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
