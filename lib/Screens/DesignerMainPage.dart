import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/Screens/CollectionPage.dart';
import 'package:TrybaeCustomerApp/models/CollectionModel.dart';
import 'package:TrybaeCustomerApp/models/DesignerModel.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';
import 'package:flutter/material.dart';

class DesignerPage extends StatelessWidget {
  final Designer designer;
  DesignerPage({Key key, @required this.designer}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(children: [
              Container(
                  child: ClipRRect(
                    child: Image.asset(
                      designer.designerImage,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6)
                      ])),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_back),
                          color: Colors.black,
                        )),
                    Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search),
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
              Positioned(
                left: 10,
                bottom: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Text(
                        designer.name,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(context, 5),
                      ),
                      if (designer.verified == true)
                        Icon(
                          Icons.check_circle,
                          color: Colors.blueAccent,
                        ),
                    ],
                  ),
                ),
              ),
            ]),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(offset: Offset(2, 3), color: Colors.grey[300])
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              //width: 300,
              //height: 300,
              //padding: EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getProportionateScreenWidth(context, 8),
                  ),

                  /*Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'You are to make sure that the referral for studies at Kazan Federal University has been provided for you. You can do it accessing your personal profile at www.russia-edu.ru, Education in Russia for Foreign Nationals website. If your referral has been filed, your status at the personal profile shall be “Sent for studies”. Please take into account that you will be able to get enrolled into the University and will be accommodated at the University dormitory, only in case you have the referral. ',
                ),
              ),*/
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text('Collections',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w300))
                ],
              ),
            ),
            Container(
                height: 300,
                //color: Colors.blue,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: designer.collections.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CollectionPage(
                                designer: designer,
                                collection: Collection(
                                    collectionName: designer.collections[index]
                                        ['collectionName'],
                                    photo: designer.collections[index]['photo'],
                                    productsInCollection:
                                        designer.collections[index]
                                            ['productsInCollection']));
                          },
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 210,
                        //color: Colors.red,
                        //decoration: BoxDecoration(color: Colors.red),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned(
                              bottom: 25,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        designer.collections[index]
                                                ['collectionName']
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black))
                                  ],
                                ),
                                height: 70,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Container(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      designer.collections[index]['photo'],
                                      height: 180,
                                      width: 180,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 2),
                                            blurRadius: 6)
                                      ])),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text('Other Products',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w300))
                ],
              ),
            ),
            Container(
                height: 300,
                //color: Colors.blue,
                child: FutureBuilder(
                  future: Database().products.get(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case (ConnectionState.done):
                        List products = snapshot.data.docs
                            .where((product) =>
                                product
                                    .get('designer')
                                    .toString()
                                    .toLowerCase() ==
                                designer.name.toLowerCase())
                            .toList();
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(10),
                              width: 210,
                              //color: Colors.red,
                              //decoration: BoxDecoration(color: Colors.red),
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Positioned(
                                    bottom: 25,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    products[index].get('name'),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.black)),
                                                Text(
                                                    'K${products[index].get('price').toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.black))
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                    Icons.add_shopping_cart))
                                          ],
                                        ),
                                      ),
                                      height: 80,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15.0),
                                    child: Container(
                                        child: ClipRRect(
                                          child: Image.asset(
                                            products[index].get('images')[0],
                                            height: 180,
                                            width: 180,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 2),
                                                  blurRadius: 6)
                                            ])),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                        break;
                      default:
                        return CircularProgressIndicator();
                    }
                  },
                )),
          ]),
        ));
  }
}


 /*return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
          title: Text("Designer's Page"),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              30.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    child: Image.asset(
                      'images/TrybaeSamplephoto.jpg',
                      //width: 300,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(offset: Offset(2, 3), color: Colors.grey[300])
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  //width: 300,
                  //height: 300,
                  //padding: EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getProportionateScreenWidth(context, 8),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Text(
                              'Mix Kasamwa',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(context, 5),
                            ),
                            Icon(
                               Icons.check_circle ,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('You are to make sure that the referral for studies at Kazan Federal University has been provided for you. You can do it accessing your personal profile at www.russia-edu.ru, Education in Russia for Foreign Nationals website. If your referral has been filed, your status at the personal profile shall be “Sent for studies”. Please take into account that you will be able to get enrolled into the University and will be accommodated at the University dormitory, only in case you have the referral. ',),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenWidth(context, 20),
                ),
                ...List.generate(
                    3,
                    (index) => GestureDetector(
                          onTap: () {
                            print('Yeppii');
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),

                            //width: 250,
                            //height: 250,
                            child: Column(
                              children: [
                                ClipRRect(
                                    child: Image.asset(
                                      'images/TrybaeSamplephoto.jpg',
                                      //width: 300,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text('LSK Culture')),
                              ],
                            ),
                          ),
                        ))
              ],
            ),
          ),
        )));
  */