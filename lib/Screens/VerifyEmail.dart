import 'dart:async';
import 'dart:io';

import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/Screens/home_screen.dart/HomePage.dart';
import 'package:TrybaeCustomerApp/models/CollectionModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  AuthService authService;

  @override
  void initState() {
    // TODO: implement didChangeDependencies

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  bool created;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: StreamBuilder(
      stream: AuthService().auth.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData == true) {
          if (snapshot.data.emailVerified == false) {
            //print('Oggggg');
            createUserProfile();
            if (created == true) saveTokenToDB();
            return HomePage();
          }
          print('Its failed to verify  ${snapshot.data.emailVerified}');
        }
        return Center(
          child: Text(
              'An email has been sent to ${user.email} please verify by clicking the email'),
        );
      },
    )) /* ,*/
        );
  }

  User user = FirebaseAuth.instance.currentUser;
  /*checkVerificationEmail() async {
    await user.reload();
    print('wassss happening');
    if (user.emailVerified) {
      print('Oggggg');

      saveTokenToDB();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    print('Its failed to verify I dont know why ${user.emailVerified}');
  }*/

  createUserProfile() async {
    String useruid = AuthService().auth.currentUser.uid;
    DocumentSnapshot userDocument =
        await FirebaseFirestore.instance.collection('Users').doc(useruid).get();
    if (!userDocument.exists) {
      await FirebaseFirestore.instance.collection('Users').doc(useruid).set({
        'Firstname': '',
        'Surname': '',
        'email': user.email,
        'photo': '',
        'gender': '',
        'DOB': '',
      });
      setState(() {
        created = true;
      });
    } else {
      setState(() {
        created = false;
      });
    }
  }

  saveTokenToDB() async {
    String useruid = AuthService().auth.currentUser.uid;
    final fCMToken = await FirebaseMessaging.instance.getToken();
    print('$fCMToken');
    CollectionReference myTokens = FirebaseFirestore.instance
        .collection('Users')
        .doc(useruid)
        .collection('Tokens');

    DocumentSnapshot value = await myTokens.doc(fCMToken).get();
    if (!value.exists) {
      myTokens.add({
        'token': fCMToken,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem
      });
    }
  }
}
