import 'dart:async';
import 'dart:io';

import 'package:TrybaeCustomerApp/Components/BuildPassWordFormField.dart';
import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/Screens/VerifyEmail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../home_screen.dart/HomePage.dart';
import 'forgotPassword.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Widget displayError(errors) {
    if (errors == null) {
      return Text('');
    } else {
      return Row(
        children: [
          Icon(
            Icons.error,
            color: Colors.red[700],
          ),
          Text(errors)
        ],
      );
    }
  }

  num _onFormChange;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool remember = false;

  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  AuthService authService = AuthService();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //authService = MyHomePage.of(context).blocProvider.userAuthStatebloc.authService;
    // print('$authService in dependiecene');
    test();
    super.didChangeDependencies();
  }

  test() async {
    print('Were in test function');
    String fcmToken = await FirebaseMessaging.instance.getToken();
    try {
      print('fcmToken: $fcmToken');
      print('Og its called the function');
    } catch (e) {
      print('oh no error:$e');
    }
  }

  String errors;
  @override
  Widget build(BuildContext context) {
    print(errors);
    return Form(
        key: _formkey,
        onChanged: () {
          //_formkey.currentState.validate();
          print('Form has changed');
        },
        child: Column(children: <Widget>[
          buildEmailFormField(emailController),
          //displayError(errors),
          SizedBox(
            height: getProportionateScreenWidth(context, 30),
          ),
          buildPasswordFormField(passwordController),
          //displayError(errors),
          SizedBox(
            height: getProportionateScreenWidth(context, 30),
          ),
          Row(
            children: [
              Checkbox(
                value: remember,
                onChanged: (value) => remember = value,
              ),
              Text('Remember me'),
              Spacer(),
              InkResponse(
                child: Text(
                  'Forgot Password',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                onTap: () {
                  print('What');
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return ForgotPasswordPage();
                  }));
                },
              )
            ],
          ),
          DefaultButton(
            onPressed: () async {
              bool returnedValue;
              User user;

              returnedValue = await AuthService()
                  .signIn(emailController.text, passwordController.text);
              returnedValue == false
                  ? showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(content: Text('Error occured'));
                      },
                    )
                  : checkVerificationEmail();

              /*else {
                await user.sendEmailVerification();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        content: Text(
                            'A verification email to your email please click it'));
                  },
                );

                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return VerifyEmailPage();
                }));
              }*/

              /*if (_formkey.currentState.validate()) {
                _formkey.currentState.save();
                //Navigator.pop(context);
              } else {
                FocusScope.of(context).requestFocus(focusNode);
              }*/
            },
            string: 'Log In',
          ),
        ]));
  }

  TextFormField buildEmailFormField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      onSaved: (newValue) {
        //user.email = newValue;
      },
      onChanged: (value) {
        if (value.length < 8 || value.isEmpty) {
          return 'Please enter valid email';
        } else {
          //_formkey.currentState.validate();
          return null;
        }
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        hintText: 'Enter your email',
        suffixIcon: Icon(Icons.email_outlined),
        labelText: 'Email',
      ),
      // ignore: missing_return
      validator: (value) {
        if (value.length < 8 || value.isEmpty || !value.contains('@')) {
          return 'Email not valid';
        } else {
          //removeErrors('Email not valid');

          return null;
        }
      },
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      //focusNode: focusNode,
      onSaved: (newValue) {
        print('okay');
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: 'Enter Phone Number here',
        enabledBorder: OutlineInputBorder(
            gapPadding: 10,
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(color: Colors.black)),
        labelText: 'Phone',
        suffixIcon: Icon(
          Icons.phone_android,
          size: 20,
        ),
      ),
      autofocus: true,
      validator: (value) {
        if (value.isEmpty) {
          //setState(() {
          errors = 'Field cannot have letters';
          print(errors);
          return errors;
          //});
        } else {
          return null;
        }
      },
    );
  }

  void checkVerificationEmail() async {
    await FirebaseAuth.instance.currentUser.reload();
    print('wassss happening');
    if (FirebaseAuth.instance.currentUser.emailVerified) {
      print('Oggggg');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return VerifyEmailPage();
      }));
    } else {
      await FirebaseAuth.instance.currentUser.sendEmailVerification();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return VerifyEmailPage();
      }));
    }
  }
}
