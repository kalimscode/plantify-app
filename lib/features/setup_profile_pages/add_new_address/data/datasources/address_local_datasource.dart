import '../../../../../../core/storage/local_storage.dart';
import '../model/address_model.dart';

abstract class AddressLocalDataSource {
  Future<void> saveAddress(String email, AddressModel address);
  Future<List<AddressModel>> getAddresses(String email);
}

class AddressLocalDataSourceImpl implements AddressLocalDataSource {

  final LocalStorage storage;

  AddressLocalDataSourceImpl(this.storage);

  @override
  Future<void> saveAddress(String email, AddressModel address) async {

    final existing = await getAddresses(email);

    if (address.isDefault) {
      for (int i = 0; i < existing.length; i++) {
        existing[i] = existing[i].copyWith(isDefault: false) as AddressModel;
      }
    }

    existing.add(address);

    await storage.saveAddresses(
      email,
      existing.map((e) => e.toJson()).toList(),
    );
  }

  @override
  Future<List<AddressModel>> getAddresses(String email) async {

    final data = await storage.getAddresses(email);

    return data.map((e) => AddressModel(
      nameAddress: e['nameAddress'],
      address: e['address'],
      isDefault: e['isDefault'],
    )).toList();
  }
}