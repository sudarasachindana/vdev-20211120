import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vdev_riverpod_project/provider/user_provider.dart';
import 'package:vdev_riverpod_project/util/shared_preference.dart';

final appNameRiverpod = Provider<String>((ref) => "Exploring Riverpod");
final widgetNameRiverpod = Provider<String>((ref) => "Get Jokes API Riverpod");
final hopeRiverpod = Provider<String>(
    (ref) => "Hope You'll Understand This! \nKeep Learning and Stay Safe");

final fireBaseAuthProvider = Provider<String>((ref) {
  String name;
  UserPreferences().getUser().then((value){

    print("User service new one user");
    print(value.name);
    name = value.name;
  });


  return name;
});