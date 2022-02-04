import 'dart:convert';
import 'package:flutter_app_liquid/constants/database_strings.dart';
import 'package:flutter_app_liquid/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager  {
 /*Declaramos una variable global accesible para capturar el token*/
  static String auth_token = "auth_token";
  //set data into shared preferences like this
  static Future<void> setAuthToken(String _auth_token) async {
    SessionManager sm;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(auth_token, _auth_token);
  }

//get value from shared preferences
  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String _auth_token;
    _auth_token = pref.getString(auth_token) ?? "mi tokens null";
    return _auth_token;
  }

  static Future<int> getLoggedInUser2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userId);
  }

  static Future<bool> setLoggedInUser2(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(userId, value);
  }

  static Future<User> setLoggedInUser(User value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setAuthToken(value.tokens);
    String user = jsonEncode(value);
    prefs.setString(ArrayUsers, user);
    return value;
  }

  static Future<User> getLoggedInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map userMap = jsonDecode(prefs.getString(ArrayUsers));
    User user = User.fromJson(userMap);
    return user;
  }
}
