import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vdev_riverpod_project/provider/auth.dart';
import 'package:vdev_riverpod_project/util/validators.dart';
import 'package:vdev_riverpod_project/widgets/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  String _username, _password;

  void _doLoginProcess(BuildContext context) {
    context.read(userLogProvider).login(_username, _password).then((value) {
      if (value['status']) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        FlushbarHelper.createError(
          title: "Failed Login",
          message: value['message'].toString(),
          duration: Duration(seconds: 3),
        ).show(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final usernameField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration(Icons.email),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration(Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    // login button action
    doLogin() {
      final form = formKey.currentState;

      if (form.validate()) {
        form.save();
        _doLoginProcess(context);
      } else {
        print("form is invalid");
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Row(
                  children: [
                    // email label
                    Expanded(flex: 1, child: Text('Email :')),
                    // email textField
                    Expanded(flex: 2, child: usernameField),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    // password label
                    Expanded(flex: 1, child: Text('Password :')),
                    // password field
                    Expanded(flex: 2, child: passwordField),
                  ],
                ),
                SizedBox(height: 20.0),

                //login button
                Consumer(
                  builder: (context, watch, child) {
                    final loginProvider = watch(userLogProvider);
                    return loginProvider.loggedInStatus == Status.Authenticating
                        ? loading
                        : longButtons("Sign-in", doLogin);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
