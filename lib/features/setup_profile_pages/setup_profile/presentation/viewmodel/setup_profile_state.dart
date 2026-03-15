import '../../domain/entities/profile_entity.dart';

class SetupProfileState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final ProfileEntity profile;

  const SetupProfileState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
    required this.profile,
  });

  factory SetupProfileState.initial() {
    return SetupProfileState(
      profile: const ProfileEntity(
        fullName: '',
        email: '',
        phone: '',
        gender: '',
      ),
    );
  }

  SetupProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
    ProfileEntity? profile,
  }) {
    return SetupProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      profile: profile ?? this.profile,
    );
  }
}
