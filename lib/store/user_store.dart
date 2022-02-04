import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter_app_liquid/models/Lineas.dart';
import 'package:flutter_app_liquid/models/MemberLogin.dart';
import 'package:flutter_app_liquid/models/SessionData.dart';
import 'package:flutter_app_liquid/models/user.dart';
import 'package:flutter_app_liquid/repository/users_repository.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:mobx/mobx.dart';
part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  UsersRepository repository = UsersRepository();
  final AsyncMemoizer<User> _memoizer = AsyncMemoizer<User>();

  @computed
  bool get connected => repository.connected;

  @observable
  bool loginSuccess;

  @observable
  bool loading = false;

  @observable
  List<User> users = [];

  @observable
  MemberLogin memberlogin = new MemberLogin();

  @observable
  User currentUser = new User();

  @observable
  List<Lineas> listLineas;

  @observable
  String ErrorMsn;

  User get user => currentUser;

  @action
  select(User user) => currentUser = user;

  @action
  setPassword(String password) => currentUser.password = password;

  @action
  setUserName(String username) {
    currentUser.username = username;
  }

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }

  @action
  Future<MemberLogin> login2() async =>
      memberlogin = await repository.login(currentUser);
/*
  @action
  Future<MemberLogin> login()  async =>   await repository.login(currentUser);*/
  @action
  Future<MemberLogin> login() async {
    loading = true;
    //await Future.delayed(Duration(seconds: 1));
    final response = await repository.login(currentUser);
    loading = false;
    //print(response['data']);
    //var s = Lineas.fromJson(response['data']);
    /*final parsed = response['data'].cast<Map<String, dynamic>>();
    parsed.map<Lineas>((json) =>Lineas.fromJson(json)).toList();
    List<Lineas> _listLineas = parsed;

    List<Lineas>  _listLineas2 = (response['data'] as List)
        .map((p) => Lineas.fromJson(p))
        .toList();


    listLineas = _listLineas2;*/

    if (response['data'] != null) {
      if (response['result'] == '0' || response['result'] == 0) {
       /* listLineas =
            (response['data'] as List)?.map((i) => Lineas.fromJson(i)).toList();*/
        var session = FlutterSession();
        /*var data = response['user'];
        SessionData sessionData = SessionData(
            us_idusuario: data['us_idusuario'],
            te_nombres: data["te_nombres"],
            token: data["token"],
            us_email: data["us_email"],
            us_roles: data["us_roles"],
            us_usuario: data["us_usario"]
        );*/
        //print(response['user']['data']);
        await session.set("SessionData",SessionData.fromJson(response['user']));
      } else {
        listLineas = [];
      }
    } else {
      listLineas = [];
    }
    //print(listLineas);
    /* List<Lineas> list = new List();
    response['data'].forEach((e) {
      list.add(Lineas.fromJson(e));
      print(list);
    });*/
    //print(response['user']['token']);
    /*Future.delayed(const Duration(milliseconds: 500), () {
       loading = false;
    });*/
    return MemberLogin.fromJson(response);
  }

/*
  @action
  Future<User> getCurrentUser() async => this._memoizer.runOnce(() async => currentUser = await repository.getLoggedInUser());
*/
  @action
  getUsers() async => users = await repository.loadUsers();
}
