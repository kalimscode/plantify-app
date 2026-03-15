import '../../../../core/network/api_client.dart';

class CategoryRemoteDataSource {
  final ApiClient api;

  CategoryRemoteDataSource(this.api);

  Future<dynamic> getAll() async {
    final res = await api.dio.get('/categories');
    return res.data;
  }

  Future<dynamic> getParents(int page, int limit) async {
    final res = await api.dio.get(
      '/categories/parents',
      queryParameters: {
        'page': page,
        'limit': limit,
      },
    );
    return res.data;
  }

  Future<dynamic> getById(String id) async {
    final res = await api.dio.get('/categories/$id');
    return res.data;
  }

  Future<dynamic> getSubcategories(String parentId) async {
    final res =
    await api.dio.get('/categories/$parentId/subcategories');
    return res.data;
  }
}