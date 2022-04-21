import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.black),
          child: Row(
            children: [
              Text(
                'VISA',
                style: TextStyle(fontSize: 60, color: Colors.blueAccent),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        //backgroundColor: Colors.black,
                        title: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      hintText: 'Card Holder Name',
                                      prefixIcon: Icon(
                                        Icons.account_circle_outlined,
                                      ))),
                              SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      hintText: 'Card Number',
                                      prefixIcon: Icon(
                                        Icons.payment_outlined,
                                      ))),
                              SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      hintText: 'Expiry Date',
                                      prefixIcon: Icon(
                                        Icons.account_circle_outlined,
                                      ))),
                              SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      hintText: 'Security Code',
                                      prefixIcon: Icon(
                                        Icons.account_circle_outlined,
                                      ))),
                              SizedBox(
                                height: 12,
                              ),
                              DefaultButton(
                                width: 300.0,
                                string: 'Add To Card',
                                onPressed: () {},
                              )
                            ],
                          )),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(children: [
                    Icon(
                      Icons.add_circle_outline_outlined,
                      size: 70,
                    ),
                    Spacer(),
                    Text(
                      'Add Card',
                      style: TextStyle(fontSize: 20),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: getProportionateScreenWidth(context, 25),
        ),
        Container(
            padding: EdgeInsets.only(left: 10),
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.black)),
        SizedBox(
          height: getProportionateScreenWidth(context, 25),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: Colors.black),
        )
      ]),
    );
  }
}
