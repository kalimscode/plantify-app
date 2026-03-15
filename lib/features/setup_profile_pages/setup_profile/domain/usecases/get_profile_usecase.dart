import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetProfileUseCase {

  final ProfileRepository repo;

  GetProfileUseCase(this.repo);

  Future<ProfileEntity?> call(String email) {
    return repo.getProfile(email);
  }
}