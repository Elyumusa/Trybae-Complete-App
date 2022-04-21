import 'dart:async';

import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/Components/product_detail_body.dart';
import 'package:TrybaeCustomerApp/blocs/CartBloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'account_screen.dart';
import 'cart_screen.dart';

class NewProductScreen extends StatefulWidget {
  final DocumentSnapshot productDocument;
  const NewProductScreen({Key key, this.productDocument}) : super(key: key);

  @override
  _NewProductScreenState createState() => _NewProductScreenState();
}

num quantityChosen = 1;

class _NewProductScreenState extends State<NewProductScreen> {
  List<Color> colors = [
    Colors.white,
    Colors.purple,
    Colors.orange,
    Colors.black
  ];
  CartBloc cartBloc;
  StreamController<bool> updatedCart;
  void didChangeDependencies() {
    cartBloc = MyHomePage.of(context).blocProvider.cartBloc;
    updatedCart = MyHomePage.of(context).blocProvider.cartBloc.updatedCart;
    super.didChangeDependencies();
  }

  num selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                Icon(
                  Icons.shopping_basket_outlined,
                  size: 31,
                ),
                //if (cartBloc.cart.isNotEmpty)
                Positioned(
                  bottom: 1,
                  right: 1,
                  child: StreamBuilder<Object>(
                      stream: updatedCart.stream,
                      builder: (context, snapshot) {
                        return Container(
                          height: 14,
                          width: 14,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orangeAccent),
                          child: Text(''),
                        );
                      }),
                )
              ],
            ),
            color: Colors.white,
          )
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(
          'Product Details',
          style: TextStyle(fontSize: 20),
        ),
        //backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15, top: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 305,
              child: Image.asset(
                'images/trybae41.jpg' /*productDocument.get('images')[0] */,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text:
                          '${widget.productDocument.get('name')}\n' /*'Summer Black Tee\n' */,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                  TextSpan(
                      text: 'By ', style: TextStyle(color: Colors.black87)),
                  TextSpan(
                      text: widget.productDocument.get('designer'),
                      /* */
                      style:
                          TextStyle(color: Color(0xFF1D150B).withOpacity(0.9)))
                ])),
                Text(
                    'K${widget.productDocument.get('price').toStringAsFixed(2)}' /*, */,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text('${widget.productDocument.get('description')}'),
            //'This is a quality one of the kind t-shirt designed by our very own Lombe Posa'),

            ///* */ 'Finder objects—Finders are objects that scan the widget tree and find widgets by specific properties. The find object is a collection of many CommonFinders,including byText, byWidget, byKey, and byType (among others). You use these finders almost all the time. The find.byText call that I used in the previous test function literally searches for a widget with that exact text.'),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(context, 20),
                  vertical: 15),
              child: Row(children: [
                ...List.generate(
                    colors.length,
                    (index) => buildColors(context, index, colors, () {
                          setState(() {
                            print('Buutttttt');
                            selectedColor = index;
                          });
                        }, selectedColor)),
                Spacer(),
                EditQuantityWidget(
                  quantity: quantityChosen,
                  //productBloc: productBloc,
                  removeFunction: () {
                    setState(() {
                      quantityChosen -= 1;
                    });
                  },
                  addFunction: () {
                    setState(() {
                      quantityChosen += 1;
                    });
                  },
                ),
              ]),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!cartBloc.cart
                          .map((e) => e['product'].id)
                          .contains(widget.productDocument.id)) {
                        print('It is not in cart so you can add');
                        cartBloc.cart.add({
                          'product': widget.productDocument,
                          'quantity': quantityChosen
                        });
                        cartBloc.updatedCart.add(true);
                      } else {
                        print('already in cart');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'You already added this item to the cart')));
                      }

                      cartBloc.updatedCart.add(true);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        children: [
                          Text('Add To Cart',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(fontSize: 17)),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CartScreen();
                        },
                      ));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.26)),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(14),
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor),
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 30,
                                  ),
                                ),
                                Positioned(
                                  right: 12,
                                  bottom: 12,
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: StreamBuilder<Object>(
                                        stream: updatedCart.stream,
                                        builder: (context, snapshot) {
                                          return Text(
                                            '${cartBloc.cart.length}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .button,
                                          );
                                        }),
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CoolAppBar extends StatelessWidget {
  const CoolAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 35,
            )),
        IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Account();
                },
              ));
            },
            icon: Icon(Icons.menu_rounded))
      ],
    );
  }
}
