import 'package:TrybaeCustomerApp/Screens/home_screen.dart/HomePage.dart';
import 'package:TrybaeCustomerApp/Screens/VerifyEmail.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/Sign_In.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/sign_up.dart';
import 'package:TrybaeCustomerApp/main.dart';
import 'package:TrybaeCustomerApp/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreenWrapper extends StatefulWidget {
  @override
  _MainScreenWrapperState createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  bool isAuthenticated = false;
  Stream userStream;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    userStream ??= MyHomePage.of(context).blocProvider.userAuthStatebloc.user;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('${MyHomePage.of(context).blocProvider.userAuthStatebloc}');
    return StreamBuilder(
      stream: userStream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.active:
            if (snapshot.data == null) {
              print('We here back here again');
              return SignUpPage();
            } else {
              if (snapshot.data.emailVerified) {
                return HomePage();
              } else {
                /* showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        content: Text(
                            'A verification email to your email please click it'));
                  },
                );*/

                return VerifyEmailPage();
              }
            }
            break;
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            return Text('');
        }
      },
    );
  }
}

sendVerifyEmail(User user) async {
  await user.sendEmailVerification();
}
