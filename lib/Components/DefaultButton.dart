import 'package:flutter/material.dart';

import 'ScreenMeasurementDetails.dart';

class DefaultButton extends StatelessWidget {
  final width;
  DefaultButton({
    this.onPressed,
    this.string,
    this.width,
  });
  final Function onPressed;
  final String string;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == null ? double.infinity : width,
      height: getProportionateScreenWidth(context, 56),
      child: FlatButton(
        color: Theme.of(context).primaryColor, //Colors.deepOrangeAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          string,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(context, 18),
              color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
