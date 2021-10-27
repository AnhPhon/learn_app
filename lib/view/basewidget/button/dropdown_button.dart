import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class DropDownButton1<T> extends StatelessWidget {
  const DropDownButton1({
    this.hint,
    required this.onChanged,
    required this.data,
    this.value,
    this.obligatory = false,
    this.label,
    this.labelBold = false,
    required this.width,
    this.isBorder = true,
    this.isShadow = false,
    this.padding,
    this.margin,
    this.fillColor,
    this.colorText,
    this.isColorFieldWhite,
    this.height,
  });

  final String? hint;
  final Function(T? i)? onChanged;
  final List<T> data;
  final T? value;
  final bool? obligatory, labelBold, isBorder, isShadow, isColorFieldWhite;
  final String? label;
  final Color? colorText;
  final Color? fillColor;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Wrap(
              children: [
                Text(
                  label.toString(),
                  style: labelBold == true
                      ? Dimensions.fontSizeStyle16w600().copyWith(
                          color: ColorResources.BLACK,
                        )
                      : Dimensions.fontSizeStyle16().copyWith(
                          color: ColorResources.BLACK,
                        ),
                ),
                if (obligatory == true)
                  const Text(
                    "*",
                    style: TextStyle(
                      color: ColorResources.RED,
                    ),
                  ),
              ],
            ),
          if (label != null)
            const SizedBox(
              height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
          Container(
            height: (height != null)
                ? DeviceUtils.getScaledHeight(context, height!)
                : null,
            width: DeviceUtils.getScaledWidth(context, width),
            margin: margin ?? EdgeInsets.zero,
            decoration: BoxDecoration(
              boxShadow: (isShadow == true)
                  ? [
                      BoxShadow(
                          blurRadius: 2,
                          color: ColorResources.BLACK.withOpacity(.2),
                          offset: const Offset(0, 2)),
                    ]
                  : [],
            ),
            child: FormField(
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fillColor ?? Colors.transparent,
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        borderSide: (isBorder == true)
                            ? const BorderSide(color: ColorResources.PRIMARY)
                            : BorderSide.none),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        borderSide: (isBorder == true)
                            ? const BorderSide(color: ColorResources.PRIMARY)
                            : BorderSide.none),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.025),
                        vertical: DeviceUtils.getScaledSize(context, 0.038)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        borderSide: (isBorder == true)
                            ? const BorderSide(color: ColorResources.PRIMARY)
                            : BorderSide.none),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                        hint: hint.toString().isNotEmpty
                            ? Text(hint.toString())
                            : null,
                        isDense: true,
                        isExpanded: true,
                        value: value,
                        onChanged: onChanged,
                        items: data
                            .map((e) => DropdownMenuItem<T>(
                                value: e,
                                child: Text(
                                  e.toString(),
                                  style: TextStyle(
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    color: colorText ?? ColorResources.BLACK,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )))
                            .toList()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
