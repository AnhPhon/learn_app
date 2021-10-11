import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class DropDownButton1<T> extends StatelessWidget {
  const DropDownButton1({
    required this.hint,
    required this.onChanged,
    required this.data,
    this.value,
    this.isColorFieldWhite = false,
    this.obligatory = false,
    this.label,
    this.labelBold = false,
    required this.width,
  });

  final String hint;
  final Function(T? i) onChanged;
  final List<T> data;
  final T? value;
  final bool? isColorFieldWhite;
  final bool? obligatory, labelBold;
  final String? label;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
          if (label != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
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
            ),
          Container(
            width: DeviceUtils.getScaledWidth(context, width),
            margin: EdgeInsets.symmetric(
                vertical: DeviceUtils.getScaledSize(context, .025)),
            child: FormField(
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: (isColorFieldWhite == true)
                        ? ColorResources.WHITE
                        : Colors.transparent,
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      borderSide: const BorderSide(
                        color: ColorResources.PRIMARY,
                        width: 2,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      borderSide: const BorderSide(
                        color: ColorResources.PRIMARY,
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.025),
                        vertical: DeviceUtils.getScaledSize(context, 0.038)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      borderSide: const BorderSide(
                        color: ColorResources.PRIMARY,
                        width: 2,
                      ),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                        hint: Text(hint),
                        isDense: true,
                        isExpanded: true,
                        // value: getCutContent(value),
                        // onChanged: onChanged,
                        onChanged: onChanged,
                        items: data
                            .map((e) => DropdownMenuItem<T>(
                                value: e,
                                child: Text(
                                  e.toString(),
                                  style: const TextStyle(
                                      fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                                      color: ColorResources.BLACK),
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
