import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenStorage {

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    String? email,
  });

  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();

  Future<void> saveEmail(String email);
  Future<String?> getEmail();

  Future<void> clear();
}

class TokenStorageImpl implements TokenStorage {
  final SharedPreferences _prefs;

  TokenStorageImpl(this._prefs); // Add this constructor

  static const _accessTokenKey = "access_token";
  static const _refreshTokenKey = "refresh_token";
  static const _emailKey = "user_email";

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    String? email,
  }) async {
    await _prefs.setString(_accessTokenKey, accessToken);
    await _prefs.setString(_refreshTokenKey, refreshToken);
    if (email != null) await _prefs.setString(_emailKey, email);
  }

  @override
  Future<String?> getAccessToken() async => _prefs.getString(_accessTokenKey);

  @override
  Future<String?> getRefreshToken() async => _prefs.getString(_refreshTokenKey);

  @override
  Future<void> saveEmail(String email) async => _prefs.setString(_emailKey, email);

  @override
  Future<String?> getEmail() async => _prefs.getString(_emailKey);

  @override
  Future<void> clear() async {
    await _prefs.remove(_accessTokenKey);
    await _prefs.remove(_refreshTokenKey);
    await _prefs.remove(_emailKey);
  }
}