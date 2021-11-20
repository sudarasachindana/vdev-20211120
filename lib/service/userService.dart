import 'package:vdev_riverpod_project/models/user.dart';
import 'package:vdev_riverpod_project/util/shared_preference.dart';

class UserService {
  User currentUser;

  Future<User> getCurrentUser() async {
    await UserPreferences().getUser().then((value){

      print("User service user");
      print(value);
      currentUser = value;
    });
    return currentUser;
  }
}
