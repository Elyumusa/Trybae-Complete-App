import 'dart:ffi';

import 'package:TrybaeCustomerApp/Components/BuildPassWordFormField.dart';
import 'package:TrybaeCustomerApp/Components/BuildTextFormField.dart';
import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/Sign_In.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfirmPasswordPage extends StatefulWidget {
  @override
  _ConfirmPasswordPageState createState() => _ConfirmPasswordPageState();
}

String errors;
TextEditingController passwordController = TextEditingController();

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              children: [
                Text('Register Account',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(context, 28),
                        fontWeight: FontWeight.bold,
                        height: 1.5)),
                Text(
                  'We sent your code to +18906**** \n This code will expire in ',
                  textAlign: TextAlign.center,
                ),
                //OtpTimer(),
                /*TweenAnimationBuilder(
                  tween: Tween(),
                  duration: Duration(minutes: 2),
                  builder: (context, value, child) {
                    return Text('00:${value.toInt()}');
                  },
                ),*/
                SizedBox(
                  height: getProportionateScreenHeight(context, 35),
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      buildTextFormField('Code', true, (string) {}, null),
                      SizedBox(
                        height: getProportionateScreenHeight(context, 70),
                      ),
                      buildPasswordFormField(passwordController),
                      DefaultButton(
                          onPressed: () async {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return SignInPage();
                            }));
                            /* if (_formkey.currentState.validate()) {      
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                return SignInPage();
                              }));
                            } else {
                              print('An error during validation');
                            }*/
                          },
                          string: 'Continue'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
