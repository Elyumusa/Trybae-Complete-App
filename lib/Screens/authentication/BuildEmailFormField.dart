import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextFormField buildEmailFormField(TextEditingController controller,
    {Function onSaved}) {
  return TextFormField(
    controller: controller,
    autofocus: true,
    onSaved: onSaved,
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
