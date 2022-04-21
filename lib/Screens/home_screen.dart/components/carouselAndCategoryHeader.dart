import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselAndCategoryHeader extends StatelessWidget {
  final List<String> images;
  const CarouselAndCategoryHeader({
    @required this.images,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CarouselSlider(
            items: [
              ...List.generate(
                images.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  //height: 250,
                  // width: 220,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(images[index],
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover)),
                ),
              )
            ],
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1.5,
              //height: MediaQuery.of(context).size.width,
              viewportFraction: 1.0,
            )),
        SizedBox(
          height: 10,
        ),
        Text('Categories'),
        SizedBox(
          height: 10,
        ),
      ]),
    ));
  }
}
