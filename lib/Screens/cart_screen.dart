import 'dart:async';
import 'dart:io';

import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ProductCard.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/Components/productCardInCart.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/Screens/OrderSummaryPage.dart';
import 'package:TrybaeCustomerApp/main.dart';
import 'package:TrybaeCustomerApp/models/BoughtProduct.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'account_screen.dart';
import 'authentication/Sign_In.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() {
    return _CartScreenState();
  }
}

Stream cartStream;
List<Map<String, dynamic>> cart;
FirebaseMessaging messaging = FirebaseMessaging.instance;
List<Map<String, dynamic>> cartWithProducts = [];
StreamController<bool> updatedCart;
num cartTotal = 0;

class _CartScreenState extends State<CartScreen> {
  void didChangeDependencies() {
    cartStream =
        MyHomePage.of(context).blocProvider.cartBloc.updatedCart.stream;
    updatedCart = MyHomePage.of(context).blocProvider.cartBloc.updatedCart;
    cart = MyHomePage.of(context).blocProvider.cartBloc.cart;
    cartWithProducts =
        MyHomePage.of(context).blocProvider.cartBloc.cartWithProducts;
    super.didChangeDependencies();
  }

  void initState() {
    // TODO: implement didChangeDependencies
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenWidth(context, 30),
                horizontal: getProportionateScreenWidth(context, 15)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, -15),
                      blurRadius: 20,
                      color: Colors.white.withOpacity(0.6))
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(
                      text: 'Cart Total:\n',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                      children: [
                        TextSpan(
                            text: 'K600.98',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold))
                      ])),
                  SizedBox(
                    width: getProportionateScreenWidth(context, 200),
                    child: DefaultButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return OrderSummary();
                          },
                        ));
                      },
                      string: 'Check Out',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Column(
              children: [
                Text(
                  'My Cart',
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  '3 items',
                  style: TextStyle(color: Colors.black26, fontSize: 15),
                )
              ],
            ),
            elevation: 0,
            leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  size: 35,
                  color: Colors.black,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Account();
                      },
                    ));
                  },
                  icon: Icon(
                    Icons.menu_rounded,
                    color: Colors.black,
                  )),
            ]),
        body: SafeArea(
          child: StreamBuilder(
            stream: cartStream,
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    //Map<String, dynamic> product = cart[index];
                    return Container(
                      margin: EdgeInsets.all(8),
                      child: Dismissible(
                          onDismissed: (direction) {
                            setState(() {
                              cart.removeAt(index);
                              updatedCart.add(false);
                            });
                          },
                          background: Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                Spacer(),
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.red.shade600,
                                  size: 50,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(15)), //
                          ),
                          direction: DismissDirection.endToStart,
                          key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                          child:
                              ProductInCart() /* ProductInCart(
                          mapOfProduct: product,
                          )*/
                          ),
                    );
                  });
            },
          ),
        ));
  }
}
