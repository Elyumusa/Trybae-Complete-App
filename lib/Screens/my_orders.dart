import 'dart:ui';

import 'package:TrybaeCustomerApp/Components/Humanize_Category.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/Components/category_picker.dart';
import 'package:TrybaeCustomerApp/Components/orderModel.dart';
import 'package:TrybaeCustomerApp/Components/product_photo_container.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart/HomePage.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

List<QueryDocumentSnapshot<Map<String, dynamic>>> orders = [];

class _MyOrdersPageState extends State<MyOrdersPage> {
  //MyUserBloc user;

  Stream<QuerySnapshot> streamOfOrders;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //user = MyHomePage.of(context).blocProvider.userBloc;
    //orders ??= MyHomePage.of(context).blocProvider.userBloc.totalOrders;
    streamOfOrders = Database().orderssgetter;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_outlined),
          //backgroundColor: Color(0xFFF5F6F9),
          title: Text('My Orders'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_basket_outlined),
            ),
            SizedBox(
              width: getProportionateScreenWidth(context, 5),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: StreamBuilder<QuerySnapshot>(
                  stream: streamOfOrders,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      orders = snapshot.data.docs;
                      return Column(children: [
                        CategoryPicker(
                          usedInMyOrders: true,
                          whenTabChanges: (int index) {
                            if (index != 0) {
                              /*OrderState currentOrderState =
                                  OrderState.values[index - 1];*/
                              setState(() {
                                streamOfOrders = Database()
                                    .orders
                                    .where('user_id',
                                        isEqualTo:
                                            AuthService().auth.currentUser.uid)
                                    .where('status',
                                        isEqualTo: humanizeCategory(OrderState
                                            .values[index - 1]
                                            .toString()))
                                    .snapshots();
                                /*streamOfOrders = streamOfOrders.where((event) {
                                  return event.docs
                                      .where((element) =>
                                          humanizeCategory(
                                              element.get('status')) ==
                                          humanizeCategory(OrderState
                                              .values[index - 1]
                                              .toString()))
                                      .every((element) =>
                                          humanizeCategory(
                                              element.get('status')) ==
                                          humanizeCategory(OrderState
                                              .values[index - 1]
                                              .toString()));
                                });
                                */
                                print('Set State has run the second time');
                              });
                            } else {
                              setState(() {
                                streamOfOrders = Database().orderssgetter;
                              });
                            }
                          },
                          tabItems: [
                            'All Orders',
                            'Ordered',
                            'Accepted',
                            'PickedUp',
                            'OnTheWay',
                            'Completed'
                          ],
                        ),
                        ...List.generate(orders.length, (index) {
                          final order = orders[index];
                          //doc(order.get('seller_id')));
                          return FutureBuilder<QuerySnapshot>(
                              future: Database()
                                  .designers
                                  .where('name',
                                      isEqualTo: order.get('seller_id'))
                                  .get(),
                              builder: (context, snapshot) {
                                final designer = snapshot.data;
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  color: Colors.white,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          horizontalTitleGap: 0,
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 14,
                                            child: Icon(
                                              Icons.shopping_bag_outlined,
                                              color: getStatusColor(
                                                  order.get('status')),
                                            ),
                                          ),
                                          trailing: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  order.get('cod') == true
                                                      ? 'Payment Type: Cash on Delivery'
                                                      : 'Payment Type: Pay Online',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  'Amount: ZMW${order.get('total')}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ]),
                                          subtitle: Text(
                                            '${DateFormat.yMMMd().format(order.get('date_placed').toDate())}', //'On July 30, 2021', //
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          title: Text(
                                            '${order.get('status')}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: getStatusColor(
                                                    order.get('status'))),
                                          ),
                                        ),
                                        order.get('status') == 'Ordered'
                                            ? Text('')
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0,
                                                        vertical: 5),
                                                child: ListTile(
                                                  tileColor: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.2),
                                                  leading: CircleAvatar(
                                                      child: Image.asset(
                                                    /*designer != null
                                                      ? designer
                                                          .get('designerImage')
                                                      : '',*/
                                                    'assets/images/trybae41.jpg',
                                                    height: 24,
                                                    fit: BoxFit.cover,
                                                  )) /*CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                            'assets/images/trybae41.jpg'))*/
                                                  ,
                                                  title: Text(
                                                    //designer != null ? designer : '',
                                                    'Kng Lulat',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    getCommentFromStatus(order.get(
                                                        'status')), // 'Your order has been accepted',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        ExpansionTile(
                                            title: Text(
                                              'Order Details',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            subtitle: Text(
                                              'View Order Details',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                            children: [
                                              ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: order
                                                    .get('products')
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  final product_id = order
                                                      .get('products')[index];

                                                  return FutureBuilder<
                                                          DocumentSnapshot>(
                                                      future: Database()
                                                          .products
                                                          .doc(product_id)
                                                          .get(),
                                                      builder:
                                                          (context, snapshot) {
                                                        final product =
                                                            snapshot.data;
                                                        return ListTile(
                                                          leading: ProductPhotoContainer(
                                                              image: product !=
                                                                      null
                                                                  ? product.get(
                                                                      'images')[0]
                                                                  : '' // 'assets/images/trybae41.jpg',
                                                              ) /*CircleAvatar(
                                                                                      backgroundColor: Colors.white,
                                                                                      child: Image.asset(
                                                                                          'assets/images/trybae41.jpg'))*/
                                                          ,
                                                          title: Text(
                                                            product != null
                                                                ? product
                                                                    .get('name')
                                                                : '', //'Black Summer Tee',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            designer != null
                                                                ? designer
                                                                : '', //'Kng Lulat',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          trailing: Text(
                                                            product != null
                                                                ? product.get(
                                                                    'price')
                                                                : '',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                              )
                                            ]),
                                        Divider(
                                          color: Color(0xFFF5F6F9),
                                          height: 5,
                                        )
                                      ]),
                                );
                              });
                        })
                      ]);
                    } else {
                      return Text('No Orders yet');
                    }
                  }) /*StreamBuilder(
                stream: streamOfOrders,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    getOrders(Database().ordersReference);
                    print(' length of orders : ${snapshot.data.docs.length}');
                    return Column(
                      children: [
                        CategoryPicker(
                          whenTabChanges: (int index) {
                            if (index != 0) {
                              /*OrderState currentOrderState =
                              OrderState.values[index - 1];*/
                              setState(() {
                                streamOfOrders = streamOfOrders.where((event) {
                                  return event.docs
                                      .where((element) =>
                                          humanizeCategory(
                                              element.get('status')) ==
                                          humanizeCategory(OrderState
                                              .values[index - 1]
                                              .toString()))
                                      .every((element) =>
                                          humanizeCategory(
                                              element.get('status')) ==
                                          humanizeCategory(OrderState
                                              .values[index - 1]
                                              .toString()));
                                });
                                print('Set State has run the second time');
                              });
                            } else {
                              setState(() {
                                streamOfOrders = Database().orderssgetter;
                              });
                            }
                          },
                          tabItems: [
                            'All',
                            'Paid',
                            'Unpaid',
                            'Completed',
                            'To be delivered',
                            'In Dispute'
                          ],
                        ),
                        SizedBox(
                            height: getProportionateScreenWidth(context, 10)),
                        SizedBox(
                            height: getProportionateScreenWidth(context, 10)),
                        ...List.generate(orders.length, (index) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 2.0,
                                color: Colors.blueAccent,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                  'You ordered ${orders[index].get('products').length} products'),
                              subtitle: Text(
                                'Ordered at:  ${orders[index].get('plaedAt').toDate()}',
                              ),
                              trailing: Text(
                                'k${orders[index].get('totalPrice')}',
                              ),
                            ),
                          );
                        })
                      ],
                    );
                  } else {
                    return Center(
                      child: Text('No Orders Yet'),
                    );
                  }
                }),
          */
              ),
        ));
  }

  getFuture(process) async {
    final result = await process;
    return result;
  }

  getOrders(CollectionReference reference) async {
    QuerySnapshot<Map<String, dynamic>> myorders = await Database()
        .ordersReference
        .doc(AuthService().auth.currentUser.uid)
        .collection('Orders')
        .get();
    print('${myorders.docs}');
    orders = myorders.docs;
    return myorders.docs;
  }
}

Color getStatusColor(status) {
  switch (status) {
    case 'Accepted':
      return Colors.blueGrey;
    case 'PickedUp':
      return Colors.orangeAccent;

    case 'OnTheWay':
      return Colors.deepPurpleAccent;
    case 'Completed':
      return Colors.green;
    default:
      return Colors.orange;
  }
}

IconData getStatusIcon(status) {
  switch (status) {
    case 'Accepted':
      return Icons.checklist_outlined;

    case 'PickedUp':
      return Icons.checklist_outlined;

    case 'OnTheWay':
      return Icons.delivery_dining_outlined;
    case 'Completed':
      return Icons.delivery_dining_outlined;
    default:
      return Icons.checklist_outlined;
  }
}

String getCommentFromStatus(status) {
  switch (status) {
    case 'Accepted':
      return 'Your order has been accepted';
    case 'PickedUp':
      return 'Your order has been picked up and if on its way to you';
    case 'OnTheWay':
      return 'It is currently on the eway';
    case 'Completed':
      return 'The order has completed successfully';
    default:
      return 'You have successfully placed your order';
  }
}
