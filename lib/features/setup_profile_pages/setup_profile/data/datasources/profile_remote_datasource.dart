import 'package:flutter/foundation.dart';
import '../../../../../core/network/api_client.dart';
import '../models/profile_model.dart';

class ProfileRemoteDataSource {
  final ApiClient api;

  ProfileRemoteDataSource(this.api);

  Future<ProfileModel> getProfile() async {
    final res = await api.dio.get('/users/profile');

    debugPrint('📡 RAW /users/profile response: ${res.data}');

    Map<String, dynamic> json;

    final body = res.data;
    if (body is Map<String, dynamic>) {
      if (body['data'] is Map<String, dynamic>) {
        json = body['data'] as Map<String, dynamic>;
      } else {
        json = body;
      }
    } else {
      throw Exception('Unexpected profile response type: ${body.runtimeType}');
    }

    debugPrint('📋 Parsed profile JSON: $json');

    return ProfileModel.fromJson(json);
  }
}