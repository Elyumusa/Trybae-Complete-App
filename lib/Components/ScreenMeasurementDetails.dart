import 'package:flutter/material.dart';

double getProportionateScreenWidth(BuildContext context, double numb) {
  double screenWidth = MediaQuery.of(context).size.width;
 
  double percWidth = (numb / 375) * screenWidth;
  
  return percWidth;
}

num getProportionateScreenHeight(BuildContext context, double numb) {
  double screenHeight = MediaQuery.of(context).size.height;
 
  double percHeight = (numb / 812.0) * screenHeight;
 
  return percHeight;
}
