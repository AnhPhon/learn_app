import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:template/base_widget/izi_image.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class IZISlider extends StatelessWidget {
  const IZISlider({
    Key? key,
    this.axis = Axis.horizontal,
    required this.data,
    this.margin,
  }) : super(key: key);
  final Axis? axis;
  final List<String> data;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      child: CarouselSlider.builder(
        itemCount: data.length,
        itemBuilder: (context, index, realIndex) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              imageSlider(
                data[index].toString(),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_2X,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._buildIndicator(
                      length: data.length,
                      currentIndex: index,
                    ),
                  ],
                ),
              )
            ],
          );
        },
        options: CarouselOptions(
          height: IZIDimensions.ONE_UNIT_SIZE * 250,
          autoPlay: true,
          enlargeCenterPage: true,
          scrollDirection: axis!,
        ),
      ),
    );
  }

  Widget imageSlider(String urlImage) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_5X,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_5X,
        ),
        child: IZIImage(
          urlImage,
        ),
      ),
    );
  }

  List<Widget> _buildIndicator({required int length, required int currentIndex}) {
    final List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(i == currentIndex ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      height: isActive ? IZIDimensions.ONE_UNIT_SIZE * 20 : IZIDimensions.ONE_UNIT_SIZE * 18,
      width: isActive ? IZIDimensions.ONE_UNIT_SIZE * 20 : IZIDimensions.ONE_UNIT_SIZE * 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_7X),
        color: isActive ? ColorResources.WHITE : ColorResources.GREY,
      ),
    );
  }
}
