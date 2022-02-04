import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_liquid/components/fab_bottom_app_bar.dart';
import 'package:flutter_app_liquid/components/indicator_widget.dart';
import 'package:flutter_app_liquid/components/layout.dart';
import 'package:flutter_app_liquid/helpers/Session.dart';
import 'package:flutter_app_liquid/models/Liquidacion.dart';
import 'package:flutter_app_liquid/models/SessionData.dart';
import 'package:flutter_app_liquid/services/liquidacion_service.dart';
import 'package:flutter_app_liquid/store/app_store.dart';
import 'package:flutter_app_liquid/theme/styles.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'HomeLineas.dart';

final themeColor = new Color(0xfff5a623);
final primaryColor = new Color(0xff203152);
final greyColor = new Color(0xffaeaeae);
final greyColor2 = new Color(0xffE8E8E8);

class LiquidacionEntradas {
  double efectivo = 0;
  double gastos = 0;
  double abono_capital = 0;
  double retiros = 0;
  double retiros_socio1 = 0;
  double retiros_socio2 = 0;
  String detalles = "";
}

ProgressDialog pr;

class MyHomePageLiquidacion extends StatefulWidget {
  MyHomePageLiquidacion({this.cobro, this.title, this.usuariolinea});
  final String cobro;
  final String title;
  final String usuariolinea;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageLiquidacion> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];
  LiquidacionEntradas _liquidacionEntradas = new LiquidacionEntradas();
  String _color = '';
  Liquidacion model;
  bool isLoading = false;
  bool isLoadingSave = false;

  String _lastSelected = 'TAB: 0';

  SessionData sessionData;

  int _touchedIndex;

  Color _diferencia_color = Colors.blue;

  final txtBase = TextEditingController();
  final txtGastos = TextEditingController();
  final txtAbonos = TextEditingController();
  final txtCompras = TextEditingController();
  final txtRetiros = TextEditingController();

  final txtEfectivo = TextEditingController();
  double _txtEfectivo = 0;
  final txtAbonoCapital = TextEditingController();
  final txtDescuento = TextEditingController();

  final txtRefinanciacion = TextEditingController();
  final txtdebeCobrar = TextEditingController();
  final txtValorSeguro = TextEditingController();
  final txtDiferencia = TextEditingController();
  final txtTotalSeguro = TextEditingController();
  final txtRetiroSocio1 = TextEditingController();
  final txtRetiroSocio2 = TextEditingController();
  final txtOtrosGastos = TextEditingController();
  final txtDebeCobrar = TextEditingController();
  final txtDetalles = TextEditingController();

/*
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
  liCarteraTotal = json['li_cartera_total'];*/

  InputDecoration TextfieldDifDecorOk(BuildContext context, String hint) =>
      InputDecoration(
          isDense: true,
          filled: true,
          fillColor: _diferencia_color,
          //icon: const Icon(Icons.person),
          //suffixIcon: Icon(Icons.remove_red_eye),
          hintText: '',
          labelText: 'Diferencia',
          labelStyle: TextStyle(fontSize: 13, color: Colors.white));

  Getdata() async {
    Liquidacion result =
        await liquidacionStore.StoreGetLiquidacionList(widget.cobro);

    setState(() {
      model = result;
      txtBase.text = model.liBase;
      txtGastos.text = model.liGastos;
      txtAbonos.text = model.liAbono;
      txtCompras.text = model.liPrestamo;
      txtRetiros.text = "0";
      //txtEfectivo.text = "0";
      txtDescuento.text = model.liDescuento;
      txtTotalSeguro.text = model.liValorSeguro;
      txtDiferencia.text = model.liDiferencia.toString();
      txtDebeCobrar.text = model.debeCobrar.toString();
      txtRefinanciacion.text = model.liRefinanciacion.toString();
      _diferencia_color = double.parse(txtDiferencia.text.toString()) == 0
          ? Colors.blue
          : Colors.red;
    });
  }

  openAlertBoxGuardarLiquidacion() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Liquidacion",
                          style: TextStyle(fontSize: 11.0.sp),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.attach_money,
                              color: Colors.teal,
                              size: 13.0.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nota".toUpperCase(),
                          style: textGreyBold,
                        ),
                        Text(
                          "Tienes una diferencia de :",
                          style: textStyle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "\$" + txtDiferencia.text.toString(),
                          style: TextStyle(
                            color: _diferencia_color,
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "¿ deseas guardar esta liquidacion con esta diferencia ?",
                          style: textStyleSubtitle,
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new Center(
                child: new RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: 10.0.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              new Center(
                child: new RaisedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await new Future.delayed(const Duration(seconds: 1));
                    GuardarLiquidacion();
                  },
                  color: Colors.lightBlue,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Liquidar',
                          style: TextStyle(
                            fontSize: 10.0.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  GuardarLiquidacion() async {
    setState(() {
      isLoadingSave = true;
    });

    pr = new ProgressDialog(context,
        isDismissible: false, type: ProgressDialogType.Download);
    pr.show();

    pr.update(
      message: "Enviando liquidacion, espere un momento...",
      progressWidget: Container(
          padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 9.5.sp, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 11.5.sp, fontWeight: FontWeight.w500),
    );

    double _base = double.parse(
        txtBase.text.isNullOrEmpty() ? "0" : txtBase.text.toString());
    double _abonos = double.parse(
        txtAbonos.text.isNullOrEmpty() ? "0" : txtAbonos.text.toString());
    double _gastos = double.parse(
        txtGastos.text.isNullOrEmpty() ? "0" : txtGastos.text.toString());
    double _compras = double.parse(
        txtCompras.text.isNullOrEmpty() ? "0" : txtCompras.text.toString());
    double _retiro_socio1 = double.parse(
        txtRetiros.text.isNullOrEmpty() ? "0" : txtRetiros.text.toString());
    double _otros_gastos = double.parse(txtOtrosGastos.text.isNullOrEmpty()
        ? "0"
        : txtOtrosGastos.text.toString());
    double _abonos_capital = double.parse(txtAbonoCapital.text.isNullOrEmpty()
        ? "0"
        : txtAbonoCapital.text.toString());
    double _efectivo = double.parse(
        txtEfectivo.text.isNullOrEmpty() ? "0" : txtEfectivo.text.toString());
    double _total_seguro = double.parse(txtTotalSeguro.text.isNullOrEmpty()
        ? "0"
        : txtTotalSeguro.text.toString());
    double _retiro_socio2 = double.parse(txtRetiroSocio1.text.isNullOrEmpty()
        ? "0"
        : txtRetiroSocio1.text.toString());
    double _retiro_socio3 = double.parse(txtRetiroSocio2.text.isNullOrEmpty()
        ? "0"
        : txtRetiroSocio2.text.toString());
    double _refinanciacion = double.parse(txtRefinanciacion.text.isNullOrEmpty()
        ? "0"
        : txtRefinanciacion.text.toString());
    double _descuento = double.parse(
        txtDescuento.text.isNullOrEmpty() ? "0" : txtDescuento.text.toString());
    String _detalles =
        txtDetalles.text.isNullOrEmpty() ? "0" : txtDetalles.text.toString();
    double _diferencia = double.parse(txtDiferencia.text.isNullOrEmpty()
        ? "0"
        : txtDescuento.text.toString());
    double _debecobrar = double.parse(txtdebeCobrar.text.isNullOrEmpty()
        ? "0"
        : txtdebeCobrar.text.toString());
    double _carteratotal = double.parse(model.liCarteraTotal.isNullOrEmpty()
        ? "0"
        : model.liCarteraTotal.toString());
    double _numcarteratotal = double.parse(
        model.liNumCarteraTotal.isNullOrEmpty()
            ? "0"
            : model.liNumCarteraTotal.toString());
    double _carteravencida = double.parse(model.liCarteraVencida.isNullOrEmpty()
        ? "0"
        : model.liCarteraVencida.toString());
    double _numcarteravencida = double.parse(
        model.liNumCarteraVencida.isNullOrEmpty()
            ? "0"
            : model.liNumCarteraVencida.toString());
    double _abonosvencidos = double.parse(model.abonosVencidos.isNullOrEmpty()
        ? "0"
        : model.abonosVencidos.toString());
    double _numabonos = double.parse(
        model.liNumAbono.isNullOrEmpty() ? "0" : model.liNumAbono.toString());

    var body = json.encode({
      "li_cobro": int.parse(widget.cobro.toString()),
      "li_base": _base,
      "li_abono": _abonos,
      "li_prestamo": _compras,
      "li_gastos": _gastos,
      "li_efectivo": _efectivo,
      "li_refinanciacion": _refinanciacion,
      "li_descuento": _descuento,
      "li_retiro": _retiro_socio1,
      "li_otros_gastos": _otros_gastos,
      "li_abono_capital": _abonos_capital,
      "li_detalle": _detalles,
      "li_diferencia": _diferencia,
      "li_total_seguro": _total_seguro,
      "li_debe_cobrar": _debecobrar,
      "li_cartera_total": _carteratotal,
      "li_num_cartera_total": _numcarteratotal,
      "li_cartera_vencida": _carteravencida,
      "li_num_cartera_vencida": _numcarteravencida,
      "li_abonos_vencidos": _abonosvencidos,
      "li_total_clientes_abonos": _numabonos,
      "li_retiro_socio1": _retiro_socio2,
      "li_retiro_socio2": _retiro_socio3,
      'li_usuario_id': sessionData?.us_idusuario.toString(),
      'li_usuario_linea_id': widget.usuariolinea.toString(),
    });

    await new Future.delayed(const Duration(seconds: 3));

    var jsonr = await LiquidacionService.GuardarLiquidacion(body);
    print(jsonr);
    Future.delayed(Duration(seconds: 1)).then((value) {
      pr.hide().whenComplete(() async {
        if (jsonr["type"] == "error") {
          Fluttertoast.showToast(
              msg: jsonr["message"].toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 40,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 10.0.sp);
        } else {

          Fluttertoast.showToast(
              msg: jsonr["message"].toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.lightBlue,
              textColor: Colors.white,
              fontSize: 12.0);

          await new Future.delayed(const Duration(seconds: 1));

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeLineasPage()),
                  (Route<dynamic> route) => false);
        }

      });
    });

    await new Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoadingSave = false;
    });
  }

  CalcularLiquidacion() {
    double _base = double.parse(
        txtBase.text.isNullOrEmpty() ? "0" : txtBase.text.toString());
    double _abonos = double.parse(
        txtAbonos.text.isNullOrEmpty() ? "0" : txtAbonos.text.toString());
    double _gastos = double.parse(
        txtGastos.text.isNullOrEmpty() ? "0" : txtGastos.text.toString());
    double _compras = double.parse(
        txtCompras.text.isNullOrEmpty() ? "0" : txtCompras.text.toString());
    double _retiro_socio1 = double.parse(
        txtRetiros.text.isNullOrEmpty() ? "0" : txtRetiros.text.toString());
    double _otros_gastos = double.parse(txtOtrosGastos.text.isNullOrEmpty()
        ? "0"
        : txtOtrosGastos.text.toString());
    double _abonos_capital = double.parse(txtAbonoCapital.text.isNullOrEmpty()
        ? "0"
        : txtAbonoCapital.text.toString());
    double _efectivo = double.parse(
        txtEfectivo.text.isNullOrEmpty() ? "0" : txtEfectivo.text.toString());
    double _total_seguro = double.parse(txtTotalSeguro.text.isNullOrEmpty()
        ? "0"
        : txtTotalSeguro.text.toString());
    double _retiro_socio2 = double.parse(txtRetiroSocio1.text.isNullOrEmpty()
        ? "0"
        : txtRetiroSocio1.text.toString());
    double _retiro_socio3 = double.parse(txtRetiroSocio2.text.isNullOrEmpty()
        ? "0"
        : txtRetiroSocio2.text.toString());

    double _retiro = _retiro_socio1 + _retiro_socio2 + _retiro_socio3;
    print(_retiro);
    double salidas = _gastos +
        _compras +
        _abonos_capital +
        _otros_gastos +
        _efectivo +
        _retiro;
    double entradas = _base + _abonos;

    double dif = salidas - entradas;

    dif = dif.isNaN ? 0 : dif;

    setState(() {
      txtDiferencia.text = dif.toString();
      _diferencia_color = dif == 0 ? Colors.blue : Colors.red;
    });

    // txtDiferencia.text = model.liDiferencia.toString();

    /*Fluttertoast.showToast(
        msg: txtEfectivo.text.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);*/
  }

  // Here we will show different type of graph on different scenario touch and non touch
  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == _touchedIndex;
      // Increase the radius of section when touched, we will see it in action in a minute
      final double radius = isTouched ? 30 : 20;

      // Ideally this data come from API and then returned, or you can modify it any way as per the data arranged in your app :)
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: CustomColors.kLightPinkColor,
              value: 33.33,
              title: '', // this cannot be left blank
              radius: radius);
        case 1:
          return PieChartSectionData(
              color: CustomColors.kPrimaryColor,
              value: 33.33,
              title: '', // this cannot be left blank
              radius: radius);
        case 2:
          return PieChartSectionData(
              color: CustomColors.kCyanColor,
              value: 33.33,
              title: '', // this cannot be left blank
              radius: radius);
        default:
          return null;
      }
    });
  }

  /*
  * OPCIONES EN EL TAB
  * SI ES ABONAR , ELIMINAR , OPCIONES
  */
  void _selectedTab(int index) {
    print("Selecccion " + index.toString());
    setState(() {
      _lastSelected = 'TAB: $index';
    });

    const List<Key> keys = [
      Key("Network"),
      Key("NetworkDialog"),
      Key("Flare"),
      Key("FlareDialog"),
      Key("Asset"),
      Key("AssetDialog")
    ];

    switch (index) {
      case 0:
        break;

      case 1:
        break;

      case 2:
        break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Getdata();
    GetSession();

    super.initState();
  }

  GetSession() async {
    SessionData sessdata = await Session.getSession();
    setState(() {
      sessionData = sessdata;
    });
  }

  Widget _buildFab(BuildContext context) {
    final theme = Theme.of(context);
    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
        );
      },
      child: FloatingActionButton(
        onPressed: !isLoadingSave
            ? () async {
                CalcularLiquidacion();
                await new Future.delayed(const Duration(seconds: 1));
                openAlertBoxGuardarLiquidacion();
              }
            : null,
        tooltip: 'Guardar liquidacion',
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        elevation: 2.0,
        backgroundColor: theme.buttonColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _user = new TextEditingController();
    TextEditingController _pass = new TextEditingController();
    var size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Observer(
        builder: (_) => new Scaffold(
              appBar: new AppBar(
                title: ListTile(
                  dense: true,
                  title: Text("LIQUIDAR",
                      style: theme.textTheme.headline4,
                      textAlign: TextAlign.left),
                  subtitle: Text(
                    widget.title.toString(),
                    style: theme.textTheme.subtitle2,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // do something
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // do something
                    },
                  )
                ],
              ),
              bottomNavigationBar: FABBottomAppBar(
                centerItemText: ' ',
                color: Colors.grey,
                selectedColor: Colors.teal,
                notchedShape: CircularNotchedRectangle(),
                onTabSelected: _selectedTab,
                estado: null,
                items: [
                  FABBottomAppBarItem(
                      iconData: Icons.save,
                      text: 'Guardar \nliquidacion',
                      text2: ""),
                  FABBottomAppBarItem(
                    iconData: Icons.lock_outline,
                    text: 'Autorizacion de compras',
                    text2: "",
                  ),
                  FABBottomAppBarItem(
                    iconData: Icons.insert_drive_file,
                    text: 'Reportes y consultas',
                    text2: "",
                  ),
                  FABBottomAppBarItem(
                    text2: "12000",
                    text: "detalles",
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: _buildFab(context),
              body: liquidacionStore.loading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                        ),
                      ),
                      color: Colors.white.withOpacity(0.8),
                    )
                  : new SafeArea(
                      top: false,
                      bottom: false,
                      child: new Form(
                          key: _formKey,
                          autovalidate: true,
                          child: new ListView(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                      height: 18.0.h,
                                      child: Card(
                                        color: theme.backgroundColor,
                                        elevation: 0.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 40.0.w,
                                              // Pie Chart is available in fl_chart package
                                              child: PieChart(
                                                PieChartData(
                                                  borderData:
                                                      FlBorderData(show: false),
                                                  centerSpaceRadius: 25.0,
                                                  sectionsSpace: 0.0,
                                                  startDegreeOffset: 30,
                                                  // actual curves and data come from this function result.
                                                  sections: showingSections(),
                                                  // This is to make chart interactive when someone touch
                                                  pieTouchData: PieTouchData(
                                                    touchCallback:
                                                        (pieTouchResponse) {
                                                      setState(() {
                                                        if (pieTouchResponse
                                                                    .touchInput
                                                                is FlLongPressEnd ||
                                                            pieTouchResponse
                                                                    .touchInput
                                                                is FlPanEnd) {
                                                          _touchedIndex = -1;
                                                        } else {
                                                          _touchedIndex =
                                                              pieTouchResponse
                                                                  .touchedSectionIndex;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: 5,
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 1),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    IndicatorWidget(
                                                      color: CustomColors
                                                          .kPrimaryColor,
                                                      iconPath:
                                                          'assets/images/icons/billing.svg',
                                                      title: 'COBRADO',
                                                      subtitle: '\$2500',
                                                    ),
                                                    IndicatorWidget(
                                                      color: CustomColors
                                                          .kCyanColor,
                                                      iconPath:
                                                          'assets/images/icons/money.svg',
                                                      title: 'ABONADO',
                                                      subtitle: '\$2000',
                                                    ),
                                                    IndicatorWidget(
                                                      color: CustomColors
                                                          .kLightPinkColor,
                                                      iconPath:
                                                          'assets/images/icons/cartera.svg',
                                                      title: 'CARTERA',
                                                      subtitle: '\$' +
                                                          model.liCarteraTotal
                                                              .toString(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  /* Padding(
                            padding: EdgeInsets.only(top: 4),
                          ),
                          Text("Usuario : jairo torres",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black26)),
                          Divider(),*/
                                  new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new TextFormField(
                                            controller: txtBase,
                                            decoration: const InputDecoration(
                                                isDense: true,
                                                filled: true,
                                                //icon: const Icon(Icons.person),
                                                //suffixIcon: Icon(Icons.remove_red_eye),
                                                labelText: 'Base',
                                                labelStyle:
                                                    TextStyle(fontSize: 14)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new TextFormField(
                                            controller: txtGastos,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                //suffixIcon:  const Icon(Icons.remove_red_eye),
                                                suffixIcon: IconButton(
                                                  onPressed: () => null,
                                                  icon: Icon(
                                                      Icons.remove_red_eye),
                                                ),
                                                hintText: '0',
                                                labelText: 'Gastos',
                                                labelStyle:
                                                    TextStyle(fontSize: 14)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new TextFormField(
                                            controller: txtAbonos,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                //suffixIcon:  const Icon(Icons.remove_red_eye),
                                                suffixIcon: IconButton(
                                                  onPressed: () => null,
                                                  icon: Icon(
                                                      Icons.remove_red_eye),
                                                ),
                                                hintText: '0',
                                                labelText: 'Abonos',
                                                labelStyle:
                                                    TextStyle(fontSize: 14)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                  ),
                                  new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new TextFormField(
                                            controller: txtRetiros,
                                            decoration: const InputDecoration(
                                                isDense: true,
                                                //icon: const Icon(Icons.person),
                                                //suffixIcon: Icon(Icons.remove_red_eye),
                                                hintText: 'Retiros',
                                                labelText: 'Retiros',
                                                labelStyle:
                                                    TextStyle(fontSize: 14)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: new TextFormField(
                                            controller: txtCompras,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                //suffixIcon:  const Icon(Icons.remove_red_eye),
                                                suffixIcon: IconButton(
                                                  onPressed: () => null,
                                                  icon: Icon(
                                                      Icons.remove_red_eye),
                                                ),
                                                hintText: '0',
                                                labelText: 'Compras',
                                                labelStyle:
                                                    TextStyle(fontSize: 14)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new TextFormField(
                                            controller: txtEfectivo,
                                            keyboardType: TextInputType.number,
                                            onChanged: (String value) async {
                                              /*if(value.isNullOrEmpty()){
                                                setState(() {
                                                  txtEfectivo.text = "0";
                                                });
                                              }*/
                                              CalcularLiquidacion();
                                            },
                                            //autofocus: true,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                //suffixIcon:  const Icon(Icons.remove_red_eye),
                                                suffixIcon: IconButton(
                                                  onPressed: () => null,
                                                  icon: Icon(
                                                      Icons.remove_red_eye),
                                                ),
                                                hintText: '0',
                                                labelText: 'Efectivo',
                                                labelStyle:
                                                    TextStyle(fontSize: 14)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                  ),
                                  new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: new TextFormField(
                                            controller: txtAbonoCapital,
                                            decoration: const InputDecoration(
                                                isDense: true,
                                                //icon: const Icon(Icons.person),
                                                //suffixIcon: Icon(Icons.remove_red_eye),
                                                hintText: 'Abono de capital',
                                                labelText: 'Abono a capital',
                                                labelStyle:
                                                    TextStyle(fontSize: 14)),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: new TextFormField(
                                            controller: txtDescuento,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                //suffixIcon:  const Icon(Icons.remove_red_eye),
                                                suffixIcon: IconButton(
                                                  onPressed: () => null,
                                                  icon: Icon(
                                                      Icons.remove_red_eye),
                                                ),
                                                hintText: '0',
                                                labelText: 'Descuento',
                                                labelStyle:
                                                    TextStyle(fontSize: 13)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: new TextFormField(
                                            controller: txtOtrosGastos,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                //suffixIcon:  const Icon(Icons.remove_red_eye),
                                                suffixIcon: IconButton(
                                                  onPressed: () => null,
                                                  icon: Icon(
                                                      Icons.remove_red_eye),
                                                ),
                                                hintText: '0',
                                                labelText: 'O. gastos',
                                                labelStyle:
                                                    TextStyle(fontSize: 13)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                  ),
                                  new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: new TextFormField(
                                              style: new TextStyle(
                                                fontWeight: FontWeight.w200,
                                                color: Colors.white,
                                                fontSize: 17.0,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: txtDiferencia,
                                              decoration: TextfieldDifDecorOk(
                                                  context, "Diferencia")),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: new TextFormField(
                                            controller: txtRefinanciacion,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                filled: true,

                                                //suffixIcon:  const Icon(Icons.remove_red_eye),
                                                suffixIcon: IconButton(
                                                  onPressed: () => null,
                                                  icon: Icon(
                                                      Icons.remove_red_eye),
                                                ),
                                                hintText: '0',
                                                labelText: 'Refinanciacion',
                                                labelStyle:
                                                    TextStyle(fontSize: 13)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                  ),
                                  new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: new TextFormField(
                                            controller: txtRetiroSocio1,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                filled: true,
                                                hintText: '0',
                                                labelText: 'Retiro socio 1',
                                                labelStyle:
                                                    TextStyle(fontSize: 13)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: new TextFormField(
                                            controller: txtRetiroSocio2,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                filled: true,
                                                hintText: '0',
                                                labelText: 'Retiro socio 2',
                                                labelStyle:
                                                    TextStyle(fontSize: 13)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                  ),
                                  new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: new TextFormField(
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                filled: true,
                                                hintText: '0',
                                                labelText: 'Base del cobrador',
                                                labelStyle:
                                                    TextStyle(fontSize: 13)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: new TextFormField(
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                filled: true,
                                                hintText: '0',
                                                labelText:
                                                    'Eefectivo a entregar',
                                                labelStyle:
                                                    TextStyle(fontSize: 12)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                  ),
                                  new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: new TextFormField(
                                            controller: txtTotalSeguro,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                filled: true,
                                                hintText: '0',
                                                labelText: 'Total seguros',
                                                labelStyle:
                                                    TextStyle(fontSize: 13)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: new TextFormField(
                                            controller: txtDebeCobrar,
                                            enabled: false,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                filled: true,
                                                hintText: '0',
                                                labelText: 'Debe de cobrar',
                                                labelStyle:
                                                    TextStyle(fontSize: 12)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 4),
                                  ),
                                  new Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: new Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: new TextFormField(
                                            controller: txtDetalles,
                                            decoration: InputDecoration(
                                                // icon: const Icon(Icons.remove_red_eye),
                                                isDense: true,
                                                filled: true,
                                                hintText: '0',
                                                labelText: 'Detalles',
                                                labelStyle:
                                                    TextStyle(fontSize: 12)
                                                //suffixStyle: TextStyle(fontSize: 18)
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ))),
            ));
  }
}
