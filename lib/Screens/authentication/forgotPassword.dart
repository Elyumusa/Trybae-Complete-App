import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/Sign_In.dart';
import 'package:flutter/material.dart';

import 'ConfirmPassword.dart';

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text('Reset Password',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(context, 28),
                  fontWeight: FontWeight.bold,
                  height: 1.5)),
        ),
        Text(
          'Enter the email to which we shall send a password reset token',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                buildEmailFormField(emailController),
                SizedBox(
                  height: getProportionateScreenHeight(context, 30),
                ),
                DefaultButton(
                    onPressed: () async {
                      await AuthService()
                          .auth
                          .sendPasswordResetEmail(email: emailController.text);
                      bool returnedValue;
                       SnackBar(content: Text('A password reset Token has been sent to ${emailController.text}'));
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (context) {
                        return ConfirmPasswordPage();
                      }));
                     
                    },
                    string: 'Continue'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
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
      ])),
    ),);
  }

  TextFormField buildEmailFormField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      autofocus: true,
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
        if (value.length < 8 || value.isEmpty) {
          return 'Email not valid';
        } else {
          //removeErrors('Email not valid');

          return null;
        }
      },
    );
  }
}
