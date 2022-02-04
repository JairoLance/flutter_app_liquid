import 'dart:convert';
import 'package:flutter_app_liquid/constants/api_routes.dart';
import 'package:flutter_app_liquid/models/Lineas.dart';
import 'package:http/http.dart' as http;
import 'base_service.dart';

class LiquidacionService extends BaseService {
  static Future<dynamic> GuardarLiquidacion(var body) async {
    print(body);
    return await http.post(
        Uri.encodeFull(BASE_URL + LIQUIDACION + LIQUIDACION_SAVE),
        body: body,
        headers: {"Accept": "application/json"}).then((http.Response response) {
      final int statusCode = response.statusCode;
      var result = json.decode(response.body);
      if (statusCode < 200 || statusCode > 400 || json == null) {
        //Error de tipo 'PDOException'
        Map<String, dynamic> params;
        if (result["exception"][0]["type"] == 'PDOException') {
          params = <String, dynamic>{
            'type': 'error',
            'message': result["exception"][0]["message"]
          };
          return params;
        } else {
          params = <String, dynamic>{
            'type': 'error',
            'message': 'Lo sentimos , error insperado ' + result
          };
          return params;
        }
      } else {
        return result;
      }
    });
  }

  getlist(String cobro) async {
    //print("Veri ... " + user.toString());
    //print(Uri.encodeFull(BASE_URL + USER + LOGIN));
    var data = json.encode({'cobro': cobro});
    // var response = await http.post(BASE_URL + USER + LOGIN, body: json.encode(user.toJson()),headers: { 'Content-type': 'application/json'});
    var response = await this.post(
        Uri.encodeFull(BASE_URL + LIQUIDACION + LIQUIDACION_GETLIST),
        body: data,
        headers: {"Authorization": ""});
    //var jsondata = json.decode(response.body);
    var success = jsonDecode(response.body);
    return success;
  }

  DataLineasForTipoTercero(
      String te_tipo_tercero, String us_tercero, String us_idusuario) async {
    print("Veri ... " + us_tercero.toString());
    //print(Uri.encodeFull(BASE_URL + USER + LOGIN));
    var data = json.encode({
      'te_tipo_tercero': te_tipo_tercero,
      'us_tercero': us_tercero,
      'us_idusuario': us_idusuario
    });
    // var response = await http.post(BASE_URL + USER + LOGIN, body: json.encode(user.toJson()),headers: { 'Content-type': 'application/json'});
    var response = await this.post(
        Uri.encodeFull(BASE_URL + LIQUIDACION + LINEAS_GETTIPOS),
        body: data,
        headers: {"Authorization": ""});
    //var jsondata = json.decode(response.body);
    var success = jsonDecode(response.body);

    return success;
  }
}
