
import 'package:flutter_app_liquid/helpers/shared_preferences_helper.dart';
import 'package:flutter_app_liquid/models/MemberLogin.dart';
import 'package:flutter_app_liquid/models/user.dart';
import 'package:flutter_app_liquid/repository/repository.dart';

class UsersRepository  extends Repository  {

  loadUsers() async {
    try {
      List<User> newUsers = await userService.getUsers();
      connected = true;
      return await newUsers;
    } catch(_) {
      return null;
    }
  }

  login(User user) async {
  // print("Users repositity "+ user.username);
    try{
      var success = await userService.login(user);
      /*
      switch (success.type) {
        case "":
        // do something
          break;
        case "":
        // do something else
          break;
      }*/

      return success;
    } catch(_){}
    return null;
  }

 /* Future<int> getLoggedInUser() async {

    try {
      int id = await Prefs.getLoggedInUser();
      if(id == null){
        throw ArgumentError;
      }
      return id;
    } catch(_){
      return null;
    }

  }*/
}