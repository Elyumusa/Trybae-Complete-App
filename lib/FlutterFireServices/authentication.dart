import 'package:TrybaeCustomerApp/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User> get user {
    return auth.authStateChanges();
    //.map((event) => createNormalUserFromFirebaseUser(event));
  }

  signInWithPhoneNumber(
      String verificationID, String code, BuildContext context) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: code);
    try {
      await auth.signInWithCredential(credential);
    } catch (e) {
      showSnackBar(e.message, context);
    }
  }

  verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) {
      showSnackBar('Verification Compeleted successfully', context);
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      print('error: ${exception.message}');
      showSnackBar(exception.message, context);
    };
    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) {
      showSnackBar('Verification Code sent on the phone Number', context);
      setData(verificationId);
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar('Time Out', context);
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: '+26${phoneNumber}',
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: const Duration(minutes: 2),
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<bool> signUp(String email, String password) async {
    print('Its here');
    try {
      print('Its also here');
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(userCredential);
      print('But here its worked');
      User user = userCredential.user;
      createNormalUserFromFirebaseUser(user);
      return true;
    } on FirebaseAuthException catch (e) {
      print('Its here not');
      print(e.message);
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    }
  }

  createNormalUserFromFirebaseUser(User user) {
    var newUser;
    return user == null ? null : MyUser(uid: user.uid);
  }

  Future signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
  /*Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (e) {
      print('error from google sign in: $e');
    }

    // Obtain the auth details from the request
    GoogleSignInAuthentication googleAuth;
    if (googleUser != null)
      try {
        googleAuth = await googleUser.authentication;
      } catch (e) {
        print('error from googleAuth in: $e');
      }

    // Create a new credential
    GoogleAuthCredential credential;
    if (googleAuth != null)
      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
    UserCredential c;
    if (credential != null)
      try {
        c = await FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        print('error from signInWithCredential in: $e');
      }
    // Once signed in, return the UserCredential
    return c;
  }
}*/
