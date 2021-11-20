import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vdev_riverpod_project/models/user.dart';
import 'package:vdev_riverpod_project/util/shared_preference.dart';


enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

final userLogProvider = ChangeNotifierProvider((ref) => AuthProvider());

class AuthProvider extends ChangeNotifier {

  Map<String, String> userMap = {'joe@black.lk': 'Jo45*78', 'amal@acme.lk': 'La79*!_i', 'peter@pan.lk': 'Nap42-24', 'abc@a.lk': '123'};

  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Map<String, dynamic> _result = Map();
  Map<String, dynamic> get result => _result;


  Future<Map<String, dynamic>> login(String email, String password) async {



    _loggedInStatus = Status.Authenticating;
    notifyListeners();



      bool isMatch = userMap.containsKey(email);
      if(isMatch){
        if(userMap[email] == password){

          User authUser = User(name: email);

          UserPreferences().saveUser(authUser);
          UserPreferences().saveLoggedTimeStamp();


          _loggedInStatus = Status.LoggedIn;
          notifyListeners();

          _result = {'status': true, 'message': 'Successful', 'user': authUser};
        }else{
          _loggedInStatus = Status.NotLoggedIn;
          notifyListeners();
          _result = {
            'status': false,
            'message': "Password doesn't match"
          };
        }
      }else{
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        _result = {
          'status': false,
          'message': "Invalid Email or Password"
        };
      }



    return _result;
  }


  Future<void> userLogOut() async {
    print('log tag');
    _loggedInStatus = Status.Authenticating;
    UserPreferences().removeUser();
    UserPreferences().removeUser();
    _loggedInStatus = Status.LoggedOut;
  }




}