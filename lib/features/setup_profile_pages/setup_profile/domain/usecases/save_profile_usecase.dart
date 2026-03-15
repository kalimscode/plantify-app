import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class SaveProfileUseCase {
  final ProfileRepository repo;
  SaveProfileUseCase(this.repo);

  Future<void> call(ProfileEntity profile) {
    return repo.saveProfile(profile);
  }
}
