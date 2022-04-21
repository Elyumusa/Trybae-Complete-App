//import 'dart:html';

import 'package:TrybaeCustomerApp/Components/BuildTextFormField.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/BuildEmailFormField.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/Sign_In.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

TextEditingController emailController = TextEditingController();
TextEditingController fnameController = TextEditingController();
TextEditingController snameController = TextEditingController();

class _AccountScreenState extends State<AccountScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_outlined),
        //backgroundColor: Color(0xFFF5F6F9),
        title: Text('Account'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().auth.signOut();
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return SignInPage();
              }));
            },
            icon: Icon(Icons.logout_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_basket_outlined),
          ),
          SizedBox(
            width: getProportionateScreenWidth(context, 5),
          ),
          CircleAvatar(
            backgroundImage: AssetImage('images/Elyumusa profile pic(3).jpg'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(offset: Offset(-2, 2), color: Colors.grey[300])
                    ]),
                child: ListTile(
                    leading: Icon(Icons.search_outlined),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'Find What You Need Here',
                        border: InputBorder.none,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
                    )),
              ),
              SizedBox(height: getProportionateScreenWidth(context, 8)),
              Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Elyumusa Njobvu',
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(
                        height: getProportionateScreenWidth(context, 5),
                      ),
                      Text('elyte4@protonmail.com'),
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundImage:
                        AssetImage('images/Elyumusa profile pic(3).jpg'),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(context, 15),
              ),
              Container(
                  //width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(offset: Offset(5, 4), color: Colors.grey[300]),
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Icon(Icons.shopping_cart_outlined),
                          Text('Wish List')
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.star_border_outlined),
                          Text('Following')
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.message_outlined),
                          Text('Messaging')
                        ],
                      )
                    ],
                  )),
              SizedBox(
                height: getProportionateScreenWidth(context, 13),
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.list),
                          SizedBox(
                              width: getProportionateScreenWidth(context, 35)),
                          Text(
                            'My Orders',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Spacer(),
                          InkResponse(
                            child: Text(
                              'View all',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                          height: getProportionateScreenWidth(context, 16)),
                      Row(
                        children: [
                          Text(
                            'Unpaid',
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Text('1'),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200]),
                          )
                        ],
                      ),
                      SizedBox(
                          height: getProportionateScreenWidth(context, 16)),
                      Row(
                        children: [
                          Text(
                            'To be Shipped',
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Text('1'),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200]),
                          )
                        ],
                      ),
                      SizedBox(
                          height: getProportionateScreenWidth(context, 16)),
                      Row(
                        children: [
                          Text(
                            'Shipped',
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Text('1'),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200]),
                          )
                        ],
                      ),
                      SizedBox(
                          height: getProportionateScreenWidth(context, 16)),
                      Row(
                        children: [
                          Text(
                            'In Dispute',
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Text('1'),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200]),
                          )
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: getProportionateScreenWidth(context, 13),
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_circle_outlined),
                          SizedBox(
                              width: getProportionateScreenWidth(context, 35)),
                          Text(
                            'Profile Settings',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Spacer(),
                          InkResponse(
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            onTap: () {
                              _showMyDialog();
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                          height: getProportionateScreenWidth(context, 25)),
                      Row(
                        children: [
                          Text(
                            'Full Name',
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            user.displayName == null
                                ? ''
                                : '${user.displayName}',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: getProportionateScreenWidth(context, 25)),
                      Row(
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            user.email == null ? '' : '${user.email}',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: getProportionateScreenWidth(context, 25)),
                      Row(
                        children: [
                          Text(
                            'Gender',
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            'Mail',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: getProportionateScreenWidth(context, 25)),
                      Row(
                        children: [
                          Text(
                            'Birth Date',
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Text(
                            '04/05/2003',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ],
                      ),
                    ],
                  )),
              echanged == true
                  ? SnackBar(
                      content: Text(
                          'A verification token has been sent to your new email, once you verify your email will be updated'))
                  : Text(''),
            ],
          ),
        ),
      ),
    );
  }

  User user = AuthService().auth.currentUser;
  bool echanged = false;
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.account_circle_outlined),
              SizedBox(
                width: 10,
              ),
              Text('Profile Settings'),
            ],
          ),
          content: SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /*buildTextFormField(
                      'First Name',
                      true,
                      (value) {},
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    buildTextFormField(
                      'SurName',
                      true,
                      (value) {},
                    ),*/
                    SizedBox(
                      height: 15,
                    ),
                    buildEmailFormField(emailController),
                    DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now())
                    /*DropdownButtonFormField(
                      onChanged: (value) {},
                      items: [
                        DropdownMenuItem(
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          child: Text('Female'),
                        )
                      ],
                    ),*/
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                              },
            ),
          ],
        );
      },
    );
  }
}
