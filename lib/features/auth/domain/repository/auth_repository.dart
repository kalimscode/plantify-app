abstract class AuthRepository {
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String country,
    required String city,
  });

  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> refreshToken();
}