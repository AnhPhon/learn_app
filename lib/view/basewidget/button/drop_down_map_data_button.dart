import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

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
  }) : super(key: key);

  final String? hint;
  final String? label;
  final double width;
  final Color? fillColor;
  final Color? colorText;
  final Function(T? value) onChanged;
  final Map<T, String> data;
  final T? value;
  final bool? labelBold, obligatory, isBorder, isShadow, isColorFieldWhite;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
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
          Container(
              width: DeviceUtils.getScaledWidth(context, width),
              margin: EdgeInsets.symmetric(
                vertical: DeviceUtils.getScaledSize(context, .025),
              ),
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
                              ? const BorderSide(
                                  color: ColorResources.PRIMARY,
                                  width: 2,
                                )
                              : BorderSide.none),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                          borderSide: (isBorder == true)
                              ? const BorderSide(
                                  color: ColorResources.PRIMARY,
                                  width: 2,
                                )
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
                              ? const BorderSide(
                                  color: ColorResources.PRIMARY,
                                  width: 2,
                                )
                              : BorderSide.none),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<T>(
                          hint: Text(hint!),
                          style: TextStyle(color: colorText),
                          value: value,
                          isDense: true,
                          onChanged: onChanged,
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
