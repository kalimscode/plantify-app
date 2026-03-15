import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';

class AuthRemoteDataSource {
  final ApiClient api;

  AuthRemoteDataSource(this.api);

  Map<String, dynamic>? _extractTokens(dynamic data) {
    if (data is! Map) return null;

    final tokens = data['data']?['tokens'];

    if (tokens == null) return null;

    return {
      'access_token': tokens['access_token'],
      'refresh_token': tokens['refresh_token'],
    };
  }

  Future<void> register(Map<String, dynamic> body) async {
    try {
      final res = await api.dio.post('/auth/register', data: body);

      if (res.data['success'] != true) {
        throw Exception(res.data['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      final msg =
          e.response?.data['message'] ?? e.message ?? 'Registration failed';
      throw Exception(msg);
    }
  }

  Future<Map<String, dynamic>> login(
      Map<String, dynamic> body) async {
    try {
      final res = await api.dio.post('/auth/login', data: body);

      final tokens = _extractTokens(res.data);

      if (tokens == null) {
        throw Exception('Tokens missing from response');
      }

      return tokens;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Login failed',
      );
    }
  }

  Future<Map<String, dynamic>> refreshToken(
      Map<String, dynamic> body) async {
    try {
      final res =
      await api.dio.post('/auth/refresh', data: body);

      final tokens = _extractTokens(res.data);

      if (tokens == null) {
        throw Exception('Refresh failed');
      }

      return tokens;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Refresh failed',
      );
    }
  }
}