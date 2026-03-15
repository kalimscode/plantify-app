import '../../../../../../core/storage/local_storage.dart';
import '../models/profile_model.dart';

class ProfileLocalDataSource {

  final LocalStorage storage;

  ProfileLocalDataSource(this.storage);

  Future<void> save(String email, ProfileModel model) {

    return storage.saveProfile(
      email,
      model.toJson(),
    );
  }

  Future<ProfileModel?> get(String email) async {

    final json = await storage.getProfile(email);

    if (json == null) return null;

    return ProfileModel.fromJson(json);
  }
}