import '../../../../../core/network/api_client.dart';
import '../models/profile_model.dart';

class ProfileRemoteDataSource {
  final ApiClient api;

  ProfileRemoteDataSource(this.api);

  Future<ProfileModel> getProfile() async {
    final res = await api.dio.get('/users/profile');
    return ProfileModel.fromJson(res.data['data']);
  }
}
