import 'package:flutter/material.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

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
  final double itemValue;
  final MainAxisAlignment? mainAxisAlignment;
  final double? height;
  final Widget? child;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? BOTTOMSHEET,
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_SMALL,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        width: DeviceUtils.getScaledWidth(context, 1),
        decoration: const BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.BORDER_RADIUS_BIG), 
            topRight: Radius.circular(Dimensions.BORDER_RADIUS_BIG),
          ),
          boxShadow: boxShadowMedium
        ),
        child: Column(
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold,
                color: ColorResources.BLACK
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title ?? "Giá trị đơn hàng:"),
                  Text("${CurrencyConverter.currencyConverterVND(itemValue)} VNĐ", style: const TextStyle(
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
