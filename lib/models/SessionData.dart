import 'Lineas.dart';

class SessionData {
  String us_idusuario;
  String us_email;
  String us_usuario;
  String te_nombres;
  String us_roles;
  String token;k
  String te_tipo_tercero;
  String us_tercero;
  String data;

  SessionData(
      {this.us_idusuario,
      this.us_email,
      this.us_usuario,
      this.te_nombres,
      this.us_roles,
      this.token,
      this.te_tipo_tercero,
      this.us_tercero,
      this.data});

  SessionData.fromJson(Map<String, dynamic> json) {
    us_idusuario = json['us_idusuario'];
    us_email = json['us_email'];
    us_usuario = json['us_usuario'];
    te_nombres = json['te_nombres'];
    us_roles = json['us_roles'];
    token = json['token'];
    te_tipo_tercero = json['te_tipo_tercero'];
    us_tercero = json['us_tercero'];
    data = json['data'];
    //data = (json['data'] as List)?.map((i) => Lineas.fromJson(i)).toList();
    //data = json['data'] != null ? List<Lineas>.from(json["data"].map((x) => Lineas.fromJson(x))) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["us_idusuario"] = this.us_idusuario;
    data["us_email"] = this.us_email;
    data["us_usuario"] = this.us_usuario;
    data["te_nombres"] = this.te_nombres;
    data["us_roles"] = this.us_roles;
    data["token"] = this.token;
    data["te_tipo_tercero"] = this.te_tipo_tercero;
    data["us_tercero"] = this.us_tercero;
    data["data"] = this.data;
    return data;
  }
}
