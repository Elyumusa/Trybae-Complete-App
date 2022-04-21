import 'dart:ffi';

import 'package:flutter/material.dart';

TextFormField buildPasswordFormField(TextEditingController controller,
    {Function onSaved, bool confirm}) {
  return TextFormField(
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    obscureText: true,
    onSaved: onSaved != null
        ? onSaved
        : (newValue) {
            print('okay');
          },
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
      fillColor: Colors.black,
      border: OutlineInputBorder(
        gapPadding: 10,
        borderRadius: BorderRadius.circular(28),
      ),
      hintText: confirm == null
          ? 'Enter Password here'
          : 'Enter password again to confirm',
      labelText: confirm == null ? 'Password' : 'Confirm Password',
      suffixIcon: Icon(
        Icons.lock_outline,
        size: 20,
      ),
    ),
    validator: (value) {
      if (value.length < 8) {
        //setState(() {
        String errors = 'Field must contain more than 8 characters';
        print(errors);
        return errors;
        //});
      } else {
        return null;
      }
    },
  );
}
