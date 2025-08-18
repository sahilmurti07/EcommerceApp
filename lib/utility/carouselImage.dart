import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_application_1/data/productModel.dart';
import 'package:flutter_application_1/BLOC/home_bloc/home_bloc.dart';

class CarouselimageUI extends StatefulWidget {
  final List<Product> productList;
  final HomeBloc homebloc;
  CarouselimageUI({
    super.key,
    required this.productList,
    required this.homebloc,
  });

  @override
  State<CarouselimageUI> createState() => _CarouselimageUIState();
}

class _CarouselimageUIState extends State<CarouselimageUI> {
  final List<Color> carouselColors = [
    Color(0xFFFFC1CC), // Soft Pink
    Color(0xFFA7E9AF), // Mint
    Color(0xFFB5EAEA), // Baby Blue
    Color(0xFFFFE5B4), // Peach
    Color(0xFFE5C1F9), // Lavender
    Color(0xFFFFF6B7), // Soft Yellow
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items:
          widget.productList.map((product) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    widget.homebloc.add(NavigateToDetailPageEvent(product));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: carouselColors[product.id % carouselColors.length],

                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.thumbnail,
                        fit: BoxFit.contain,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
      options: CarouselOptions(
        height: 110,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    );
  }
}
