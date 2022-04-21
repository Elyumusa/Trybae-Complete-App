import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  final String image;
  const SplashContent({
    this.image,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Welcome to Trybae, enjoy your experience !!'),
        Spacer(),
        Container(
          height: 370,
          width: 436,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
