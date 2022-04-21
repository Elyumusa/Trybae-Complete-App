import 'dart:ffi';

import 'package:TrybaeCustomerApp/Components/BuildPhoneNumberField.dart';
import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class Otp {
  int first;
  int second;
  int third;
  int forth;
  int fifth;
  int sixth;
}

Otp otp = Otp();

class _OtpPageState extends State<OtpPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FocusNode firstNode;
  FocusNode secondNode;
  FocusNode thirdNode;
  FocusNode forthNode;
  @override
  void initState() {
    super.initState();
    firstNode = FocusNode();
    secondNode = FocusNode();
    thirdNode = FocusNode();
    forthNode = FocusNode();
  }

  AuthService authService;
  MyUser user;
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //user = MyHomePage.of(context).blocProvider.userAuthStatebloc.myUser;
    print('$user in dependiecene');
    authService =
        MyHomePage.of(context).blocProvider.userAuthStatebloc.authService;
    //authService.auth.signInWithEmailLink(email: email, emailLink: emailLink)
    //authService.auth.verifyPhoneNumber(phoneNumber: user.phone, verificationCompleted: (){}, verificationFailed: verificationFailed, codeSent: codeSent, codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
    super.didChangeDependencies();
  }

  Void focusNextNode(
      BuildContext context, FocusNode node, FocusNode fromthisone) {
    fromthisone.unfocus();
    FocusScope.of(context).requestFocus(node);
  }

  getNode(num number) {
    switch (number) {
      case 1:
        return firstNode = FocusNode();
        break;
      case 2:
        return secondNode = FocusNode();
      default:
    }
  }

  bool sent = false;
  String buttonName = 'Send';
  num start = 0.0;
  String validationId;
  TextEditingController phoneNumberController = TextEditingController();
  setData(String validationID) {
    setState(() {
      validationId = validationID;
    });
  }

  String validatePhone(String value) {
    if (value.length < 10) {
      //setState(() {
      return 'Please Enter Valid Phone Number';
      //});
    } else if (value.isEmpty) {
      return 'Phone number field cannot be left empty';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OtpVerification'),
        centerTitle: true,
      ),
      body: SizedBox(
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

              //OtpTimer(),
              //buildTimer(),
              SizedBox(
                height: getProportionateScreenHeight(context, 35),
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.phone,
                        //focusNode: focusNode,
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'Enter Phone Number ',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 42, vertical: 20),
                            border: OutlineInputBorder(
                              //borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            //labelText: 'Phone',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '(+26)',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            suffixIcon: TextButton(
                              onPressed: () {
                                if (validatePhone(phoneNumberController.text) ==
                                    null) {
                                  if (sent != true) {
                                    AuthService().verifyPhoneNumber(
                                        phoneNumberController.text,
                                        context,
                                        setData);
                                    setState(() {
                                      buttonName = 'Resend';
                                      start = 60.0;
                                      sent = true;
                                    });
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(validatePhone(
                                                  phoneNumberController.text)
                                              .toString())));
                                }
                              },
                              child: Text(buttonName,
                                  style: TextStyle(
                                      color: !sent
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey)),
                            )),
                        autofocus: true,
                        validator: validatePhone),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        ...List.generate(
                          6,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: SizedBox(
                                width: getProportionateScreenWidth(context, 45),
                                child: TextFormField(
                                  focusNode: FocusNode(),
                                  autofocus: index == 1 ? true : false,
                                  style: TextStyle(fontSize: 24),
                                  onChanged: (value) {
                                    // ignore: unrelated_type_equality_checks
                                    if (value.length == 1) {
                                      FocusScope.of(context).nextFocus();
                                    }
                                  },
                                  onSaved: (newValue) {
                                    switch (index) {
                                      case 0:
                                        otp.first = int.parse(newValue);
                                        break;
                                      case 1:
                                        otp.second = int.parse(newValue);
                                        break;
                                      case 2:
                                        otp.third = int.parse(newValue);
                                        break;
                                      case 3:
                                        otp.forth = int.parse(newValue);
                                        break;
                                      case 4:
                                        otp.fifth = int.parse(newValue);
                                        break;
                                      case 5:
                                        otp.sixth = int.parse(newValue);
                                        break;
                                      default:
                                    }
                                  },
                                  obscureText: true,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: otpInputDecoration(context),
                                  /*validator: (value) {
                                    // ignore: unrelated_type_equality_checks
                                    if (int.parse(value) != num) {
                                      return 'Field cannot have letters';
                                    }
                                  },*/
                                )),
                          ),
                        ),
                      ],
                    )
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: getProportionateScreenWidth(context, 60),
                            child: TextFormField(
                              focusNode: firstNode,
                              autofocus: true,
                              style: TextStyle(fontSize: 24),
                              onChanged: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value.length == 1) {
                                  focusNextNode(context, secondNode, firstNode);
                                }
                              },
                              onSaved: (newValue) =>
                                  {otp.first = int.parse(newValue)},
                              obscureText: true,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: otpInputDecoration(context),
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (int.parse(value) != num) {
                                  return 'Field cannot have letters';
                                }
                              },
                            )),
                        SizedBox(
                          width: getProportionateScreenWidth(context, 28),
                        ),
                        SizedBox(
                            width: getProportionateScreenWidth(context, 60),
                            child: TextFormField(
                              focusNode: secondNode,
                              autofocus: true,
                              style: TextStyle(fontSize: 24),
                              onChanged: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value.length == 1) {
                                  focusNextNode(context, thirdNode, secondNode);
                                }
                              },
                              onSaved: (newValue) =>
                                  {otp.second = int.parse(newValue)},
                              obscureText: true,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: otpInputDecoration(context),
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (int.parse(value) != num) {
                                  return 'Field cannot have letters';
                                }
                              },
                            )),
                        SizedBox(
                          width: getProportionateScreenWidth(context, 28),
                        ),
                        SizedBox(
                            width: getProportionateScreenWidth(context, 60),
                            child: TextFormField(
                              focusNode: thirdNode,
                              autofocus: true,
                              style: TextStyle(fontSize: 24),
                              onChanged: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value.length == 1) {
                                  focusNextNode(context, forthNode, thirdNode);
                                }
                              },
                              onSaved: (newValue) =>
                                  {otp.third = int.parse(newValue)},
                              obscureText: true,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: otpInputDecoration(context),
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (int.parse(value) != num) {
                                  return 'Field cannot have letters';
                                }
                              },
                            )),
                        SizedBox(
                          width: getProportionateScreenWidth(context, 28),
                        ),
                        SizedBox(
                            width: getProportionateScreenWidth(context, 60),
                            child: TextFormField(
                              focusNode: forthNode,
                              autofocus: true,
                              style: TextStyle(fontSize: 24),
                              onChanged: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value.length == 1) {
                                  forthNode.unfocus();
                                }
                              },
                              onSaved: (newValue) =>
                                  {otp.forth = int.parse(newValue)},
                              obscureText: true,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: otpInputDecoration(context),
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (int.parse(value) != num) {
                                  return 'Field cannot have letters';
                                }
                              },
                            )),
                      ],
                    ),
                    */
                    ,
                    SizedBox(
                      height: getProportionateScreenHeight(context, 70),
                    ),
                    validationId != null
                        ? TweenAnimationBuilder(
                            tween: Tween(begin: 0.0, end: 2.0),
                            duration: Duration(seconds: start.toInt()),
                            onEnd: () {
                              setState(() {
                                start = 0.0;
                                sent = false;
                              });
                            },
                            builder: (context, value, child) {
                              return Text(
                                  'Try again in 00:${value.toInt()} sec');
                            },
                          )
                        : Text(
                            'Try again in 00:00 sec',
                            textAlign: TextAlign.center,
                          ),
                    SizedBox(
                      height: getProportionateScreenHeight(context, 35),
                    ),
                    DefaultButton(
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            //print(papa);
                             _formkey.currentState.save();
                            AuthService().signInWithPhoneNumber(
                                validationId,
                                '${otp.first}${otp.second}${otp.third}${otp.forth}${otp.fifth}${otp.sixth}',
                                context);
                            //AuthService().auth.signInWithCredential(AuthCredential())
                            //Navigator.pushReplacementNamed(context, '/');
                          } else {
                            FocusScope.of(context).requestFocus(firstNode);
                          }
                        },
                        string: 'Continue'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildTimer(num start) {
    return TweenAnimationBuilder(
      tween: Tween(begin: start, end: 0),
      duration: Duration(seconds: start.toInt()),
      onEnd: () {
        setState(() {
          start = 0.0;
          sent = false;
        });
      },
      builder: (context, value, child) {
        return Text('00:${value.toInt()}');
      },
    );
  }

  InputDecoration otpInputDecoration(BuildContext context) {
    return InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(context, 15)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15)));
  }
}
