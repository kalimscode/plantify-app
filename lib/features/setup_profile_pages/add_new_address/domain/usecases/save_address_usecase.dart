import '../entities/address_entity.dart';
import '../repositories/address_repository.dart';

class SaveAddressUseCase {

  final AddressRepository repository;

  SaveAddressUseCase(this.repository);

  Future<void> call(AddressEntity address, String email) {
    return repository.saveAddress(address, email);
  }
}