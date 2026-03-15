import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/address_repository.dart';
import '../datasources/address_local_datasource.dart';
import '../model/address_model.dart';

class AddressRepositoryImpl implements AddressRepository {

  final AddressLocalDataSource local;

  AddressRepositoryImpl(this.local);

  @override
  Future<void> saveAddress(AddressEntity address, String email) {

    return local.saveAddress(
      email,
      AddressModel(
        nameAddress: address.nameAddress,
        address: address.address,
        isDefault: address.isDefault,
      ),
    );
  }

  @override
  Future<List<AddressEntity>> getAddresses(String email) {
    return local.getAddresses(email);
  }

  @override
  Future<AddressEntity?> getDefaultAddress(String email) async {

    final addresses = await local.getAddresses(email);

    try {
      return addresses.firstWhere((a) => a.isDefault);
    } catch (_) {
      return addresses.isNotEmpty ? addresses.first : null;
    }
  }
}