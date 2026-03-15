import '../../domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.nameAddress,
    required super.address,
    required super.isDefault,
  });

  Map<String, dynamic> toJson() {
    return {
      'nameAddress': nameAddress,
      'address': address,
      'isDefault': isDefault,
    };
  }
}
