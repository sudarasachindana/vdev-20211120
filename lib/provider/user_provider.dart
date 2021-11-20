import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vdev_riverpod_project/models/user.dart';
import 'package:vdev_riverpod_project/service/userService.dart';

final userProvider = Provider((ref) => UserService());

final responseUserProvider = FutureProvider<User>((ref) {
  return ref.read(userProvider).getCurrentUser();
});
