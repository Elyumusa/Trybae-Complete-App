import 'package:TrybaeCustomerApp/Components/DesignerCard.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/models/DesignerModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../DesignerMainPage.dart';

FutureBuilder<QuerySnapshot<Object>> getAllDesignersFromDb() {
  return FutureBuilder(
    future: Database().designers.get(),
    builder: (context, snapshot) {
      switch (snapshot.connectionState) {
        case (ConnectionState.done):
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0,
            ),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              print('designer index:${snapshot.data.docs[index].get('name')}');
              DocumentSnapshot designerDocument = snapshot.data.docs[index];

              Designer designer = Designer(
                  name: designerDocument.get('name'),
                  collections: designerDocument.get('collections'),
                  bio: designerDocument.get('bio'),
                  designerImage: designerDocument.get('designerImage'),
                  verified: designerDocument.get('verified'));
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      print(designer.designerImage);
                      return DesignerPage(
                        designer: designer,
                      );
                    }));
                  },
                  child: DesignerCard(designer: designer));
            }, childCount: 5 ?? 0),
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
}
