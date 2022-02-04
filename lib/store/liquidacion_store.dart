import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter_app_liquid/helpers/Session.dart';
import 'package:flutter_app_liquid/models/Lineas.dart';
import 'package:flutter_app_liquid/models/Liquidacion.dart';
import 'package:flutter_app_liquid/repository/liquidacion_repository.dart';
import 'package:mobx/mobx.dart';
part 'liquidacion_store.g.dart';

class LiquidacionStore = _LiquidacionStore with _$LiquidacionStore;

abstract class _LiquidacionStore with Store {
  LiquidacionRepository repository = LiquidacionRepository();
  final AsyncMemoizer<Liquidacion> _memoizer = AsyncMemoizer<Liquidacion>();

  @observable
  bool loading = false;

  @observable
  List<Liquidacion> listLiquidacion;

  @observable
  List<Lineas> listLineas = [];

  @action
  setCobro(String cobro) {
    cobro = cobro;
  }

  @action
  Future<List<Lineas>> DataLineasForTipoTercero() async {
    loading = true;
    var sessiondata = await Session.getSession();
    await Future.delayed(Duration(seconds: 1));
    final response = await repository.liquidacionService
        .DataLineasForTipoTercero(sessiondata.te_tipo_tercero,
            sessiondata.us_tercero, sessiondata.us_idusuario);
    loading = false;

    final parsed = response['data'].cast<Map<String, dynamic>>();
    print('parsed');
    print(parsed);
    List<Lineas> lineas = parsed.map<Lineas>((json) => Lineas.fromJson(json)).toList();
    return lineas;
  }

  @action
  Future<Liquidacion> StoreGetLiquidacionList(String cobro) async {
    loading = true;
    await Future.delayed(Duration(seconds: 1));
    print(cobro);
    final response = await repository.liquidacionService.getlist(cobro);
    loading = false;
    print(response['data']['abonos_vencidos']);
    /*if (response['data'] != null) {
      listLiquidacion = (response['data'] as List)
          ?.map((i) => Liquidacion.fromJson(i))
          .toList();
    } else {
      listLiquidacion = [];
    }*/
    return Liquidacion.fromJson(response['data']);
  }
}
