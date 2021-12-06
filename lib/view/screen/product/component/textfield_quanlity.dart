import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class TextFieldQuanlity extends StatelessWidget {
  final TextEditingController textEditingController;
  final double? width;
  final double? height;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding, contentPadding;
  final EdgeInsetsGeometry? margin;
  final Color? fillColor;
  final bool? isBorder;
  final ValueChanged<String>? onChanged;
  final Timer? timeHandle;
  final ValueChanged<bool>? onFocusChange;
  final ValueChanged<String>? onSubmitted;
  const TextFieldQuanlity({
    Key? key,
    required this.textEditingController,
    this.width,
    this.isBorder = true,
    this.fillColor,
    this.padding,
    this.margin,
    this.height,
    this.contentPadding,
    this.borderRadius,
    this.onChanged,
    this.timeHandle,
    this.onFocusChange,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height:
          height == null ? null : DeviceUtils.getScaledHeight(context, height!),
      width: width == null ? null : DeviceUtils.getScaledWidth(context, width!),
      child: FocusScope(
        onFocusChange: onFocusChange,
        child: TextField(
          textAlign: TextAlign.center,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          textAlignVertical: TextAlignVertical.center,
          controller: textEditingController,
          cursorColor: ColorResources.PRIMARY,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: contentPadding,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? Dimensions.BORDER_RADIUS_EXTRA_SMALL,
              ),
              borderSide: (isBorder == true)
                  ? const BorderSide(color: ColorResources.PRIMARY)
                  : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? Dimensions.BORDER_RADIUS_EXTRA_SMALL,
              ),
              borderSide: (isBorder == true)
                  ? const BorderSide(color: ColorResources.PRIMARY)
                  : BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                borderRadius ?? Dimensions.BORDER_RADIUS_EXTRA_SMALL,
              ),
              borderSide: (isBorder == true)
                  ? const BorderSide(color: ColorResources.PRIMARY)
                  : BorderSide.none,
            ),
            filled: true,
            fillColor: fillColor ?? Colors.transparent,
          ),
        ),
      ),
    );
  }
}
