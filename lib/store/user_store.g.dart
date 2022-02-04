// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<bool> _$connectedComputed;

  @override
  bool get connected => (_$connectedComputed ??=
          Computed<bool>(() => super.connected, name: '_UserStore.connected'))
      .value;

  final _$loginSuccessAtom = Atom(name: '_UserStore.loginSuccess');

  @override
  bool get loginSuccess {
    _$loginSuccessAtom.reportRead();
    return super.loginSuccess;
  }

  @override
  set loginSuccess(bool value) {
    _$loginSuccessAtom.reportWrite(value, super.loginSuccess, () {
      super.loginSuccess = value;
    });
  }

  final _$loadingAtom = Atom(name: '_UserStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$usersAtom = Atom(name: '_UserStore.users');

  @override
  List<User> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<User> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$memberloginAtom = Atom(name: '_UserStore.memberlogin');

  @override
  MemberLogin get memberlogin {
    _$memberloginAtom.reportRead();
    return super.memberlogin;
  }

  @override
  set memberlogin(MemberLogin value) {
    _$memberloginAtom.reportWrite(value, super.memberlogin, () {
      super.memberlogin = value;
    });
  }

  final _$currentUserAtom = Atom(name: '_UserStore.currentUser');

  @override
  User get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  final _$listLineasAtom = Atom(name: '_UserStore.listLineas');

  @override
  List<Lineas> get listLineas {
    _$listLineasAtom.reportRead();
    return super.listLineas;
  }

  @override
  set listLineas(List<Lineas> value) {
    _$listLineasAtom.reportWrite(value, super.listLineas, () {
      super.listLineas = value;
    });
  }

  final _$ErrorMsnAtom = Atom(name: '_UserStore.ErrorMsn');

  @override
  String get ErrorMsn {
    _$ErrorMsnAtom.reportRead();
    return super.ErrorMsn;
  }

  @override
  set ErrorMsn(String value) {
    _$ErrorMsnAtom.reportWrite(value, super.ErrorMsn, () {
      super.ErrorMsn = value;
    });
  }

  final _$valueAtom = Atom(name: '_UserStore.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$login2AsyncAction = AsyncAction('_UserStore.login2');

  @override
  Future<MemberLogin> login2() {
    return _$login2AsyncAction.run(() => super.login2());
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future<MemberLogin> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$getUsersAsyncAction = AsyncAction('_UserStore.getUsers');

  @override
  Future getUsers() {
    return _$getUsersAsyncAction.run(() => super.getUsers());
  }

  final _$_UserStoreActionController = ActionController(name: '_UserStore');

  @override
  dynamic select(User user) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.select');
    try {
      return super.select(user);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPassword(String password) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setUserName(String username) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.setUserName');
    try {
      return super.setUserName(username);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.increment');
    try {
      return super.increment();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loginSuccess: ${loginSuccess},
loading: ${loading},
users: ${users},
memberlogin: ${memberlogin},
currentUser: ${currentUser},
listLineas: ${listLineas},
ErrorMsn: ${ErrorMsn},
value: ${value},
connected: ${connected}
    ''';
  }
}
