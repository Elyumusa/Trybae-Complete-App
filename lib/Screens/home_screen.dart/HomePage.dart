import 'dart:async';
import 'dart:io';

import 'package:TrybaeCustomerApp/Components/CustomSliverHeader.dart';
import 'package:TrybaeCustomerApp/Components/DesignerCard.dart';
import 'package:TrybaeCustomerApp/Components/Humanize_Category.dart';
import 'package:TrybaeCustomerApp/Components/ProductCard.dart';
import 'package:TrybaeCustomerApp/Components/category_picker.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/authentication.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/Screens/EditProfile.dart';
import 'package:TrybaeCustomerApp/Screens/ProductScreen.dart';
import 'package:TrybaeCustomerApp/Screens/cart_screen.dart';
import 'package:TrybaeCustomerApp/Screens/new_product_screen.dart';
import 'package:TrybaeCustomerApp/blocs/CartBloc.dart';
import 'package:TrybaeCustomerApp/blocs/ProductBloc.dart';
import 'package:TrybaeCustomerApp/main.dart';
import 'package:TrybaeCustomerApp/models/DesignerModel.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:TrybaeCustomerApp/Components/edit_profile.dart';
import '../../SampleProducts.dart';
import '../DataSearchPage.dart';
import '../DesignerMainPage.dart';
import '../Notifications.dart';
import '../OrderSummaryPage.dart';
import '../my_orders.dart';
import 'components/carouselAndCategoryHeader.dart';
import 'components/getAllDesignersFromDb.dart';
import 'components/home_page_appBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<Widget> productsAndCategory = [];
Map<String, Widget> mapOfCategorisedProducts = {};
saveTokenToDB() async {
  String useruid = AuthService().auth.currentUser.uid;
  final fCMToken = await FirebaseMessaging.instance.getToken();
  print('$fCMToken');
  CollectionReference myTokens = FirebaseFirestore.instance
      .collection('users')
      .doc(useruid)
      .collection('Tokens');

  myTokens.doc(fCMToken).get().then((value) {
    if (!value.exists) {
      myTokens.add({
        'token': fCMToken,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem
      });
    }
  });
}

class _HomePageState extends State<HomePage> {
  ProductBloc productBloc;
  List<Widget> myProducts;
  List<Product> sampleProducts;
  AuthService authService;
  List<Stream<QuerySnapshot>> productsByStreams;
  CartBloc cartBloc;
  Stream<Map<String, dynamic>> notifications;
  @override
  void initState() {
    super.initState();
  }

  StreamController<bool> updatedCart;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print(
        'This is from productBloc ${MyHomePage.of(context).blocProvider.productBloc}');
    productBloc = MyHomePage.of(context).blocProvider.productBloc;
    cartBloc = MyHomePage.of(context).blocProvider.cartBloc;
    //sampleProducts ??= productBloc.products;
    productsByStreams = productBloc.productsByStreams;
    updatedCart = MyHomePage.of(context).blocProvider.cartBloc.updatedCart;
    myProducts ??= buildProducts(productsByStreams);
    notifications = MyHomePage.of(context)
        .blocProvider
        .userAuthStatebloc
        .notificationsController
        .stream;
    super.didChangeDependencies();
  }

  List<Widget> buildProducts(List<Stream<QuerySnapshot>> productsByStreams) {
    List<Widget> p = [];
    for (var category in ProductCategory.values) {
      p.add(StreamBuilder<QuerySnapshot>(
        //initialData: sampleProducts,
        stream: productsByStreams.first,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return SliverToBoxAdapter(
                child: Text('NO DATA'),
              );
            case ConnectionState.active:
              List<QueryDocumentSnapshot> list =
                  snapshot.data.docs.where((element) {
                return element.get('category').toString().toLowerCase() ==
                    humanizeCategory(category.toString()).toLowerCase();
              }).toList();
              print('List document change: $list');
              list.isEmpty
                  ? mapOfCategorisedProducts[
                          humanizeCategory(category.toString()).toLowerCase()] =
                      SliverToBoxAdapter(
                      child: Text(
                          'No ${humanizeCategory(category.toString()).toLowerCase()}'),
                    )
                  : mapOfCategorisedProducts[list.first
                      .get('category')
                      .toString()
                      .toLowerCase()] = SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 3.0,
                        crossAxisSpacing: 3.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        DocumentSnapshot productDocument = list.isEmpty
                            ? snapshot.data.docs[index]
                            : list[index];
                        Product ourProduct = Product(
                            productDocument.get('name'),
                            productDocument.get('images'),
                            productDocument.get('price'),
                            productDocument.get('quantity'),
                            productDocument.get('rating'),
                            productDocument.get('description'),
                            productDocument.get('designer'),
                            productDocument.get('category'),
                            productDocument.get('availableColors'));
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return NewProductScreen(
                                  productDocument: productDocument,
                                );
                                /*return ProductDetailPage(
                                  product: ourProduct,
                                );*/
                              },
                            ));
                            /*if (!cartBloc.cart
                                .map((e) => e['product'].id)
                                .contains(productDocument.id)) {
                              print('It is not in cart so you can add');
                              cartBloc.cart.add({
                                'product': productDocument,
                                'quantity': '1'
                              });
                              cartBloc.updatedCart.add(true);
                            } else {
                              print('already in cart');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'You already added this item to the cart')));
                            }*/
                          },
                          child: ProductCard(
                            product: ourProduct,
                          ),
                        );
                      },
                          childCount: list.isEmpty
                              ? snapshot.data.docs.length
                              : list.length ?? 0),
                    );
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 3.0,
                ),
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  DocumentSnapshot productDocument = list[index];
                  Product ourProduct = Product(
                      productDocument.get('name'),
                      productDocument.get('images'),
                      productDocument.get('price'),
                      productDocument.get('quantity'),
                      productDocument.get('rating'),
                      productDocument.get('description'),
                      productDocument.get('designer'),
                      productDocument.get('category'),
                      productDocument.get('availableColors'));
                  /*return IconButton(
                      icon: Icon(Icons.account_balance),
                      onPressed: () {
                        print(' cart from cartbloc ${cartBloc.cart}');
                      });*/
                  return GestureDetector(
                    onTap: () {
                      if (!cartBloc.cart
                          .map((e) => e['product'].id)
                          .contains(productDocument.id)) {
                        print('It is not in cart so you can add');
                        cartBloc.cart
                            .add({'product': productDocument, 'quantity': '1'});
                        cartBloc.updatedCart.add(true);
                      } else {
                        print('already in cart');
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'You already added this item to the cart')));
                      }
                    },
                    child: ProductCard(
                      product: ourProduct,
                    ),
                  );
                }, childCount: list.length ?? 0),
              );
            default:
              print('Its on default');
              return SliverToBoxAdapter(
                child: Text('NO DATA'),
              );
          }
        },
      ));
    }
    productsAndCategory = p;
    print('productsAndCategory:$productsAndCategory');
    return p;
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> designers = [];
  getDesigners() async {
    QuerySnapshot<Map<String, dynamic>> alldesigners =
        await Database().designers.get();

    //
    designers = alldesigners.docs;
    print('${designers}');
  }

  List<Map> test = [
    {
      'product': Product('shirt', [], 200, 23, 4.5, '', '', '', []),
      'quantity': 4
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            HomePageAppBar(cartBloc: cartBloc),
            CarouselAndCategoryHeader(images: ['images/trybae41.jpg']),
            SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: CustomSliverHeader(
                  minHeight: 55.5,
                  maxHeight: 65.5,
                  child: CategoryPicker(
                    tabItems: [
                      'All',
                      'Shirts',
                      'Jewerly',
                      'Hoodies',
                      'Cosmetics',
                      'Designers'
                    ],
                    whenTabChanges: (num currentIndex) {
                      if (currentIndex == 5) {
                        getDesigners();
                        setState(() {
                          myProducts = [
                            getAllDesignersFromDb(),
                          ];
                        });
                        return true;
                      }
                      if (currentIndex == 0) {
                        setState(() {
                          myProducts = productsAndCategory;
                        });
                        return true;
                      }
                      setState(() {
                        Widget newProducts = mapOfCategorisedProducts[
                            '${humanizeCategory(ProductCategory.values[currentIndex - 1].toString()).toLowerCase()}'];
                        myProducts = [newProducts];
                      });
                    },
                  ),
                )),
            ...myProducts,
          ],
          physics: BouncingScrollPhysics(),
        ),
        /**/
      ),
    );
  }
}
