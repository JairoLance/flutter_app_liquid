extension Extension on Object {
  bool isNullOrEmpty() => this == null || this == '';

  bool isNullEmptyOrFalse() => this == null || this == '' || !this;

  bool isNullEmptyZeroOrFalse() =>
      this == null || this == '' || !this || this == 0;
}

class Liquidacion {
  String abonosVencidos;
  String liValorSeguro;
  String liIdliquidacion;
  String liBase;
  String liPrestamo;
  String liPorcentajeCarteraVencida;
  String liAbono;
  String liNumAbono;
  String liGastos;
  String liDescuento;
  String liRefinanciacion;
  String debeCobrar;
  String liNumCarteraVencida;
  String liCarteraVencida;
  String liNumCarteraTotal;
  String liCarteraTotal;
  double liDiferencia;

  Liquidacion(
      {this.abonosVencidos,
      this.liValorSeguro,
      this.liIdliquidacion,
      this.liBase,
      this.liPrestamo,
      this.liPorcentajeCarteraVencida,
      this.liAbono,
      this.liNumAbono,
      this.liGastos,
      this.liDescuento,
      this.liRefinanciacion,
      this.debeCobrar,
      this.liNumCarteraVencida,
      this.liCarteraVencida,
      this.liNumCarteraTotal,
      this.liCarteraTotal,
      this.liDiferencia});

  Liquidacion.fromJson(Map<String, dynamic> json) {
    abonosVencidos = json['abonos_vencidos'];
    liValorSeguro = json['li_valor_seguro'];
    liIdliquidacion = json['li_idliquidacion'];
    liBase = json['li_base'];
    liPrestamo = json['li_prestamo'];
    liPorcentajeCarteraVencida = json['li_porcentaje_cartera_vencida'];
    liAbono = json['li_abono'];
    liNumAbono = json['li_num_abono'];
    liGastos = json['li_gastos'];
    liDescuento = json['li_descuento'];
    liRefinanciacion = json['li_refinanciacion'];
    debeCobrar = json['debe_cobrar'];
    liNumCarteraVencida = json['li_num_cartera_vencida'];
    liCarteraVencida = json['li_cartera_vencida'];
    liNumCarteraTotal = json['li_num_cartera_total'];
    liCarteraTotal = json['li_cartera_total'];
    double salidas =
        double.parse(json['li_gastos']) + double.parse(json['li_prestamo']);
    double entrada =
        double.parse(json['li_base']) + double.parse(json['li_abono']);
    double result = salidas - entrada;
    liDiferencia = result.isNaN ? 0 : result;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['abonos_vencidos'] = this.abonosVencidos;
    data['li_valor_seguro'] = this.liValorSeguro;
    data['li_idliquidacion'] = this.liIdliquidacion;
    data['li_base'] = this.liBase;
    data['li_prestamo'] = this.liPrestamo;
    data['li_porcentaje_cartera_vencida'] = this.liPorcentajeCarteraVencida;
    data['li_abono'] = this.liAbono;
    data['li_num_abono'] = this.liNumAbono;
    data['li_gastos'] = this.liGastos;
    data['li_descuento'] = this.liDescuento;
    data['li_refinanciacion'] = this.liRefinanciacion;
    data['debe_cobrar'] = this.debeCobrar;
    data['li_num_cartera_vencida'] = this.liNumCarteraVencida;
    data['li_cartera_vencida'] = this.liCarteraVencida;
    data['li_num_cartera_total'] = this.liNumCarteraTotal;
    data['li_cartera_total'] = this.liCarteraTotal;
    return data;
  }
}
