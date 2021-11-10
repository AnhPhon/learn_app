import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/dimensions.dart';

class BoxShadowWidget extends StatelessWidget {
  const BoxShadowWidget({
    Key? key,
    this.borderRadius,
    this.elevation,
    required this.child,
    this.padding,
    this.margin,
    this.boxShadowCustom,
  }) : super(key: key);
  final double? borderRadius;
  final double? elevation;
  final Widget child;
  final EdgeInsetsGeometry? padding, margin;
  final List<BoxShadow>? boxShadowCustom;
  @override
  Widget build(BuildContext context) {
    return Material(
      // elevation: elevation ?? 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              borderRadius ?? Dimensions.BORDER_RADIUS_EXTRA_SMALL)),
      child: Container(
          //alignment: Alignment.topLeft,
          margin: margin ?? const EdgeInsets.all(0.0),
          padding: padding ?? const EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            boxShadow: boxShadowCustom ?? boxShadow,
            borderRadius: BorderRadius.circular(
                borderRadius ?? Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            color: ColorResources.WHITE,
          ),
          child: child),
    );
  }
}
