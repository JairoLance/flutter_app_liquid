import 'dart:convert';
import 'package:flutter_app_liquid/constants/database_strings.dart';
import 'package:flutter_app_liquid/models/SessionData.dart';
import 'package:flutter_app_liquid/models/user.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<SessionData> getSession() async {
    if(await FlutterSession().get("SessionData") != null) {
      Map<String, dynamic> flutterSession = await FlutterSession().get(
          "SessionData");
      SessionData sessdata = SessionData.fromJson(flutterSession);
      return sessdata;
    }else{
      return null;
    }
  }

  static Clear() async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    sharedPreferences.commit();
  }
}
