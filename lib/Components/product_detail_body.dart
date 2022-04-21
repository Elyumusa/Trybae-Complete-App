import 'package:TrybaeCustomerApp/FlutterFireServices/database.dart';
import 'package:TrybaeCustomerApp/blocs/ProductBloc.dart';
import 'package:TrybaeCustomerApp/models/ProductModel.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'DefaultButton.dart';
import 'ScreenMeasurementDetails.dart';
import 'package:flutter/material.dart';

class ProductDetailBody extends StatefulWidget {
  final Product product;
  ProductDetailBody({this.product});

  @override
  _ProductDetailBodyState createState() => _ProductDetailBodyState();
}

num selected = 0;
num selectedColor;
num quantityChosen = 1;

class _ProductDetailBodyState extends State<ProductDetailBody> {
  List<Color> colors = [
    Colors.white,
    Colors.purple,
    Colors.orange,
    Colors.black
  ];

  updateColor(num index) {
    setState(() {
      print('Buutttttt');
      selectedColor = index;
    });
  }

  ProductBloc productBloc;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    productBloc = MyHomePage.of(context).blocProvider.productBloc;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: SizedBox(
              height: getProportionateScreenHeight(context, 238),
              child: Image.asset(
                'images/trybae41.jpg',
                height: 238,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List<Widget>.generate(2, (index) => buildImage(index))
            ],
          ),
          TopRoundedContainer(
              color: Colors.white,
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.product.name, //'Lsk Starter Pack Black Tee',
                        style: TextStyle(
                            fontSize: 22,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                  TextSpan(
                                    text: 'By ',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextSpan(
                                    text: widget
                                        .product.designer, //' Mix Kasamwa',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w900),
                                  )
                                ]))),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: getProportionateScreenWidth(context, 64),
                            padding: const EdgeInsets.all(10),
                            //height: getProportionateScreenWidth(context, 48),
                            child: Icon(Icons.camera),
                            decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15))),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 8),
                      child: Text(
                        'ZMW ${widget.product.price.toStringAsFixed(2)}', //'K200',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 20),
                      child: Text(
                        widget.product.description, //'',
                        maxLines: 3,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: getProportionateScreenWidth(context, 20),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    getProportionateScreenWidth(context, 20)),
                            child: Row(children: [
                              ...List.generate(
                                  colors.length,
                                  (index) =>
                                      buildColors(context, index, colors, () {
                                        setState(() {
                                          print('Buutttttt');
                                          selectedColor = index;
                                        });
                                      }, selectedColor)),
                              Spacer(),
                              Container(
                                //width: getProportionateScreenWidth(context, 100),
                                height:
                                    getProportionateScreenWidth(context, 30),
                                decoration: BoxDecoration(
                                    //color: Color(0xFFF5F6F9),
                                    borderRadius: BorderRadius.circular(10)),
                                child: EditQuantityWidget(
                                  quantity: 1,
                                  removeFunction: () {
                                    setState(() {
                                      quantityChosen -= 1;
                                    });
                                  },
                                  addFunction: () {
                                    setState(() {
                                      quantityChosen += 1;
                                    });
                                  },
                                ),
                              ),
                            ]),
                          ),
                          TopRoundedContainer(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: getProportionateScreenWidth(context, 15),
                                  bottom:
                                      getProportionateScreenWidth(context, 25),
                                  left: screenWidth * 0.15,
                                  right: screenWidth * 0.15),
                              child: DefaultButton(
                                onPressed: () {},
                                string: 'Add To Cart',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ])),
          /* */
        ],

        /*8*/
      ),
    );
  }

  Widget buildImage(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = index;
        });
      },
      child: Container(
        margin:
            EdgeInsets.only(right: getProportionateScreenWidth(context, 10)),
        width: 48, //getProportionateScreenWidth(context, 48),
        height: 48, //
        child: Image.asset(
          'images/trybae41.jpg',
          fit: BoxFit.cover,
        ),
        //padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: selected == index
                    ? Colors.deepOrangeAccent
                    : Colors.transparent)),
      ),
    );
  }
}

Widget buildColors(BuildContext context, num index, List<Color> colors,
    Function onTap, num selectedColor) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: getProportionateScreenHeight(context, 40),
      height: getProportionateScreenHeight(context, 40),
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.only(right: 2),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: selectedColor == index
                  ? Theme.of(context).primaryColor
                  : Colors.transparent)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colors[index],
        ),
      ),
    ),
  );
}

class EditQuantityWidget extends StatelessWidget {
  const EditQuantityWidget({
    Key key,
    @required this.addFunction,
    @required this.removeFunction,
    @required this.quantity,
  }) : super(key: key);

  final Function addFunction;
  final Function removeFunction;
  final num quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ButtonContainer(
            child: InkWell(
              onTap: removeFunction,
              child: Icon(
                Icons.remove,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(context, 12),
          ),
          Center(
            child: Text(
              '$quantity',
              // style: TextStyle(fontSize: 12),
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(context, 12),
          ),
          ButtonContainer(
            child: InkWell(
              onTap: addFunction,
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RelatedProductContainer extends StatelessWidget {
  const RelatedProductContainer({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: getProportionateScreenWidth(context, 8.0),
          bottom: getProportionateScreenWidth(context, 10.0),
          left: getProportionateScreenWidth(context, 8.0),
          right: getProportionateScreenWidth(context, 8.0),
        ),
        width: getProportionateScreenWidth(context, 150),
        height: getProportionateScreenWidth(context, 65),
        decoration: BoxDecoration(
            color: Color(0xFFF5F6F9), borderRadius: BorderRadius.circular(10)),
        child: child);
  }
}

class ButtonContainer extends StatelessWidget {
  final Widget child;
  const ButtonContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(offset: Offset(2, 2), color: Colors.grey)],
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          shape: BoxShape.circle),
      //width: getProportionateScreenWidth(context, 20),
      height: 34,
      width: 34,
      child: child,
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key key,
    @required this.child,
    @required this.color,
  }) : super(key: key);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: getProportionateScreenWidth(context, 20),
      ),
      padding: EdgeInsets.only(
        top: getProportionateScreenWidth(context, 20),
      ),
      child: child,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: color),
    );
  }
}
