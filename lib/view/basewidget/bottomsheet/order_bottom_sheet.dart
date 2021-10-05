

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class OrderBottomSheet extends StatelessWidget {
  const OrderBottomSheet({
    Key? key,
    required this.children,
    required this.itemValue,
  }) : super(key: key);
  final List<Widget> children;
  final String itemValue;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        width: DeviceUtils.getScaledWidth(context, 1),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), 
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 10,
              spreadRadius: 0.1,
              color: ColorResources.BLACK.withOpacity(0.5)
            ),
          ]
        ),
        child: Column(
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                fontWeight: FontWeight.bold,
                color: ColorResources.BLACK
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Giá trị đơn hàng:"),
                  Text("$itemValue VNĐ", style: const TextStyle(
                    color: ColorResources.RED
                  ),)
                ],
              ),
            ),
            Expanded(
              child: DefaultTextStyle(
                style: const TextStyle(color: ColorResources.WHITE),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...children
                  ],
                ),
              ),
            )
          ],
        )
      );
  }
}
