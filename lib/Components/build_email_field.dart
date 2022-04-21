import 'package:flutter/material.dart';

class BuildEmailField extends StatelessWidget {
  RegExp regExp;
  String p;
  TextEditingController controller;
  BuildEmailField({Key key, this.controller}) : super(key: key) {
    this.p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    this.regExp = RegExp(p);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: true,
      controller: controller,
      onSaved: (newValue) {},
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
        if (value.isEmpty) {
          //removeErrors('Email not valid');
          return 'Please enter email';
        } else if (value.length < 8) {
          return 'Email not valid';
        } else {
          if (regExp.hasMatch(value) == true) return null;
          return 'Email not valid';
        }
      },
    );
  }
}
