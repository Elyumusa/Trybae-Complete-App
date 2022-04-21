import 'dart:async';
import 'dart:io';

import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/models/UserModel.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class UserAuthStatebloc {
  AuthService authService;
  Stream<User> user;
  MyUser myUser;
  StreamController<Map<String, dynamic>> notificationsController =
      StreamController.broadcast();
  List<Map<String, String>> notifications = [];
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  UserAuthStatebloc(AuthService authService) {
    this.authService = authService;
    print('authService has been made');

    this.user = authService.user;
    notificationsController.stream.listen((event) {
      notifications.add(event);
    });
  }
}
