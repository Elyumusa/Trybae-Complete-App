import 'dart:typed_data';

import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/ConfirmPassword.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/sign_up.dart';
import 'package:TrybaeCustomerApp/blocs/BuildProfilePicture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../main.dart';
import 'BuildPassWordFormField.dart';
import 'BuildPhoneNumberField.dart';
import 'BuildTextFormField.dart';
import 'DefaultButton.dart';
import 'ScreenMeasurementDetails.dart';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'build_email_field.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

TextEditingController emailController = TextEditingController();
TextEditingController fnameController = TextEditingController();
TextEditingController snameController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController cpassController = TextEditingController();
PickedFile pickedFile;
String imagePath;
final ImagePicker _picker = ImagePicker();

class _EditProfileState extends State<EditProfile> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool formChanged = false;
  FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    getImage();
    focusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    MyHomePage.of(context).blocProvider;

    super.didChangeDependencies();
  }

  DateTime DOB;
  String gender;
  User user = AuthService().auth.currentUser;

  getImage() async {
    String filesInStorageBucket = await storage
        .ref()
        .child('images')
        .child(user.email)
        .getDownloadURL(); //getMetadata();
    print('from getImage: $filesInStorageBucket');
    if (filesInStorageBucket != null) imagePath = filesInStorageBucket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(' Edit Profile',
              style: TextStyle(color: Colors.white, fontSize: 25)),
          elevation: 0,
          //backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets\icons\5036916221558965373.svg',
                  color: Colors.black),
            ),
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets\icons\18687613011579605524.svg',
                    color: Colors.black),
                color: Colors.black),
          ],
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .get(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case (ConnectionState.done):
                DocumentSnapshot userdocument = snapshot.data;
                gender = userdocument.get('gender');
                if (!userdocument.get('Firstname').isEmpty)
                  fnameController.text = userdocument.get('Firstname');
                if (!userdocument.get('Surname').isEmpty)
                  snameController.text = userdocument.get('Surname');
                return SafeArea(
                    child: SingleChildScrollView(
                        child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(children: [
                      ProfilePicture(
                        imagePath: imagePath,
                        edit: true,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Select Image'),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  content: Container(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        EditProfileButton(
                                          user: user,
                                          icon: Icon(Icons.picture_in_picture),
                                          text: 'Select From Gallery',
                                          onPressed: () {
                                            pickimage(
                                                context, ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        SizedBox(
                                          height: getProportionateScreenHeight(
                                              context, 10),
                                        ),
                                        EditProfileButton(
                                          user: user,
                                          icon: Icon(Icons.camera_alt_outlined),
                                          text: 'Use Camera',
                                          onPressed: () {
                                            pickimage(
                                                context, ImageSource.camera);
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                      Form(
                        onWillPop: () {
                          if (!formChanged) return Future<bool>.value(true);
                          return showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      'Are you sure you want to abandon the form? Any unsaved changes will be lost.'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Cancel"),
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      textColor: Colors.black,
                                    ),
                                    FlatButton(
                                      child: Text("Abandon"),
                                      textColor: Colors.red,
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                    ),
                                  ],
                                );
                              });
                        },
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            BuildEmailField(),
                            SizedBox(
                              height: getProportionateScreenHeight(context, 15),
                            ),
                            buildTextFormField('First Name', true, (onSaved) {},
                                fnameController),
                            SizedBox(
                              height: getProportionateScreenHeight(context, 30),
                            ),
                            buildTextFormField('Surname', false, (onSaved) {},
                                snameController),
                            SizedBox(
                              height: getProportionateScreenHeight(context, 30),
                            ),
                            buildPhoneNumberFormField(),
                            SizedBox(
                              height: getProportionateScreenHeight(context, 30),
                            ),
                            pickGender(
                              (value) async {
                                if (gender != null) {
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(user.uid)
                                      .update({'gender': gender});
                                }
                              },
                              (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(context, 20),
                            ),
                            EditProfileButton(
                              user: user,
                              icon: Icon(Icons.lock_outline),
                              text: 'Change Password',
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      actions: [
                                        TextButton(
                                            onPressed: () {},
                                            child: Text('Cancel')),
                                        TextButton(
                                            onPressed: () {},
                                            child: Text('Save'))
                                      ],
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    context, 12),
                                          ),
                                          buildPasswordFormField(
                                              passController),
                                          SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    context, 30),
                                          ),
                                          buildPasswordFormField(
                                              cpassController,
                                              onSaved: (value) async {
                                            if (cpassController.text.trim() ==
                                                passController.text.trim()) {
                                              //user.reauthenticateWithCredential(credential)
                                              try {
                                                await user.updatePassword(
                                                    passController.text.trim());
                                                print(
                                                    'Password updated successfully');
                                              } catch (e) {
                                                print(e);
                                                throw (e);
                                              }
                                            }
                                          }, confirm: true),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(context, 20),
                            ),
                            EditProfileButton(
                              user: user,
                              icon: Icon(Icons.calendar_today_outlined),
                              text: 'Update Date of Birth',
                              onPressed: () {
                                /*Hero(
                                    tag: 'Pick date route',
                                    child: Material(
                                      child: SizedBox(
                                        height: 80,
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          backgroundColor: Colors.white,
                                          onDateTimeChanged: (datePicked) {
                                            DOB = datePicked;
                                          },
                                          initialDateTime: DateTime.utc(2007),
                                          // maximumDate: DateTime.utc(2007),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                    ),
                                  );
                                   */
                                showDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      child: SizedBox(
                                        height: 140,
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          backgroundColor: Colors.white,
                                          onDateTimeChanged: (datePicked) {
                                            DOB = datePicked;
                                          },
                                          initialDateTime:
                                              userdocument.get('DOB') == ''
                                                  ? DOB == null
                                                      ? DateTime.utc(2000)
                                                      : DOB
                                                  : userdocument.get('DOB'),
                                          // maximumDate: DateTime.utc(2007),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(context, 20),
                            ),
                            DefaultButton(
                                onPressed: () async {
                                  if (_formkey.currentState.validate()) {
                                    if (user.email !=
                                            emailController.text.trim() &&
                                        emailController.text != null) {
                                      try {
                                        await user.verifyBeforeUpdateEmail(
                                            emailController.text.trim());
                                      } catch (e) {
                                        print('Error at: $e');
                                      }
                                      try {
                                        await user.updateEmail(
                                            emailController.text.trim());
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user.uid)
                                            .set({'email': user.email});
                                      } catch (e) {
                                        print('Error at updateEmail: $e');
                                      }
                                    }

                                    if (pickedFile != null) {
                                      try {
                                        uploadPhoto(pickedFile);
                                        print('after upload');
                                        await FirebaseFirestore.instance
                                            .collection('Users')
                                            .doc(user.uid)
                                            .update({'photo': imagePath});
                                        setState(() {});
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                    if (userdocument
                                                .get('Firstname')
                                                .toLowerCase() !=
                                            fnameController.text
                                                .trim()
                                                .toLowerCase() ||
                                        userdocument
                                                .get('Surname')
                                                .toLowerCase() !=
                                            snameController.text
                                                .trim()
                                                .toLowerCase()) {
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection('Users')
                                            .doc(user.uid)
                                            .update({
                                          'Firstname':
                                              fnameController.text.trim(),
                                          'Surname': snameController.text.trim()
                                        });
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                    if (DOB != null) {
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection('Users')
                                            .doc(user.uid)
                                            .update({'DOB': DOB});
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                    fnameController.clear();
                                    snameController.clear();
                                  } else {
                                    FocusScope.of(context).requestFocus();
                                  }
                                },
                                string: 'Continue'),
                          ],
                        ),
                      ),
                    ]),
                  ),
                )));

              case (ConnectionState.waiting):
                return Center(child: CircularProgressIndicator());
                break;
              default:
                return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  DropdownButtonFormField<String> pickGender(
      Function onSaved, Function onChanged) {
    return DropdownButtonFormField(
        value: gender,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
          fillColor: Colors.black,
          border: OutlineInputBorder(
            gapPadding: 10,
            borderRadius: BorderRadius.circular(28),
          ),
          labelText: 'Gender',
        ),
        onSaved: onSaved,
        onChanged: onChanged,
        items: [
          DropdownMenuItem(
            child: Text('Male'),
            value: 'male',
            onTap: () {
              print('oh okay');
            },
          ),
          DropdownMenuItem(
            child: Text('Female'),
            value: 'female',
            onTap: () {
              print('oh okay');
            },
          )
        ]);
  }

  pickimage(BuildContext context, ImageSource source) async {
    try {
      pickedFile = await _picker.getImage(source: source);
      print(' pickedFile: ${pickedFile.path}');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('File Picked successfully')));
    } catch (e) {
      print(e);
    }
  }

  void uploadPhoto(PickedFile pickedFile) async {
    firebase_storage.Reference ref =
        storage.ref().child('images').child(user.email);
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': pickedFile.path});

    try {
      print('in upload: ${io.File(pickedFile.path)}');
      final t = ref.putFile(io.File(pickedFile.path), metadata);
      getImage();
    } catch (e) {
      print(e);
    }
  }
}

class EditProfileButton extends StatelessWidget {
  final Function onPressed;

  final String text;

  final Icon icon;

  const EditProfileButton({
    Key key,
    @required this.user,
    @required this.icon,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0xFFF5F6F9), borderRadius: BorderRadius.circular(25)),
      child: TextButton(
          child: Row(children: [
            icon,
            SizedBox(
              width: 30,
            ),
            Expanded(child: Text(text)),
          ]),
          onPressed: onPressed),
    );
  }
}
