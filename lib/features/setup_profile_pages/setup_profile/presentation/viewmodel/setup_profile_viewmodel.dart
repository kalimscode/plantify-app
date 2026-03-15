import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/storage/token_storage.dart';
import '../../domain/usecases/save_profile_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import 'setup_profile_state.dart';

class SetupProfileViewModel extends StateNotifier<SetupProfileState> {
  final SaveProfileUseCase saveProfileUseCase;
  final GetProfileUseCase? getProfileUseCase;

  final ImagePicker _picker = ImagePicker();

  final TokenStorage storage;

  SetupProfileViewModel(
      this.saveProfileUseCase,
      this.storage, {
        this.getProfileUseCase,
      }) : super(SetupProfileState.initial());


  void setFullName(String value) {
    state = state.copyWith(
      profile: state.profile.copyWith(fullName: value),
    );
  }

  void setEmail(String value) {
    state = state.copyWith(
      profile: state.profile.copyWith(email: value),
    );
  }

  void setPhone(String value) {
    state = state.copyWith(
      profile: state.profile.copyWith(phone: value),
    );
  }

  void setGender(String value) {
    state = state.copyWith(
      profile: state.profile.copyWith(gender: value),
    );
  }


  Future<void> pickImage() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (file == null) return;

    state = state.copyWith(
      profile: state.profile.copyWith(imagePath: file.path),
    );
  }

  Future<void> loadProfile() async {

    if (getProfileUseCase == null) return;

    try {

      final email = await storage.getEmail();

      if (email == null) return;

      final profile = await getProfileUseCase!.call(email);

      if (profile == null) return;

      state = state.copyWith(profile: profile);

    } catch (_) {}
  }


  Future<void> submit() async {

    if (state.profile.fullName.trim().isEmpty) {
      state = state.copyWith(error: "Please enter name");
      return;
    }

    if (!state.profile.email.contains('@')) {
      state = state.copyWith(error: "Enter valid email");
      return;
    }

    if (state.profile.phone.trim().length < 7) {
      state = state.copyWith(error: "Enter valid phone number");
      return;
    }

    try {

      state = state.copyWith(isLoading: true, error: null); // ← clear error

      final email = await storage.getEmail();

      if (email == null) {
        state = state.copyWith(
          isLoading: false,
          error: "User email not found",
        );
        return;
      }

      final profile = state.profile.copyWith(email: email);

      await saveProfileUseCase(profile);

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
      );

    } catch (e) {

      state = state.copyWith(
        isLoading: false,
        error: "Failed to save profile",
      );
    }
  }

  void resetSuccess() {
    state = state.copyWith(isSuccess: false);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}