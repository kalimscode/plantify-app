import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/token_storage.dart';

class UserSessionNotifier extends StateNotifier<String?> {
  final TokenStorage storage;

  UserSessionNotifier(this.storage) : super(null) {
    _init();
  }

  Future<void> _init() async {
    final email = await storage.getEmail();
    state = email;
  }

  Future<void> setUser(String email) async {
    await storage.saveEmail(email);
    state = email;
  }

  Future<void> logout() async {
    await storage.clear();   // this should remove tokens
    state = null;
  }
}