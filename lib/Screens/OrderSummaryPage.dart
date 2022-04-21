import 'dart:io';

import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/Components/productCardInCart.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/Sign_In.dart';
import 'package:TrybaeCustomerApp/Screens/authentication/sign_up.dart';
import 'package:TrybaeCustomerApp/Screens/cart_screen.dart';
import 'package:TrybaeCustomerApp/models/DesignerModel.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class OrderSummary extends StatefulWidget {
  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

List<Map<String, dynamic>> cartWithProducts;

class _OrderSummaryState extends State<OrderSummary> {
  void didChangeDependencies() {
    cart = MyHomePage.of(context).blocProvider.cartBloc.cart;
    cartWithProducts =
        MyHomePage.of(context).blocProvider.cartBloc.cartWithProducts;
    stream = MyHomePage.of(context).blocProvider.cartBloc.updatedCart.stream;
    super.didChangeDependencies();
  }

  List<Map<String, dynamic>> cart;
  DocumentSnapshot product;
  Stream<User> user;
  num subtotal = 0;
  Stream stream;
  @override
  Widget build(BuildContext context) {
    num deliveryFee = 36;

    print('Here is the current product from the cart: $cart');
    return StreamBuilder(
      stream: AuthService().user,
      builder: (context, snapshot) {
        //subtotal = addCartSubTotal(cart);
        return StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              //if (snapshot.hasData) {
              return Scaffold(
                  body: Padding(
                padding: const EdgeInsets.all(25.0),
                child: ListView(
                  children: [
                    ...List.generate(cart.length, (index) {
                      return buildProductTile(index);
                    }),
                    SizedBox(
                      height: getProportionateScreenWidth(context, 20),
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Coupon Code',
                    )),
                    SizedBox(
                      height: getProportionateScreenWidth(context, 20),
                    ),
                    Row(
                      children: [
                        Text(
                          'Sub-Total',
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        Text('K$subtotal')
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Delivery',
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        Text('K$deliveryFee')
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 24),
                        ),
                        Spacer(),
                        Text(
                          'K${deliveryFee + subtotal}',
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(context, 15),
                    ),
                    DefaultButton(
                        string: 'Place Order',
                        onPressed: () async {
                          List cartArrSellers = [];
                          for (var element in cart) {
                            if (cartArrSellers.isEmpty) {
                              print('empty');
                              cartArrSellers.add({
                                'designer': element['product'].get('designer'),
                                'products': cart
                                    .where((e) =>
                                        e['product'].get('designer') ==
                                        e['product'].get('designer'))
                                    .toList()
                              });
                              continue;
                            }
                            //print('added');
                            //print(cartArrSellers);
                            else if (!cartArrSellers.map((e) {
                              print('else');
                              return e['designer'];
                            }).contains(element['product'].get('designer')))
                              cartArrSellers.add({
                                'designer': element['product'].get('designer'),
                                'products': cart
                                    .where((element) =>
                                        element['product'].get('designer') ==
                                        element['product'].get('designer'))
                                    .toList()
                              });
                          }

                          var returnedValue = [];
                          cartArrSellers.forEach((element) async {
                            returnedValue.add(await Database().placeOrder(
                                AuthService().auth.currentUser,
                                {
                                  'designer': element['designer'],
                                  'products': element['products'].map((e) => {
                                        'product_id': e['product'].id,
                                        'quantity': e['quantity']
                                      }).toList()
                                },
                                addCartSubTotal(element['products'])));
                          });

                          print('Kanshi its hear ai');
                          print(returnedValue);
                          returnedValue.contains('false')
                              ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    print('the guy needs to login');
                                    return Dialog(
                                      child: SignInPage(),
                                    );
                                  })
                              : print('Order has been succesfully place');
                        })
                  ],
                ),
              ));
              /*} else {
                showDialog(
                    context: context,
                    builder: (context) {
                      print('the guy needs to login');
                      return Dialog(
                        child: SignInPage(),
                      );
                    });
              }*/
            });
      },
    );
  }

  num addCartSubTotal(List<Map<String, dynamic>> products) {
    num totalSoFar = 0;
    for (var map in products) {
      num producttotal = int.parse('${map['product'].get('price')}') *
          int.parse('${map['quantity']}');
      print('$producttotal');
      totalSoFar += producttotal;
    }

    return totalSoFar;
  }

  Widget buildProductTile(num index) {
    Map<String, dynamic> product = cart[index];

    return ProductInCart();
    /* ProductInCart(
            mapOfProduct: {
              'product': product['product'],
              'quantity': cart[index]['quantity']
            },
          );*/
  }
}
