import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences prefs;
  LocalStorage(this.prefs);
  String _profileKey(String email) => 'profile_$email';
  String _addressKey(String email) => 'address_$email';

  /* ---------------- PROFILE ---------------- */

  Future<void> saveProfile(String email, Map<String, dynamic> json) async {
    await prefs.setString(_profileKey(email), jsonEncode(json));
  }

  Future<Map<String, dynamic>?> getProfile(String email) async {
    final data = prefs.getString(_profileKey(email));
    if (data == null) return null;
    return jsonDecode(data);
  }

  /* ---------------- ADDRESS ---------------- */

  Future<void> saveAddresses(
      String email,
      List<Map<String, dynamic>> addresses,
      ) async {


    await prefs.setString(
      _addressKey(email),
      jsonEncode(addresses),
    );
  }

  Future<List<Map<String, dynamic>>> getAddresses(String email) async {


    final data = prefs.getString(_addressKey(email));

    if (data == null) return [];

    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  /* ---------------- THEME ---------------- */

  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return prefs.getBool(key);
  }
}