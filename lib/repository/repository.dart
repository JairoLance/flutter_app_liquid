

import 'package:flutter_app_liquid/services/liquidacion_service.dart';
import 'package:flutter_app_liquid/services/user_service.dart';

class Repository {
  bool connected = false;
  UserService userService = UserService();
  LiquidacionService liquidacionService = LiquidacionService();
  initStore() async {
  }
}