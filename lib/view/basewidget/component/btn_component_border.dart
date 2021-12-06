import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';

class BtnCustomBorder extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  const BtnCustomBorder({
    Key? key,
    required this.onTap,
    required this.text,
    required this.width,
    this.margin,
    this.padding,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_LARGE,
        ),
        child: Container(
          height: DeviceUtils.getScaledHeight(context, height ?? .065),
          width: width,
          margin: margin ?? EdgeInsets.zero,
          padding: padding ??
              const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: ColorResources.PRIMARY),
            borderRadius:
                BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            color: ColorResources.WHITE,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorResources.PRIMARY,
            ),
          ),
        ),
      ),
    );
  }
}
