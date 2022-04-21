import 'package:flutter/cupertino.dart';
import 'package:TrybaeCustomerApp/models/DesignerModel.dart';

enum ProductCategory {
  Shirts,
  Jewerly,
  Hoodies,
  Cosmetics,
}

class Product {
  String name;
  //String imageUrl;
  List images;
  String description;
  num price;
  num quantity = 1;
  num rating;
  num totalPrice = 0.00;
  List availableColors;
  String designer;
  String category;
  num updateGetTotalPrice(Product product) {
    this.totalPrice = product.price * product.quantity;
  }

  Product(
      String name,
      List images,
      num price,
      num quantity,
      num rating,
      String description,
      String designer,
      String category,
      List availableColors) {
    this.images = images;
    this.name = name;
    this.description = description;
    this.rating = rating;
    //this.imageUrl = imageUrl;
    this.price = price;
    this.quantity = quantity;
    this.category = category;
    this.designer = designer;
    this.availableColors = availableColors;
    //images.add(imageUrl);
  }
}
