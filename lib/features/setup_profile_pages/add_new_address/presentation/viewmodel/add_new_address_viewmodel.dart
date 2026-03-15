import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/di/providers.dart';
import '../../../../../core/storage/token_storage.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/usecases/save_address_usecase.dart';
import 'add_new_address_state.dart';

class AddNewAddressViewModel extends StateNotifier<AddNewAddressState> {

  final SaveAddressUseCase saveAddressUseCase;
  final TokenStorage storage;
  final Ref ref;

  AddNewAddressViewModel(
      this.saveAddressUseCase,
      this.storage,
      this.ref,
      ) : super(const AddNewAddressState());

  void setNameAddress(String value) {
    state = state.copyWith(nameAddress: value);
  }

  void setAddress(String value) {
    state = state.copyWith(address: value);
  }

  void toggleDefault() {
    state = state.copyWith(isDefault: !state.isDefault);
  }

  Future<void> submit() async {

    if (state.nameAddress.trim().isEmpty) {
      state = state.copyWith(error: "Enter address name");
      return;
    }

    if (state.address.trim().isEmpty) {
      state = state.copyWith(error: "Enter address");
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    final email = await storage.getEmail();

    if (email == null) {
      state = state.copyWith(
        isLoading: false,
        error: "User email not found",
      );
      return;
    }

    final entity = AddressEntity(
      nameAddress: state.nameAddress,
      address: state.address,
      isDefault: state.isDefault,
    );
    await saveAddressUseCase(entity, email);

    ref.invalidate(userAddressesProvider);

    state = state.copyWith(isLoading: false);
  }}