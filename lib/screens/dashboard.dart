import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vdev_riverpod_project/provider/auth.dart';
import 'package:vdev_riverpod_project/provider/category_provider.dart';
import 'package:vdev_riverpod_project/provider/logged_user_provider.dart';
import 'package:vdev_riverpod_project/provider/string_provider.dart';
import 'package:vdev_riverpod_project/provider/user_provider.dart';
import 'package:vdev_riverpod_project/util/utilities.dart';
import 'package:vdev_riverpod_project/widgets/rounded_button_widget.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key key}) : super(key: key);


  Widget _buildSignOutButton(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          //logged user text
          /*Consumer(builder: (context, watch, child) {
            final currentUserResponse = watch(responseUserProvider);

            print('current user dash');
            print(currentUserResponse);
            print(currentUserResponse.data);
            print(currentUserResponse.data.value);
            print(currentUserResponse.data.value.name);

            return currentUserResponse.data.value.name != null && currentUserResponse.data.value.name != ''
                ? Text(currentUserResponse.data.value.name)
                : Text('no user');
              return Text(currentUserResponse.data.value.name);
            },
          ),*/

          /*Consumer(builder: (context, watch, child) {
            final currentUserResponse = watch(responseUserProvider);
            print('watch response');
            print(currentUserResponse);
            return Container(
              child: currentUserResponse.when(
                  data: (data) =>
                      Text(data.name != null && data.name != '' ? data.name : 'no user' ),
                // loading: () => Center(child: CircularProgressIndicator()),
              ),
            );

            },
          ),*/

          /*Consumer(builder: (context, watch, child) {
            final currentUserResponse = watch(responseUserProvider);
            print('watch response');
            print(currentUserResponse);
            return currentUserResponse.map(
              data: (data) => Text(data.value.name),
              loading: (_) => CircularProgressIndicator(),
              error: (message) => Text(message.error),
            );

            },
          ),*/

          Consumer(builder: (context, watch, child) {


            final currentUserResponse = watch(loggedUserData);

            print('current user dash');
            print(currentUserResponse);
            print(currentUserResponse.currentUser);
            print(currentUserResponse.currentUser.name);

            return currentUserResponse.currentUser.name != null && currentUserResponse.currentUser.name != ''
                ? Text(currentUserResponse.currentUser.name)
                : Text('no user');
            },
          ),




          // sign-out button
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: RoundedButtonWidget(
              buttonText: 'Sign-Out',
              buttonColor: Colors.blue.shade300,
              textColor: Colors.black,
              onPressed: () {
                _doLogout(context);


                }),

            ),

        ],
      ),
    );
  }

  Widget _buildHeaderTittle() {
    // header tittle
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text('Product Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
    );
  }

  Widget _buildSignInAtText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          // sign at lable
          Text('Sign-In at : ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),

          // sign in timeStamp
          Consumer(builder: (context, watch, child) {

            final currentUserResponse = watch(loggedUserData);


            return currentUserResponse.loggedTime != null && currentUserResponse.loggedTime != ''
                ? Text(currentUserResponse.loggedTime)
                : Text('TimeStamp Error');
          },
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read(loggedUserData).setCurrentUserData();
        return Scaffold(
          backgroundColor: Colors.white,
            appBar: makeAppBar(context),
            body: Container(
              child: Column(
                children: [

                  _buildSignOutButton(context),

                  _buildHeaderTittle(),

                  Expanded(
                    child: Consumer(builder: (context, watch, child) {
                      final apiServiceImplement = watch(categoryServiceProvider);
                      return Container(
                        child: apiServiceImplement.when(
                          data: (data) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.02,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: data != null
                                        ? ListView.separated(
                                      itemCount: data.length,
                                      separatorBuilder: (context, position) {
                                        return Divider();
                                      },
                                      itemBuilder: (context, position) {
                                        return ListTile(
                                          dense: true,
                                          leading: Icon(Icons.cloud_circle),
                                          title: Text(
                                            '${data[position].title}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: Theme.of(context).textTheme.title,
                                          ),
                                          subtitle: Text(
                                            '${data[position].body}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                        );;
                                      },
                                    )
                                        : Center(
                                      child: Text(
                                        'Not Found Category to Display',
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                          loading: () => Center(child: CircularProgressIndicator()),
                          error: (e, s) => SizedBox(),
                        ),
                      );
                    }),
                  ),

                  _buildSignInAtText(),
                ],
              ),
            ));

  }

  Widget makeAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        context.read(appNameRiverpod),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
    );
  }

  void _doLogout(BuildContext context) {
    context.read(userLogProvider).userLogOut().then((value){
      Navigator.pushReplacementNamed(context, '/login');
    });
  }


}
