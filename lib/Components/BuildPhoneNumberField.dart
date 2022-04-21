import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextFormField buildPhoneNumberFormField({Function onSaved}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: TextInputType.phone,
    //focusNode: focusNode,
    onSaved: onSaved,
    decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: 'Enter Phone Number here',
        contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
        //labelText: 'Phone',
        prefixIcon: Text('+26'),
        suffixIcon: TextButton(onPressed: () {}, child: Text('Send'))),
    autofocus: true,
    validator: (value) {
      if (value.length < 10) {
        //setState(() {
        return 'Please Enter Valid Phone Number';
        //});
      } else if (value.isEmpty) {
        return 'Phone number field cannot be left empty';
      } else {
        return null;
      }
    },
  );
}
