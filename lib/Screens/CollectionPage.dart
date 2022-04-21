import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/models/CollectionModel.dart';
import 'package:TrybaeCustomerApp/models/DesignerModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatelessWidget {
  Designer designer;
  Collection collection;
  CollectionPage({this.designer, this.collection});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Stack(children: [
          Container(
              child: ClipRRect(
                child: Image.asset(
                  collection.photo,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              width: double.infinity,
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
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
        ]),
      ),
      SliverToBoxAdapter(
        child:
            CollectionDescription(collection: collection, designer: designer),
      ),
      SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          return FutureBuilder(
            future: Database()
                .products
                .doc(collection.productsInCollection[index])
                .get(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case (ConnectionState.done):
                  DocumentSnapshot product = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 135,
                            width: 160,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: Image.asset(
                                product.get('images')[0],
                                fit: BoxFit.cover,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                              product.get('name').toString().toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                        ),
                        Text('K${product.get('price').toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black))
                      ],
                    ),
                  );

                case (ConnectionState.waiting):
                  return SliverToBoxAdapter(
                    child: CircularProgressIndicator(),
                  );
                  break;
                default:
                  return SliverToBoxAdapter(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          );
        }, childCount: collection.productsInCollection.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 3.0,
          crossAxisSpacing: 3.0,
        ),
      ),
    ]));
    /*Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.75, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 180,
                            width: 160,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              child: Image.asset(
                                'images/trybae41.jpg',
                                fit: BoxFit.cover,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('Black V neck',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                        ),
                        Text('K${300.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.black))
                      ],
                    ),
                  );
                },
              ),
            )
          */

    /*return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  child: Image.asset(
                    'images/TrybaeSamplephoto.jpg',
                    //width: 300,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              Text(designer.name),
              Text(collection.collectionName),
              SizedBox(
                height: getProportionateScreenWidth(context, 10),
              ),
              Expanded(
                child: GridView.builder(
                  //shrinkWrap: true,
                  itemCount: collection.productsInCollection.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 5.0,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),

                        //width: 250,
                        //height: 250,
                        child: Column(
                          children: [
                            ClipRRect(
                                child: Image.asset(
                                  collection
                                      .productsInCollection[index].images.first,
                                  //width: 300,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(collection.collectionName)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  */
  }
}

class CollectionDescription extends StatelessWidget {
  const CollectionDescription({
    Key key,
    @required this.collection,
    @required this.designer,
  }) : super(key: key);

  final Collection collection;
  final Designer designer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            collection.collectionName,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w300, color: Colors.black),
          ),
          Row(
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'By ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.black)),
                TextSpan(
                  text: designer.name,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                )
              ])),
              SizedBox(
                width: getProportionateScreenWidth(context, 5),
              ),
              Icon(
                Icons.check_circle,
                color: Colors.blueAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
