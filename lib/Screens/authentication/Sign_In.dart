import 'package:TrybaeCustomerApp/Screens/authentication/signIn_body.dart';
import 'package:flutter/Material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Body(),
    );
  }
}
