import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {

  final ProfileLocalDataSource local;

  ProfileRepositoryImpl(this.local);

  @override
  Future<void> saveProfile(ProfileEntity profile) {

    return local.save(
      profile.email,
      ProfileModel(
        fullName: profile.fullName,
        email: profile.email,
        phone: profile.phone,
        gender: profile.gender,
        imagePath: profile.imagePath,
      ),
    );
  }

  @override
  Future<ProfileEntity?> getProfile(String email) {
    return local.get(email);
  }
}