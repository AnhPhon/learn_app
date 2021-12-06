import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';

class DropDownMapButton<T> extends StatelessWidget {
  const DropDownMapButton({
    Key? key,
    this.hint = "",
    required this.onChanged,
    required this.data,
    required this.width,
    this.value,
    this.fillColor,
    this.colorText,
    this.label,
    this.labelBold = false,
    this.obligatory = false,
    this.isBorder = true,
    this.isShadow = false,
    this.isColorFieldWhite = false,
    this.padding,
    this.margin,
    this.height,
    this.contentPadding,
  }) : super(key: key);

  final String? hint;
  final String? label;
  final double width;
  final double? height;
  final Color? fillColor;
  final Color? colorText;
  final Function(T? value) onChanged;
  final Map<T, String> data;
  final T? value;
  final bool? labelBold, obligatory, isBorder, isShadow, isColorFieldWhite;
  final EdgeInsetsGeometry? padding, contentPadding;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            RichText(
              maxLines: 2,
              text: TextSpan(
                  text: label,
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: labelBold == true ? FontWeight.w600 : null,
                    color: ColorResources.BLACK,
                  ),
                  children: [
                    if (obligatory == true)
                      TextSpan(
                        text: '*',
                        style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          fontWeight:
                              labelBold == true ? FontWeight.w600 : null,
                          color: Colors.red,
                        ),
                      )
                    else
                      const TextSpan(),
                  ]),
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
                      contentPadding: contentPadding ??
                          EdgeInsets.symmetric(
                              horizontal:
                                  DeviceUtils.getScaledSize(context, 0.025),
                              vertical:
                                  DeviceUtils.getScaledSize(context, 0.03)),
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
                          hint: Text(hint!),
                          style: TextStyle(color: colorText),
                          value: value,
                          isDense: true,
                          isExpanded: true,
                          onChanged: (val) {
                            onChanged(val);
                            DeviceUtils.unFocus(context);
                          },
                          onTap: () {
                            DeviceUtils.unFocus(context);
                          },
                          items: data.entries
                              .map((item) => DropdownMenuItem<T>(
                                  value: item.key,
                                  child: Text(
                                    item.value.toString(),
                                    style: const TextStyle(
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                      color: ColorResources.BLACK,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )))
                              .toList()),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
