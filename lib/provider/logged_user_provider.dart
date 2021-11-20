import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vdev_riverpod_project/models/user.dart';
import 'package:vdev_riverpod_project/util/shared_preference.dart';


final loggedUserData = ChangeNotifierProvider((ref) => LoggedUserProvider());

class LoggedUserProvider extends ChangeNotifier {
  String _loggedTime = '';
  User _currentUser = new User();

  String get loggedTime => _loggedTime;
  User get currentUser => _currentUser;

  void setCurrentUserData() async{
    await UserPreferences().getUser().then((value){
      print("User notifier service run");
      print(value);
      _currentUser = value;
    });

    await UserPreferences().getLoggedTimeStamp().then((value){
      print("User notifier service run");
      print(value);
      _loggedTime = value;
    });

    notifyListeners();
  }


}