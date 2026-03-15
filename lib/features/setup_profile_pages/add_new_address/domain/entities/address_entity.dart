class AddressEntity {
  final String nameAddress;
  final String address;
  final bool isDefault;

  const AddressEntity({
    required this.nameAddress,
    required this.address,
    required this.isDefault,
  });

  AddressEntity copyWith({
    String? nameAddress,
    String? address,
    bool? isDefault,
  }) {
    return AddressEntity(
      nameAddress: nameAddress ?? this.nameAddress,
      address: address ?? this.address,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}