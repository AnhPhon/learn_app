

import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class OrderContent extends StatelessWidget {
  const OrderContent({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
          )),
          Text(value, style: const TextStyle(
            color: ColorResources.BLACK,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          )),
        ],
      ),
    );
  }
}
