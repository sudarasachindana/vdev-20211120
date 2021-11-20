import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vdev_riverpod_project/provider/user_provider.dart';
import 'package:vdev_riverpod_project/screens/ErrorScreen.dart';
import 'package:vdev_riverpod_project/screens/LoadingScreen.dart';
import 'package:vdev_riverpod_project/screens/dashboard.dart';
import 'package:vdev_riverpod_project/screens/login.dart';

void main() {
  runApp(ProviderScope(child: AuthChecker()));
}

class AuthChecker extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _authState = watch(responseUserProvider);
    return MaterialApp(
      title: "V-Dev Test App",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepOrangeAccent.withOpacity(0.2),
      ),
      debugShowCheckedModeBanner: false,
      home: _authState.when(
          data: (data) {
            print('data ob main');
            print(data);
            print(data.name);
            /* if (data.name != null && data.name != '') return HomePage();
            return LoginPage();*/

            if (data.name != null && data.name != '') return DashBoard();
            return Login();
          },
          loading: () => LoadingScreen(),
          error: (e, trace) => ErrorScreen(e, trace)),

        routes: {
          '/dashboard': (context) => DashBoard(),
          '/login': (context) => Login(),
          '/loading': (context) => LoadingScreen(),
        }
    );
  }
}
