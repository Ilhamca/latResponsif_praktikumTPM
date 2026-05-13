import 'package:hive/hive.dart';

class AuthService {
  AuthService._();

  static const String _boxName = 'users';
  static final AuthService instance = AuthService._();

  Box<String> get _box {
    if (!Hive.isBoxOpen(_boxName)) {
      throw StateError('Hive box is not open. Call Hive.initFlutter and openBox first.');
    }
    return Hive.box<String>(_boxName);
  }

  bool hasUser(String username) {
    return _box.containsKey(username);
  }

  bool login(String username, String password) {
    return _box.get(username) == password;
  }

  bool register(String username, String password) {
    if (_box.containsKey(username)) {
      return false;
    }

    _box.put(username, password);
    return true;
  }
}