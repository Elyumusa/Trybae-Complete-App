import 'package:TrybaeCustomerApp/Components/edit_profile.dart';
import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/Screens/account_screen.dart';
import 'package:TrybaeCustomerApp/blocs/CartBloc.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../DataSearchPage.dart';
import '../../Notifications.dart';
import '../../cart_screen.dart';
import '../../my_orders.dart';

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
    Key key,
    @required this.cartBloc,
  }) : super(key: key);

  final CartBloc cartBloc;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Home', style: TextStyle(color: Colors.white, fontSize: 25)),
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            //Database().placeOrder();
            /*Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Account();
              },
            ));*/
          },
          icon: Icon(Icons.menu_rounded)),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return MyOrdersPage();
              },
            ));
          },
          icon: Icon(
            Icons.edit,
            //color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () async {
            final searchResult =
                await showSearch(context: context, delegate: DataSearch());
            print('This is from showSearch : $searchResult');
          },
          icon: Icon(
            Icons.search_outlined,
            //color: Colors.white,
          ),
        ),
        StreamBuilder<Object>(
            stream: cartBloc.updatedCart.stream,
            builder: (context, snapshot) {
              return InkResponse(
                  child: Text('${cartBloc.cart.length}'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return CartScreen();
                      },
                    ));
                  });
            })
        /*IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return CartScreen();
                },
              ));
            })*/
      ],
    );
  }
}
