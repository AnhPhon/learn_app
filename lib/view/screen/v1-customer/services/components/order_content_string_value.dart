

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class OrderContentStringValue extends StatelessWidget {
  const OrderContentStringValue({
    Key? key,
    required this.title,
    required this.value,
    this.boldValue = false,
    this.boldTitle = false,
    this.padding,
  }) : super(key: key);
  final String title;
  final String value;
  final bool? boldValue;
  final bool? boldTitle;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: boldTitle! ? FontWeight.bold : FontWeight.normal
          )),
          Flexible(
            child: Text(value , 
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: ColorResources.BLACK,
              fontWeight: boldValue! ? FontWeight.bold : FontWeight.normal,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            )),
          ),
        ],
      ),
    );
  }
}
