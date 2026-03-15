
import '../../../../../../core/network/api_client.dart';

class FavouriteRemoteDataSource {
  final ApiClient api;

  FavouriteRemoteDataSource(this.api);

  Future<void> add(String productId) async {
    await api.dio.post('/favourites/$productId');
  }

  Future<void> remove(String favId) async {
    await api.dio.delete('/favourites/$favId');
  }

  Future<dynamic> list() async {
    final res = await api.dio.get('/favourites');
    return res.data;
  }
}