import 'dart:io';

import 'package:TrybaeCustomerApp/Components/BuildTextFormField.dart';
import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//Person user = getUser();

class SignUpSecondPage extends StatefulWidget {
  @override
  _SignUpSecondPageState createState() => _SignUpSecondPageState();
}

class _SignUpSecondPageState extends State<SignUpSecondPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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

  String errors;
  File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(context, 20),
              ),
              child: Column(
                children: [
                  
                  Text('Complete Profile',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: getProportionateScreenWidth(context, 28),
                          fontWeight: FontWeight.bold,
                          height: 1.5)),
                  Text(
                    'Complete your details here \n and Finally begin to use our amazing app',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(children: <Widget>[
                      buildTextFormField(
                        'First Name',
                        true,
                        (value) {
                          //user.firstName = value;
                        },null
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(context, 30),
                      ),
                      buildTextFormField(
                        'Surname',
                        false,
                        (value) {
                          //user.surName = value;
                        },null
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(context, 30),
                      ),
                      buildPhoneNumberFormField(),
                      SizedBox(
                        height: getProportionateScreenHeight(context, 30),
                      ),
                      DefaultButton(
                          onPressed: () {
                            /*if (_formkey.currentState.validate()) {
                              //print(user);
                              _formkey.currentState.save();
                              Navigator.pushReplacementNamed(
                                  context, '/otpVerify');
                            } else {
                              FocusScope.of(context).requestFocus(focusNode);
                            }*/
                          },
                          string: 'Continue'),
                    ]),
                  ),
                ],
              ),
            ),
          )),
        ));
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      //focusNode: focusNode,
      onSaved: (newValue) {
        //user.phone = int.parse(newValue);
        print('okay');
      },
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        fillColor: Colors.black,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
        hintText: 'Enter Phone Number here',
        labelText: 'Phone',
        suffixIcon: Icon(
          Icons.phone_android,
          size: 20,
        ),
      ),
      autofocus: true,
      validator: (value) {
        if (value.length < 10 || value.isEmpty) {
          //setState(() {
          return 'Field cannot have letters';
          //});
        } else {
          return null;
        }
      },
    );
  }

  selectAndPickImage() {
    selectImage();
  }

  selectImage() async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
