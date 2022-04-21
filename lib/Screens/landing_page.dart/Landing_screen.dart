import 'package:TrybaeCustomerApp/Components/DefaultButton.dart';
import 'package:TrybaeCustomerApp/Components/ScreenMeasurementDetails.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'components/splash_content.dart';

num currentPage = 0;

class LandingPage extends StatefulWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

CarouselController splashContentController = CarouselController();

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    List images = [
      'images/trybae41.jpg',
      'images/trybae4.jpg',
      'images/trybae41.jpg',
      'images/trybae4.jpg',
    ];
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'TRYBAE',
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(context, 36),
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: CarouselSlider.builder(
                    carouselController: splashContentController,
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 0.9,
                      viewportFraction: 1,
                      onPageChanged: (
                        value,
                        CarouselPageChangedReason reason,
                      ) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, ind, index) {
                      return SplashContent(
                        image: images[ind],
                      );
                    },
                  )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(context, 20)),
                  child: Column(
                    children: [
                      Spacer(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(images.length,
                                (index) => buildDot(context, index))
                          ]),
                      Spacer(
                        flex: 3,
                      ),
                      DefaultButton(
                        onPressed: () {},
                        string: 'Continue',
                      ),
                      Spacer(
                        flex: 2,
                      )
                    ],
                  ),
                ),
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildDot(BuildContext context, num index) {
    return GestureDetector(
      onTap: () {
        splashContentController.animateToPage(index);
      },
      child: AnimatedContainer(
        margin: EdgeInsets.only(right: 5),
        duration: Duration(milliseconds: 200),
        height: 7,
        width: currentPage == index ? 20 : 7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: currentPage == index
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.4)),
      ),
    );
  }
}
