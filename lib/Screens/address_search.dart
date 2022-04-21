import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddressSearch extends SearchDelegate {
  String sessionToken;
  AddressSearch({sessionToken});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
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
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  Stream<QuerySnapshot> getDesigners = Database().designerssgetter;
  Widget buildSuggestions(BuildContext context) {}
}
