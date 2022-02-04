import 'dart:convert';
import 'package:flutter_app_liquid/constants/api_routes.dart';
import 'package:flutter_app_liquid/models/user.dart';
import 'package:http/http.dart' as http;
import 'base_service.dart';

class UserService extends BaseService {

  login(User user) async {
    //print("Veri ... " + user.toString());
    //print(Uri.encodeFull(BASE_URL + USER + LOGIN));
    var data = json.encode({'username': user.username , 'password':user.password});
    // var response = await http.post(BASE_URL + USER + LOGIN, body: json.encode(user.toJson()),headers: { 'Content-type': 'application/json'});
    var response = await this.post(Uri.encodeFull(BASE_URL + USER + LOGIN),
        body: data, headers: {"Authorization": ""});
    var jsondata = json.decode(response.body);
    //print(jsondata["message"]);
    var success = jsonDecode(response.body);
    return success;
  }

  login1(User user) async {
    print("Veri ... " + user.toString());
    print(Uri.encodeFull(BASE_URL + USER + LOGIN));
    var data = json.encode({'grupo_id': ""});
    // var response = await http.post(BASE_URL + USER + LOGIN, body: json.encode(user.toJson()),headers: { 'Content-type': 'application/json'});
    var response = await http.post(Uri.encodeFull(BASE_URL + USER + LOGIN),
        body: data, headers: {"Accept": "application/json"});

    var jsondata = json.decode(response.body);
    print(jsondata["message"]);
    var success = jsonDecode(response.body);

    return success;
  }

  getUser(int id) async {
    /*Response response = await client.get(BASE_URL + USER + '/$id');
    return User.fromJson(jsonDecode(response.body)["usuario"]);*/
  }

  getUsers() async {
    /* Response response = await client.get(BASE_URL + USERS);
    return List<User>.from(json.decode(response.body)["usuarios"].map((x) => User.fromJson(x)));*/
  }
}
