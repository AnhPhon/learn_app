

import 'package:flutter/material.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';

class OrderContent extends StatelessWidget {
  const OrderContent({
    Key? key,
    required this.title,
    required this.value,
    this.boldValue = false,
  }) : super(key: key);
  final String title;
  final double value;
  final bool? boldValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_SMALL,
        right: Dimensions.PADDING_SIZE_SMALL,
        top: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE
          )),
          Text("${CurrencyConverter.currencyConverterVND(value)} VNĐ" , style: TextStyle(
            color: ColorResources.BLACK,
            fontWeight: boldValue! ? FontWeight.bold : FontWeight.normal,
            fontSize: Dimensions.FONT_SIZE_LARGE,
          )),
        ],
      ),
    );
  }
}
