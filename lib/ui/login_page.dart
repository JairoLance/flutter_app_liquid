import 'package:flutter/material.dart';
import 'package:flutter_app_liquid/components/Animation/FadeAnimation.dart';
import 'package:flutter_app_liquid/models/MemberLogin.dart';
import 'package:flutter_app_liquid/models/user.dart';
import 'package:flutter_app_liquid/store/app_store.dart';
import 'package:flutter_app_liquid/ui/HomeLineas.dart';
import 'package:flutter_app_liquid/ui/HomePage.dart';
import 'package:flutter_app_liquid/ui/HomePageTab.dart';
import 'package:flutter_app_liquid/ui/HomePageTabDy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import 'navigator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class LoginRequestData {
  String email = '';
  String password = '';
}

class FormValidator {
  static FormValidator _instance;
  factory FormValidator() => _instance ??= new FormValidator._();
  FormValidator._();

  String validatePassword(String value) {
    String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "Password es requerido";
    } else if (value.length <= 2) {
      return "Mínimo de 3 caracteres";
      /*/} else if (!regExp.hasMatch(value)) {
      return "Contraseña al menos una letra mayúscula, una letra minúscula y un número";*/
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^&lt;&gt;()[\]\\.,;:\s@\"]+(\.[^&lt;&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Email o usuario is requerido";
      /* } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";*/
    } else {
      return null;
    }
  }
}

class _LoginPage extends State<LoginPage> {
  GlobalKey<FormState> _key1 = new GlobalKey();
  final _key = GlobalKey<FormState>();

  LoginRequestData _loginData = LoginRequestData();
  bool _validate = false;
  bool _obscureText = true;
  bool _isSelected = false;
  bool _isLoading = false;

  final txtUsuario = TextEditingController();
  final txtpassword = TextEditingController();

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  void initState() {
    setState(() {
      txtUsuario.text = "ADMIN";
      txtpassword.text = "123";
      userStore.setUserName("ADMIN");
      userStore.setPassword("123");
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  _validateForm() async {
    if (userStore.currentUser.password != null) {
      MemberLogin result = await userStore.login();

      //print(userStore.memberlogin);

      Fluttertoast.showToast(
          msg: result.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
//HomePageTabDy()
      if (result.type == "success") {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pushReplacement(
              createRoute(HomeLineasPage()));
        });
      }
    } else {
      _key.currentState.validate();
    }

    /*
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageTabDy()),
      );
    */
  }

  signIn(String usuario, String pass) async {
    try {} catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _sendToServer() async {
    try {} catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePageTabDy()),
    );
    print("nnn " + result);
  }

  Widget _getFormUI() {
    final theme = Theme.of(context);
    return new Column(
      children: <Widget>[
        FadeAnimation(
            1.8,
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(143, 148, 251, .2),
                        blurRadius: 3.0,
                        offset: Offset(0, 10))
                  ]),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[100]))),
                    child: TextFormField(
                      //controller: txtUsuario,
                      initialValue: userStore.user.username,
                      onChanged: (user) => userStore.setUserName(user),
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Email o usuario',
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      validator: FormValidator().validateEmail,
                      onSaved: (String value) {
                        _loginData.email = value;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      autofocus: false,
                      //controller: txtpassword,
                      initialValue: userStore.user.password,
                      obscureText: _obscureText,
                      onChanged: (password) => userStore.setPassword(password),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        fillColor: Colors.pink,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            semanticLabel: _obscureText
                                ? 'show password'
                                : 'hide password',
                          ),
                        ),
                      ),
                      /*validator: FormValidator().validatePassword,
                        onSaved: (String value) {
                          print(value);
                          _loginData.password = value;
                        }*/
                    ),
                  )
                ],
              ),
            )),
        SizedBox(
          height: 30,
        ),
        FadeAnimation(
          2,
          Container(
            width: 230,
            height: 50,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF6078ea).withOpacity(.3),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0)
                ]),
            child: Material(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(6.0),
              child: userStore.loading
                  ? Center(
                      child: new CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.white54)))
                  : InkWell(
                      onTap: () async {},
                      child: RaisedButton(
                        onPressed: () async {
                          /*setState(() {
                      _isLoading = true;
                    });

                    _sendToServer();*/
                          _validateForm();
                        },
                        elevation: 0.0,
                        color: Colors.pinkAccent,
                        child: Text("CONECTAR",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins-Bold",
                                fontSize: 16,
                                letterSpacing: 1.0)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        FadeAnimation(
            1.8,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {},
                  child: Text("¿ Olvido su contraseña ?",
                      style: TextStyle(color: Colors.pinkAccent)),
                )
              ],
            )
        ),
        /*  FadeAnimation(
                            1.5,
                            Text(
                              "¿ Olvido su contraseña ?",
                              style: TextStyle(color: Colors.teal),
                            )),*/
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        FadeAnimation(
            1.8,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "¿ Crear nueva cuenta ? ",
                  style: TextStyle(fontFamily: "Poppins-Medium"),
                ),
                InkWell(
                  onTap: () {
                    //signIn1();
                  },
                  child: Text("registrarse ahora",
                      style: TextStyle(
                          color: Colors.pinkAccent, fontFamily: "Poppins-Bold")),
                )
              ],
            )),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(10),
        ),
        FadeAnimation(
            2.0,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Todos los derechos reservados.",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: ScreenUtil.getInstance().setSp(16),
                        fontFamily: "Poppins-Bold",
                        letterSpacing: .6)),
              ],
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    return Observer(
        builder: (_) => Scaffold(
            backgroundColor: Colors.white,
            body: Stack(fit: StackFit.expand, children: <Widget>[
              /* Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
               // child: Image.asset('assets/images/login_1.png'),
              ),
              Expanded(
                child: Container(),
              ),
              //Image.asset("assets/image_02.png")
            ],
          ),*/
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 70.0.w,
                        alignment: Alignment.center,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 25.0, 0.0, 0.0),
                              child: new Image.asset(
                                'assets/images/logo_liq.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            new Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: new Center(
                                child: new Text(
                                  "Entrada",
                                  style: new TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(20.0),
                          child: new Form(
                            key: _key,
                            autovalidate: _validate,
                            child: _getFormUI(),
                          ))
                    ],
                  ),
                ),
              )
            ])));
  }
}
