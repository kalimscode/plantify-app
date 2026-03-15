import '../entities/address_entity.dart';

abstract class AddressRepository {

  Future<void> saveAddress(AddressEntity address, String email);

  Future<AddressEntity?> getDefaultAddress(String email);

  Future<List<AddressEntity>> getAddresses(String email);

}