import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:flutter/material.dart';
import 'SignInForm.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/sign_up.dart';
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(context, 10)),
            child: Column(children: <Widget>[
              Text('Welcome Back',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(context, 28),
                      fontWeight: FontWeight.bold)),
              Text(
                'Sign in with your email and password \n or continue with Social Media',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              SignInForm(),
              SizedBox(
                height: getProportionateScreenWidth(context, 30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  InkResponse(
                    onTap: () {
                       Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return SignUpPage();
                  }));
                    },
                    child: Text('Sign Up'),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
