import 'package:flutter/foundation.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource local;
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl(this.local, this.remote);

  @override
  Future<void> saveProfile(ProfileEntity profile) {
    debugPrint('💾 saveProfile: fullName="${profile.fullName}" email="${profile.email}"');
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
  Future<ProfileEntity?> getProfile(String email) async {
    debugPrint('🔎 getProfile for: $email');

    final localProfile = await local.get(email);
    debugPrint('📂 Local → fullName="${localProfile?.fullName}" phone="${localProfile?.phone}"');

    if (localProfile != null && localProfile.fullName.trim().isNotEmpty) {

      debugPrint('✅ Returning local profile');
      return localProfile;
    }

    debugPrint('🌐 Local empty, fetching remote...');
    try {
      final remoteProfile = await remote.getProfile();
      debugPrint('🌐 Remote → fullName="${remoteProfile.fullName}" phone="${remoteProfile.phone}"');

      if (remoteProfile.fullName.trim().isEmpty) {
        debugPrint('⚠️ Remote returned no name — returning local as-is');
        return localProfile;
      }

      final merged = ProfileModel(
        fullName: remoteProfile.fullName,
        email: remoteProfile.email.isNotEmpty ? remoteProfile.email : email,
        phone: remoteProfile.phone,
        gender: remoteProfile.gender,
        imagePath: localProfile?.imagePath ?? remoteProfile.imagePath,
      );

      await local.save(email, merged);
      debugPrint('✅ Merged remote → local saved');
      return merged;
    } catch (e, st) {
      debugPrint('❌ Remote fetch failed: $e\n$st');
      return localProfile; // return whatever local has
    }
  }
}