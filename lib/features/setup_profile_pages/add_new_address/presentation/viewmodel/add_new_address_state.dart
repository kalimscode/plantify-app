class AddNewAddressState {
  final String nameAddress;
  final String address;
  final bool isDefault;
  final bool isLoading;
  final String? error;

  const AddNewAddressState({
    this.nameAddress = '',
    this.address = '',
    this.isDefault = false,
    this.isLoading = false,
    this.error,
  });

  AddNewAddressState copyWith({
    String? nameAddress,
    String? address,
    bool? isDefault,
    bool? isLoading,
    String? error,
  }) {
    return AddNewAddressState(
      nameAddress: nameAddress ?? this.nameAddress,
      address: address ?? this.address,
      isDefault: isDefault ?? this.isDefault,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
