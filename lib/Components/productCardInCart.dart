import 'dart:async';

import 'package:TrybaeCustomerApp/Components/product_detail_body.dart';
import 'package:TrybaeCustomerApp/Components/product_photo_container.dart';
import 'package:TrybaeCustomerApp/Screens/cart_screen.dart';
import 'package:TrybaeCustomerApp/models/BoughtProduct.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'ScreenMeasurementDetails.dart';

class ProductInCart extends StatefulWidget {
  //final DocumentSnapshot product;
  final Map mapOfProduct = {};
  //ProductInCart({@required this.mapOfProduct});

  @override
  _ProductInCartState createState() => _ProductInCartState();
}

StreamController<bool> updatedCart;

class _ProductInCartState extends State<ProductInCart> {
  @override
  void didChangeDependencies() {
    cart = MyHomePage.of(context).blocProvider.cartBloc.cart;
    updatedCart = MyHomePage.of(context).blocProvider.cartBloc.updatedCart;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: getProportionateScreenWidth(context, 80),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: ProductPhotoContainer(image: 'images/trybae41.jpg'),
          ),
        ),
        /* SizedBox(
            width: getProportionateScreenWidth(context, 94),
          ),*/
        SizedBox(
          width: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summer Black Tee' /*widget.mapOfProduct['product'].get('name')*/,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: getProportionateScreenWidth(context, 5),
              ),
              Text.rich(TextSpan(
                text: 'K${1600.toStringAsFixed(2)}',
                style: TextStyle(
                  //fontSize: 18,
                  color: Color(0xFFFF7643),
                  //fontWeight: FontWeight.w600,
                ),
              )),
              /*Text(
                  'x${widget.product.quantity}',
                  style: TextStyle(fontSize: 16, color: Colors.deepOrangeAccent),
                  textAlign: TextAlign.center,
                ),*/
            ],
          ),
        ),
        /*SizedBox(
            width: getProportionateScreenWidth(context, 90),
          ),*/
        SizedBox(
          //width: getProportionateScreenWidth(context, 80),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              EditQuantityWidget(
                  addFunction: () {
                    widget.mapOfProduct['quantity'] =
                        int.parse(widget.mapOfProduct['quantity']) + 1;
                    updatedCart.add(true);
                    setState(() {});
                  },
                  removeFunction: () {
                    widget.mapOfProduct['quantity'] =
                        int.parse(widget.mapOfProduct['quantity']) - 1;
                    updatedCart.add(false);
                    setState(() {});
                  },
                  quantity: 1 /*widget.mapOfProduct['quantity']*/)
            ],
          ),
        ),
        /*SizedBox(
            width: getProportionateScreenWidth(context, 90),
          ),
        Icon(
          Icons.delete,
          color: Colors.black,
          size: 30,
        ),*/
      ],
    );
  }
}
