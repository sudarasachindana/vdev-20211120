import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:vdev_riverpod_project/models/user.dart';
import 'package:vdev_riverpod_project/util/validators.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("name", user.name.toString());

    print("object save prefere");
    print(user.name);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String name = prefs.getString("name");

    print("get pref user");
    print(name);

    return User(
        name: name,
        );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("name");
    prefs.remove("timeStamp");
  }


  Future<bool> saveLoggedTimeStamp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("timeStamp", dateTimeToString(DateTime.now()));
    return prefs.commit();
  }

  Future<String> getLoggedTimeStamp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String loggedTimeStamp = prefs.getString("timeStamp");
    return loggedTimeStamp;


  }

}
