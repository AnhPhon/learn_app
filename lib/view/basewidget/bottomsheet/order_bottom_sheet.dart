import 'package:flutter/material.dart';

import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/long_button.dart';

class OrderBottomSheet extends StatelessWidget {
  const OrderBottomSheet({
    Key? key,
    this.children = const [],
    required this.itemValue,
    this.mainAxisAlignment,
    this.height,
    this.child,
    this.title,
  }) : super(key: key);
  final List<Widget>? children;
  final String itemValue;
  final MainAxisAlignment? mainAxisAlignment;
  final double? height;
  final Widget? child;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? BOTTOMSHEET,
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
              offset: const Offset(0, -1),
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
                  Text(title ?? "Giá trị đơn hàng:"),
                  Text("$itemValue", style: const TextStyle(
                    color: ColorResources.RED
                  ),)
                ],
              ),
            ),
            Expanded(
              child: DefaultTextStyle(
                style: const TextStyle(color: ColorResources.WHITE),
                child: child ??
                Row(
                  mainAxisAlignment: mainAxisAlignment ??MainAxisAlignment.spaceBetween,
                  children: [
                    ...children!
                  ],
                )
              ),
            )
          ],
        )
      );
  }
}
