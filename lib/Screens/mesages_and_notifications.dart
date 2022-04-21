import 'dart:async';

import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

class FCMMessageHandler extends StatefulWidget {
  @override
  _FCMMessageHandlerState createState() => _FCMMessageHandlerState();
}

StreamController<Map<String, dynamic>> notifications;

class _FCMMessageHandlerState extends State<FCMMessageHandler> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    
    notifications = MyHomePage.of(context)
        .blocProvider
        .userAuthStatebloc
        .notificationsController;

    super.didChangeDependencies();
  }

  @override
  void initState() {
    saveTokenToDB();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        notifications
            .add({'notification': message.notification, 'data': message.data});
      }

      if (Platform.isIOS) {
        messaging
            .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        )
            .then((value) {
          value.authorizationStatus == AuthorizationStatus.authorized
              ? showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('New Order has been placed to IOS'),
                    );
                  },
                )
              : print("You haven't accepted permission to send notifications");
        });
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('New Order has been placed'),
            );
          },
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Text('FCM Push Notifications')],
      ),
    );
  }

  saveTokenToDB() async {
    String useruid = AuthService().auth.currentUser.uid;
    final fCMToken = await FirebaseMessaging.instance.getToken();
    print('$fCMToken');
    CollectionReference myTokens = FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .collection('Tokens');

    myTokens.doc(fCMToken).get().then((value) {
      if (!value.exists) {
        myTokens.add({
          'token': fCMToken,
          'createdAt': FieldValue.serverTimestamp(),
          'platform': Platform.operatingSystem
        });
      }
    });
  }
}
