import 'package:get/get.dart';

import '../services/auth_service.dart';

class AuthController extends GetxController {
  bool login(String username, String password) {
    return AuthService.instance.login(username, password);
  }

  bool register(String username, String password) {
    return AuthService.instance.register(username, password);
  }

  bool hasUser(String username) {
    return AuthService.instance.hasUser(username);
  }
}