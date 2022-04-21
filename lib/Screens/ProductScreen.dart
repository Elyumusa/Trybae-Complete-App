import 'package:TrybaeCustomerApp/Components/product_detail_body.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  ProductDetailPage({this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_basket_outlined),
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
            //style: TextStyle(color: Colors.blueAccent),
          ),
          //backgroundColor: Colors.white,
        ),
        body: ProductDetailBody(product: product));
  }
}
