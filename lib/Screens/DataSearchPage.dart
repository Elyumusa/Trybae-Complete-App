import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/main.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
      IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showResults(context);
          })
    ];
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: () {});
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    if (resultList != null) {
      return ListView.builder(
        itemBuilder: (context, index) {
          if (isQueryForDesigners == true) {
            try {
              return ListTile(
                  onTap: () {
                    close(context, resultList[index]);
                  },
                  leading: Padding(
                    child: Image.asset(resultList[index].get('images')[0]),
                    padding: EdgeInsets.all(8),
                  ),
                  title: Text('${resultList[index].get('name').toString()}'),
                  subtitle: RichText(
                      text: TextSpan(
                          text:
                              '${resultList[index].get('designer').toString()}'
                                  .substring(0, query.length),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                          text:
                              '${resultList[index].get('designer').toString()}'
                                  .substring(query.length),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ])));
            } on StateError catch (e) {
              return ListTile(
                  onTap: () {
                    close(context, resultList[index]);
                  },
                  leading: Padding(
                    child: Image.asset(resultList[index].get('designerImage')),
                    padding: EdgeInsets.all(8),
                  ),
                  title: RichText(
                      text: TextSpan(
                          text: '${resultList[index].get('name').toString()}'
                              .substring(0, query.length),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                          text: '${resultList[index].get('name').toString()}'
                              .substring(query.length),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        )
                      ])));
            }
          } else {
            return ListTile(
                onTap: () {
                  close(context, resultList[index]);
                },
                leading: Padding(
                  child: Image.asset(resultList[index].get('images')[0]),
                  padding: EdgeInsets.all(8),
                ),
                title: RichText(
                    text: TextSpan(
                        text: '${resultList[index].get('name').toString()}'
                            .substring(0, query.length),
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        children: [
                      TextSpan(
                        text: '${resultList[index].get('name').toString()}'
                            .substring(query.length),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ])));
          }
        },
        itemCount: resultList == null ? 0 : resultList.length,
      );
    }
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  Stream<QuerySnapshot> getDesigners = Database().designerssgetter;
  List<QueryDocumentSnapshot> resultList;
  bool isQueryForDesigners;
  @override
  Widget buildSuggestions(BuildContext context) {
    List<QueryDocumentSnapshot> list;
    // TODO: implement buildSuggestions
    List<Stream<QuerySnapshot>> listOfStreams =
        MyHomePage.of(context).blocProvider.productBloc.productsByStreams;
    if (listOfStreams.length == 1) listOfStreams.add(getDesigners);
    return StreamBuilder(
        stream: listOfStreams.first,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //print('here is some data: ${snapshot.data.docs}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('NO DATA');

            case ConnectionState.active:
              List<QueryDocumentSnapshot> list = query.isEmpty
                  ? null
                  : snapshot.data.docs
                      .where((element) =>
                          element.get('name').toString().startsWith(query))
                      .toList();
              if (list == null) {
                return Text('');
              }
              List<QueryDocumentSnapshot> listOfProducts = snapshot.data.docs;
              return StreamBuilder(
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text('Just A Minute');

                    case ConnectionState.active:
                      List<QueryDocumentSnapshot> designersandTheirProducts =
                          [];
                      if (query.isNotEmpty) {
                        List<QueryDocumentSnapshot> designers = snapshot
                            .data.docs
                            .where((element) => element
                                .get('name')
                                .toString()
                                .toLowerCase()
                                .startsWith(query.toLowerCase()))
                            .toList();
                        for (var d in designers) {
                          designersandTheirProducts.add(d);
                        }
                        List<QueryDocumentSnapshot> theirProducts =
                            listOfProducts
                                .where(
                                  (product) => product
                                      .get('designer')
                                      .toString()
                                      .toLowerCase()
                                      .startsWith(query.toLowerCase()),
                                )
                                .toList();
                        for (var product in theirProducts) {
                          designersandTheirProducts.add(product);
                        }
                      }

                      if (designersandTheirProducts.isEmpty) {
                        return Text('');
                      }
                      isQueryForDesigners = true;
                      list = designersandTheirProducts;
                      resultList = list;
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          try {
                            return designersandTheirProducts.isEmpty
                                ? ListTile(
                                    onTap: () {
                                      query =
                                          list[index].get('name').toString();
                                    },
                                    leading: Padding(
                                      child: Image.asset(
                                          list[index].get('images')[0]),
                                      padding: EdgeInsets.all(8),
                                    ),
                                    title: RichText(
                                        text: TextSpan(
                                            text:
                                                '${list[index].get('name').toString()}'
                                                    .substring(0, query.length),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            children: [
                                          TextSpan(
                                            text:
                                                '${list[index].get('name').toString()}'
                                                    .substring(query.length),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          )
                                        ])))
                                : ListTile(
                                    onTap: () {
                                      query =
                                          list[index].get('name').toString();
                                    },
                                    leading: Padding(
                                      child: Image.asset(
                                          list[index].get('images')[0]),
                                      padding: EdgeInsets.all(8),
                                    ),
                                    title: Text(
                                        '${list[index].get('name').toString()}'),
                                    subtitle: RichText(
                                        text: TextSpan(
                                            text:
                                                '${list[index].get('designer').toString()}'
                                                    .substring(0, query.length),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            children: [
                                          TextSpan(
                                            text:
                                                '${list[index].get('designer').toString()}'
                                                    .substring(query.length),
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          )
                                        ])));
                          } on StateError catch (e) {
                            return ListTile(
                                onTap: () {
                                  query = list[index].get('name').toString();
                                },
                                leading: Padding(
                                  child: Image.asset(
                                      list[index].get('designerImage')),
                                  padding: EdgeInsets.all(8),
                                ),
                                title: RichText(
                                    text: TextSpan(
                                        text:
                                            '${list[index].get('name').toString()}'
                                                .substring(0, query.length),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                      TextSpan(
                                        text:
                                            '${list[index].get('name').toString()}'
                                                .substring(query.length),
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    ])));
                          }
                        },
                        itemCount: list == null ? 0 : list.length,
                      );
                    default:
                      print('Its on default');
                      return Text('NO DATA');
                  }
                },
                stream: listOfStreams[1],
              );

            default:
              print('Its on default');
              return Text('NO DATA');
          }
        });

    throw UnimplementedError();
  }
}
