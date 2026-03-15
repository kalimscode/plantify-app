import '../../domain/repository/auth_repository.dart';
import '../../../../core/storage/token_storage.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final TokenStorage storage;

  AuthRepositoryImpl(this.remote, this.storage);

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String country,
    required String city,
  }) async {
    await remote.register({
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'country': country,
      'city': city,
    });
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final tokens = await remote.login({
      'email': email,
      'password': password,
    });

    await storage.saveTokens(
      accessToken: tokens['access_token'],
      refreshToken: tokens['refresh_token'],
      email: email, // MUST be here
    );
  }


  @override
  Future<void> refreshToken() async {
    final refreshToken = await storage.getRefreshToken();

    if (refreshToken == null) {
      throw Exception('No refresh token found');
    }

    final tokens = await remote.refreshToken({
      'refresh_token': refreshToken,
    });

    await storage.saveTokens(
      accessToken: tokens['access_token'],
      refreshToken: tokens['refresh_token'],
    );
  }
}