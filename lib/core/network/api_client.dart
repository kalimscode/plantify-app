import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../storage/token_storage.dart';

class ApiClient {
  final Dio dio;
  final TokenStorage storage;

  ApiClient(this.storage)
      : dio = Dio(
    BaseOptions(
      baseUrl: kReleaseMode
          ? 'https://staging-api.theplantinium.com'
          : 'https://staging-api.theplantinium.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  ) {
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!options.path.contains("openrouter.ai")) {
            final token = await storage.getAccessToken();

            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }

          print("🚀 REQUEST: ${options.uri}");
          print("📦 HEADERS: ${options.headers}");
          print("📦 DATA: ${options.data}");

          handler.next(options);
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (res, handler) {
          print('🟢 API RESPONSE => ${res.data}');
          handler.next(res);
        },
        onError: (e, handler) {
          print('🔴 API ERROR => ${e.response?.data}');
          handler.next(e);
        },
      ),
    );
  }
}