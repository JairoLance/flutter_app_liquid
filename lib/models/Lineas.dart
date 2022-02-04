class Lineas {
  String crIdcobro;
  String crNombre;
  String crMoto;
  String crCelular;
  String crEmail;
  String crCiudad;
  String crDetalles;
  String crRuta;
  String crCrea;
  String crCompraMax;
  String crSync;
  String cuUsuario;
  String hoyliquidado;
 //Lineas();
  /*Lineas(
      {this.crIdcobro,
        this.crNombre,
        this.crMoto,
        this.crCelular,
        this.crEmail,
        this.crCiudad,
        this.crDetalles,
        this.crRuta,
        this.crCrea,
        this.crCompraMax,
        this.crSync});*/

  Lineas(
      {this.crIdcobro,
      this.crNombre,
      this.crMoto,
      this.crCelular,
      this.crEmail,
      this.crCiudad,
      this.crDetalles,
      this.crRuta,
      this.crCrea,
      this.crCompraMax,
      this.crSync,
      this.cuUsuario,
      this.hoyliquidado});

   factory Lineas.fromJson2(Map<String, dynamic> json) => Lineas(
      crIdcobro: json['cr_idcobro'],
      crNombre: json['cr_nombre'],
      crMoto: json['cr_moto'],
      crCelular: json['cr_celular'],
      crEmail: json['cr_email'],
      crCiudad: json['cr_ciudad'],
      crDetalles: json['cr_detalles'],
      crRuta: json['cr_ruta'],
      crCrea: json['cr_crea'],
      crCompraMax: json['cr_compra_max'],
      crSync: json['cr_sync'],
     cuUsuario:  json['cu_usuario'],
       hoyliquidado :  json['hoyliquidado'],
  );

  Lineas.fromJson(Map<String, dynamic> json) {
    crIdcobro = json['cr_idcobro'];
    crNombre = json['cr_nombre'];
    crMoto = json['cr_moto'];
    crCelular = json['cr_celular'];
    crEmail = json['cr_email'];
    crCiudad = json['cr_ciudad'];
    crDetalles = json['cr_detalles'];
    crRuta = json['cr_ruta'];
    crCrea = json['cr_crea'];
    crCompraMax = json['cr_compra_max'];
    crSync = json['cr_sync'];
    cuUsuario = json['cu_usuario'];
    hoyliquidado = json['hoyliquidado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cr_idcobro'] = this.crIdcobro;
    data['cr_nombre'] = this.crNombre;
    data['cr_moto'] = this.crMoto;
    data['cr_celular'] = this.crCelular;
    data['cr_email'] = this.crEmail;
    data['cr_ciudad'] = this.crCiudad;
    data['cr_detalles'] = this.crDetalles;
    data['cr_ruta'] = this.crRuta;
    data['cr_crea'] = this.crCrea;
    data['cr_compra_max'] = this.crCompraMax;
    data['cr_sync'] = this.crSync;
    data['cu_usuario'] = this.cuUsuario;
    data['hoyliquidado'] = this.hoyliquidado;
    return data;
  }
}
