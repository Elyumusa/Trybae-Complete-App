import 'package:TrybaeCustomerApp/Components/BuildPassWordFormField.dart';
import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/Components/build_email_field.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../VerifyEmail.dart';
import 'BuildEmailFormField.dart';
import 'Sign_In.dart';

class Person {
  String firstName;
  String surName;
  num phone;
  String email;
  String password;
}

Person user = Person();
Person getUser() {
  return user;
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController cpasswordController = TextEditingController();

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  num _onFormChange;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      print('${emailController.value}');
    });
    focusNode = FocusNode();
  }

  AuthService authService;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    authService =
        MyHomePage.of(context).blocProvider.userAuthStatebloc.authService;
    print('$authService in dependiecene');
    super.didChangeDependencies();
  }

  List<String> errors = [''];
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void removeErrors(String error) {
    setState(() {
      errors.remove(error);
    });
  }

  void addErrors(String error) {
    setState(() {
      if (errors.contains(error)) {
        print(errors);
      } else {
        errors.add(error);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String unmatchedPasswordError;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(context, 20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text('Register Account',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenWidth(context, 28),
                          fontWeight: FontWeight.bold,
                          height: 1.5)),
                ),
                Text(
                  'Enter your details here \n and begin to enjoy using our amazing app',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        BuildEmailField(
                            controller:
                                emailController), //buildEmailFormField(emailController),
                        SizedBox(
                          height: getProportionateScreenHeight(context, 30),
                        ),
                        buildPasswordFormField(
                          passwordController,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(context, 30),
                        ),
                        buildPasswordFormField(cpasswordController,
                            confirm: true),

                        SizedBox(
                          height: getProportionateScreenHeight(context, 40),
                        ),
                        DefaultButton(
                            onPressed: () async {
                              bool returnedValue;
                              if (passwordController.text ==
                                  cpasswordController.text) {
                                print('$authService in button');
                                returnedValue = await authService.signUp(
                                    emailController.text,
                                    passwordController.text);

                                returnedValue == false
                                    ? showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              content: Text('Error occured'));
                                        },
                                      )
                                    : sendEmailVerify();
                              } else {
                                print(
                                    ' here are the passwords: ${passwordController.text}    ${cpasswordController.text}');
                                print('passwords do not match');
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        content:
                                            Text('Passwords do not match'));
                                  },
                                );
                              }
                              //Navigator.pushNamed(context, '')
                              /*if (_formkey.currentState.validate()) {
                                print(user);
                                _formkey.currentState.save();
                                Navigator.pushReplacementNamed(
                                    context, '/secondSignUp');
                              } else {
                                FocusScope.of(context).requestFocus(focusNode);
                              }*/
                            },
                            string: 'Continue'),
                        SizedBox(
                          height: getProportionateScreenHeight(context, 40),
                        ),
                        Row(children: [
                          IconButton(
                              onPressed: () async {
                                UserCredential userCredential =
                                    await AuthService().signInWithGoogle();

                                print(
                                    'user email:'); // ${userCredential.user.email}');
                              },
                              icon: Icon(Icons.login)),
                          IconButton(onPressed: () {}, icon: Icon(Icons.logout))
                        ]),
                        SizedBox(
                          height: 70,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'By continuing you confirm to that you agree \n with our Terms and Conditions',
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* TextFormField buildPasswordFormField(
      bool password, TextEditingController controller) {
    if (password) {
      return TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: true,
        onChanged: (value) {
          if (value.length < 8 || value.isEmpty) {
            return 'Password must be more than 8 characters';
          } else if (value.length >= 8) {
            //_formkey.currentState.save();
            return null;
          }
        },
        onSaved: (newValue) {
          if (user.password == null) {
            user.password = newValue;
          }
        },
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
          fillColor: Colors.black,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
          hintText: 'Enter your password',
          labelText: 'Password',
          suffixIcon: Icon(
            Icons.lock_outline,
            size: 20,
          ),
        ),
        // ignore: missing_return
        validator: (value) {
          if (value.length < 8 || value.isEmpty) {
            return 'Password must be more than 8 characters';
          } else {
            //removeErrors('Password must be more than 8 characters');
            return null;
          }
        },
      );
    } else {
      return TextFormField(
        controller: controller,
        onSaved: (newValue) {
          print('okay');
        },

        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
            hintText: 'Re-enter your password ',
            labelText: 'Confirm Password ',
            suffixIcon: Icon(Icons.lock_outlined)),
        // ignore: missing_return
        validator: (value) {
          print(user.password);
          print(value);
          if (value.length < 8 || value.isEmpty) {
            return 'Password must be more than 8 characters';
          } else {
            //removeErrors('Password must be more than 8 characters');
            if (value != user.password) {
              return 'Passwords do not match';
            } else if (value == user.password) {
              return null;
              //removeErrors('Passwords do not match');
            }
          }
        },
      );
    }
  }
*/
  sendEmailVerify() async {
    await FirebaseAuth.instance.currentUser.sendEmailVerification();
    await FirebaseAuth.instance.currentUser.reload();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => VerifyEmailPage()));
  }
}
