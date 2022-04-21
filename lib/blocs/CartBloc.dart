import 'dart:async';

import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartBloc {
  StreamController<Map<String, String>> cartStreamController =
      StreamController.broadcast(); //StreamController<String>().;
  List<Map<String, dynamic>> cart = [];
  StreamController<bool> updatedCart = StreamController.broadcast();
  List<Map<String, dynamic>> cartWithProducts = [];
  CartBloc() {
    cartStreamController.stream.listen((event) {
       updatedCart.add(true);
      addToCart(event);
     
    });
  }

  void addToCart(Map<String, String> product) async{
    if (!cart.contains(product)) {
      print('The product has been added check: $cart');
    } else {
      print('The product is already in the cart');
    }
  }
}
