import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/Screens/DesignerMainPage.dart';
import 'package:TrybaeCustomerApp/models/DesignerModel.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  Product product;
  ProductCard({this.product});
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: Database().designers.doc(widget.product.designer).get(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case (ConnectionState.done):
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                    height: 800,
                    //width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child:
                                    Image.asset(widget.product.images.first)),
                            Positioned(
                              child: IconButton(
                                  icon: Icon(Icons.access_alarm),
                                  color: Colors.white,
                                  onPressed: () {
                                    /*if (favorite == false) {
                        Order order = Order(user, widget.product, OrderState.Unpaid);
                        userBloc.totalOrders.add(order);
                        userBloc.wishList.add(order);
                        setState(() {
                          favorite = true;
                        });
                      } else {
                        userBloc.wishList.remove(widget.product);
                        setState(() {
                          favorite = false;
                        });
                      }*/

                                    //return Navigator.push(context,);
                                  }),
                              top: -10,
                              right: -2,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                DocumentSnapshot designerDocument =
                                    snapshot.data;

                                Designer designer = Designer(
                                    name: designerDocument.get('name'),
                                    collections:
                                        designerDocument.get('collections'),
                                    bio: designerDocument.get('bio'),
                                    designerImage:
                                        designerDocument.get('designerImage'),
                                    verified: designerDocument.get('verified'));
                                return DesignerPage(designer: designer);
                              },
                            ));
                          },
                          child: Text(
                            ' By ${widget.product.designer}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'K${widget.product.price}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    )),
              );

            case (ConnectionState.waiting):
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        });
  }
}
