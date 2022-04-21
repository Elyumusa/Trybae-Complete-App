import 'dart:math';

import 'package:TrybaeCustomerApp/Components/Humanize_Category.dart';
import 'package:TrybaeCustomerApp/Components/orderModel.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/SampleProducts.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';
import 'package:TrybaeCustomerApp/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Database {
  final String uid;
  Database({this.uid}) {
    for (var designer in getSampleProducts()) {
      designers.add({
        'name': designer.name,
        'collections': designer.collections
            .map((e) => {
                  'collectionName': e.collectionName,
                  'productsInCollection': e.productsInCollection
                      .map((e) => '02ksKmffVXx8DcKfZ7Cy')
                      .toList(),
                  'photo': 'images/TrybaeSamplephoto.jpg'
                })
            .toList(),
        'bio': designer.bio,
        'designerImage': designer.designerImage,
        'verified': designer.verified
      });
    }
  }
  Stream<QuerySnapshot> get orderssgetter {
    return orders
        .where('user_id', isEqualTo: AuthService().auth.currentUser.uid) //)
        .snapshots();
  }

  Stream<QuerySnapshot> get designerssgetter {
    return designers.snapshots();
  }

  Stream<QuerySnapshot> get productsgetter {
    return products.snapshots();
  }

  CollectionReference get ordersReference {
    return orders;
  }

  CollectionReference designers =
      FirebaseFirestore.instance.collection('Designers');
  CollectionReference orders = FirebaseFirestore.instance.collection('Orders');
  CollectionReference products =
      FirebaseFirestore.instance.collection('Products');

  Future<bool> placeOrder(User user, Map order, num totalPrice) async {
    DocumentReference myDocument;
    //CollectionReference myOrders = myDocument.collection('myOrders');
    try {
      await orders. /*doc(user.uid).collection('Orders').*/ add({
        'user_id': user.uid,
        'date_placed': FieldValue.serverTimestamp(),
        'products': order['products'],
        'total': totalPrice,
        'order_id': 'hajlkdshas4',
        'status': humanizeCategory(OrderState.Ordered.toString()),
        'cod': true,
        'seller_id': order['designer']
      });
      /*final firebase = FirebaseFunctions.instance;
      firebase.useFunctionsEmulator('localhost', 5001);
      HttpsCallable callable = firebase.httpsCallable('test');
      String fcmToken = await FirebaseMessaging.instance.getToken();
      try {
        print('fcmToken: $fcmToken');
        final results = await callable.call({'token': fcmToken});
        print('Og its called the function');
        results.data;
      } catch (e) {
        print('oh no error:$e');
      }*/

      return true;
    } catch (e) {
      print('error: $e');
      return false;
    }
  }
}
