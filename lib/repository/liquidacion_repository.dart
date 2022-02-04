import 'package:flutter_app_liquid/models/Liquidacion.dart';
import 'package:flutter_app_liquid/repository/repository.dart';
import 'package:flutter_app_liquid/services/liquidacion_service.dart';

class LiquidacionRepository extends Repository {
  loadUsers(String cobro) async {
    try {
      List<Liquidacion> newList = await liquidacionService.getlist(cobro);
      connected = true;
      return await newList;
    } catch (_) {
      return null;
    }
  }
}
