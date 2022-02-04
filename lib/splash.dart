import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_liquid/ui/HomeLineas.dart';
import 'package:flutter_app_liquid/ui/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/Session.dart';
import 'models/Lineas.dart';
import 'models/SessionData.dart';

class SplashPage extends StatefulWidget {
  static String splash = "splash";

  @override
  SplashPageState createState() {
    return new SplashPageState();
  }
}

class SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimationController;
  CurvedAnimation _iconAnimation;
  SharedPreferences sharedPreferences;

  void handleTimeout() {
    checkLoginStatus();
    /*
    Navigator.of(context).pushReplacement(
        // ignore: strong_mode_invalid_cast_new_expr
        //new MaterialPageRoute(builder: (BuildContext context) => new WhatsAppHome()));

        new MaterialPageRoute(builder: (BuildContext context) => new LoginPage()));*/
  }

  startTimeout() async {
    var duration = const Duration(seconds: 4);
    return new Timer(duration, handleTimeout);
  }

  bool _visible = true;
  @override
  void initState() {
    super.initState();
    //Timer(Duration(seconds: 5),()=> print(''));

    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 3000));

    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeIn);
    _iconAnimation.addListener(() => this.setState(() {}));

    _iconAnimationController.forward();

    startTimeout();
  }

  /*Verificamos que ruta debe de acceder segun sea la validacion correspondiente*/
  checkLoginStatus() async {
    //await Session.Clear();
    var sessiondata = await Session.getSession();
    //await Session.Clear();
    //List<Lineas> dataLineas = sessdata.data;
    if (sessiondata == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      //var datas = json.encode(sessiondata);
      //Map<String, dynamic> s = jsonDecode(datas);
      //var s = jsonDecode(datas);
      //var x = s['data'];
      // Map<String, dynamic> ssss = json.decode(datas);
      //var lin = (ssss as List)?.map((i) => Lineas.fromJson(i)).toList();
      // var s = (lin as List)?.map((i) => Lineas.fromJson(i)).toList();
      // var lis = (ssss as List)?.map((i) => Lineas.fromJson(i)).toList();
      //var lll = List<Lineas>.from(ssss);
      /* List<Lineas> lineas =  (datas as List)?.map((i) => Lineas.fromJson(i)).toList();
      List<dynamic>  output = json.decode(datas);*/
      //List<Lineas> list = List<Lineas>.from(s['data'].map((x) => Lineas.fromJson(x)));
      //print(json.encode(sessiondata.data));
      //Bien
      //List<dynamic> jso = jsonDecode(json.encode(sessiondata.data));

      /*var list = jsonDecode(json.encode(sessiondata.data)) as List;
      var itemsList = list.map((i) => Lineas.fromJson(i)).toList();*/
      //print(jso[0]["cr_nombre"]);
      /*List<Lineas> listLineas; ;
      Lineas l;
      listLineas = (jso as List)?.map((i) => Lineas.fromJson2(i)).toList();
      (jso as List).forEach((k) {
        print(k['cr_nombre']);
        l = new Lineas(crNombre: k['cr_nombre'],crEmail: k['cr_nombre']);
        listLineas.add(l);
      });
      List<Lineas> ksksks = listLineas;
      print(ksksks);*/

      //List<Lineas> list = List<Lineas>.from(json.encode(sessiondata.data)).toList();
      //List<Lineas> li =  (s['data'] as List)?.map((i) => Lineas.fromJson(i)).toList();
      //print(li);
      //print(listLineas);

      if (sessiondata.token == null || sessiondata.us_usuario == '') {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            (Route<dynamic> route) => false);
      } else {

       // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeLineasPage()));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => HomeLineasPage()),
            (Route<dynamic> route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(decoration: BoxDecoration(color: Colors.white)),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Image.asset('assets/images/logo_liq.png'),
                    ),
                    /* Padding(
                        padding: EdgeInsets.only(top:20.0),
                      ),*/
                    /*Text(
                          "Pressta",
                             textAlign: TextAlign.center, style: TextStyle(
                             color:Colors.purple,
                             fontSize: 24.0,
                             fontWeight: FontWeight.bold
                           ),
                      )*/
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.purple)),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text("Procesando... ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )
          ])
        ],
      ),
    );
  }
}
