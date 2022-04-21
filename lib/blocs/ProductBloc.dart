import 'dart:async';

import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../SampleProducts.dart';

class ProductBloc {
  StreamController<List<Product>> allProductsController =
      BehaviorSubject<List<Product>>(sync: true);

  List<StreamController<List<Product>>> productsByCategoryControllers = [];
  List<Stream<QuerySnapshot>> productsByStreams = [Database().productsgetter];
  List<Product> products = [];

  ProductBloc() {
    //productsByStreams.add(Database().productsgetter);
    allProductsController.stream.listen((event) {
      populateproductsList(event);
    });

    //allProductsController.add(getSampleProducts());
    print('I have added the products check:$products');
    ProductCategory.values.forEach((category) {
      StreamController<List<Product>> categoryController =
          StreamController<List<Product>>();
      categoryController.add(
          products); //.where((product) => product.category == category).toList());
      productsByCategoryControllers.add(categoryController);
      //productsByStreams.add(categoryController.stream.asBroadcastStream());
    });
  }
  populateproductsList(List<Product> productsfromStream) {
    print('Heyy there $productsfromStream');
    this.products = productsfromStream;
    print('This is products: $products');
  }
}
