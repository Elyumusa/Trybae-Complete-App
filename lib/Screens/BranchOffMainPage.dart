import 'package:TrybaeCustomerApp/Screens/OrderSummaryPage.dart';
import 'package:TrybaeCustomerApp/Screens/PaymentPage.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'DeliverDetailsPage.dart';

class BranchOffPage extends StatefulWidget {
  @override
  _BranchOffPageState createState() => _BranchOffPageState();
}

num currentIndex = 0;

class _BranchOffPageState extends State<BranchOffPage>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  Widget appBarTitle;
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {
        switch (_controller.index) {
          case (0):
            appBarTitle = Text(
              'Delivery ',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            );
            break;
          case (1):
            appBarTitle = Text(
              'Payment ',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            );
            break;
          default:
            appBarTitle = Text(
              'Order Summary',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            );
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    MyHomePage.of(context).blocProvider.tabBloc.controller = _controller;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          toolbarHeight: 130,
          centerTitle: true,
          elevation: 16,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
          title: appBarTitle,
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _controller,
            //indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.transparent,
            tabs: [
              TabOption(
                index: 0,
                controller: _controller,
                icon: Icon(
                  Icons.location_on_outlined,
                ),
              ),
              TabOption(
                index: 1,
                controller: _controller,
                icon: Icon(Icons.payment_outlined),
              ),
              TabOption(
                index: 2,
                controller: _controller,
                icon: Icon(Icons.list),
              )
              //DefaultTabController(length: length, child: child)
            ],
          ),
        ),
        body: TabBarView(
            controller: _controller,
            children: [DeliveryDetailsPage(), PaymentPage(), OrderSummary()]));
  }
}

class TabOption extends StatelessWidget {
  final num index;
  final Widget icon;
  final TabController controller;
  const TabOption({
    this.index,
    this.icon,
    this.controller,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color:
                index == controller.index ? Colors.blue : Colors.transparent),
        child: icon,
      ),
    );
  }
}
