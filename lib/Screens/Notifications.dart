import 'package:TrybaeCustomerApp/Components/Humanize_Category.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/Components/orderModel.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/blocs/UserAuthStatebloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

List<Map<String, String>> notifications;

class _NotificationsState extends State<Notifications> {
  UserAuthStatebloc user;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    user = MyHomePage.of(context).blocProvider.userAuthStatebloc;
    notifications =
        MyHomePage.of(context).blocProvider.userAuthStatebloc.notifications;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_outlined),
        backgroundColor: Color(0xFFF5F6F9),
        title: Text('Notifications'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_basket_outlined),
          ),
          SizedBox(
            width: getProportionateScreenWidth(context, 5),
          ),
          CircleAvatar(
            backgroundImage: AssetImage('images/Elyumusa profile pic(3).jpg'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<Object>(
            stream: FirebaseMessaging.onMessage,
            builder: (context, snapshot) {
              //placeOrder();
              return Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenWidth(context, 8),
                  ),
                  SizedBox(height: getProportionateScreenWidth(context, 8)),
                  ...List.generate(notifications.length, (index) {
                    print('message.data: ${notifications[index]['data']}');
                    //Database().orders.doc(notifications[index]['data']);
                    return Dismissible(
                        onDismissed: (DismissDirection direction) {
                          notifications.removeAt(index);
                        },
                        background: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Spacer(),
                              Icon(
                                Icons.delete_outline,
                                color: Colors.deepOrangeAccent,
                                size: 50,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)), //
                        ),
                        direction: DismissDirection.endToStart,
                        key: ValueKey(user),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: Image.asset(
                              '',
                            ),
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                        text:
                                            'message.notification: ${notifications[index]['notification']}'),
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(
                                          context, 6)),
                                  Row(
                                    children: [
                                      Text(
                                        '33min ago',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w200),
                                      ),
                                      //...buildRating(user.wishList[index].rating),
                                    ],
                                  ),
                                ]),
                          ),
                        ));
                  })
                ],
              );
            }),
      ),
    );
  }

  void placeOrder() async {
    try {
      await Database().orders.doc('abcdefgh').collection('Orders').add({
        'user': 'abcdefgh',
        'plaedAt': FieldValue.serverTimestamp(),
        'products': [],
        'totalPrice': 123,
        'Order_id': 'hajlkdshas4',
        'status': humanizeCategory(OrderState.Ordered.toString())
      });
      print('Order placed');
    } catch (e) {
      print(e);
    }
  }
}
