import 'package:flutter/material.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class BtnCustom extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String text;
  final double width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool? isPadding;
  const BtnCustom({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
    required this.width,
    this.isPadding,
    this.margin,
    this.padding,
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
          margin: margin,
          padding: padding ??
              const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          height: isPadding == true
              ? DeviceUtils.getScaledHeight(context, .1)
              : DeviceUtils.getScaledHeight(context, .065),
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            color: color,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
