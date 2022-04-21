import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'PaymentPage.dart';

class DeliveryDetailsPage extends StatefulWidget {
  @override
  _DeliveryDetailsPageState createState() => _DeliveryDetailsPageState();
}

num currentIndex = 0;

class _DeliveryDetailsPageState extends State<DeliveryDetailsPage> {
  TabController controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    controller = MyHomePage.of(context).blocProvider.tabBloc.controller;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Form(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Name:',
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.lightBlueAccent,
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Text(
                      'Contact Number:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.lightBlueAccent,
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Text(
                      'Contact Number 2:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    //SizedBox(width: getProportionateScreenWidth(context, 80)),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.lightBlueAccent,
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'Delivery Address/Shipping Address',
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TextFormField(
                   onTap: () {
                  
                },
                  decoration: InputDecoration(
                    fillColor: Colors.lightBlueAccent,
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4.0))),
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenWidth(context, 20),
              ),
              SizedBox(
                width: double.infinity,
                height: getProportionateScreenWidth(context, 56),
                child: FlatButton(
                  color:
                      Theme.of(context).primaryColor, //Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'string',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(context, 18),
                        color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              )
              /*DefaultButton(
                  onPressed: () {
                    setState(() {
                      controller.animateTo(controller.index += 1);
                    });
                  },
                  string: 'Save'),
            */
            ],
          ),
        ))
      ],
    ));
  }
}
