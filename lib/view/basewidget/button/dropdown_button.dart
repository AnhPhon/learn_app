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
    this.isBorder = true,
    this.isShadow = false,
  });

  final String hint;
  final Function(T? i) onChanged;
  final List<T> data;
  final T? value;
  final bool? isColorFieldWhite;
  final bool? obligatory, labelBold, isBorder, isShadow;
  final String? label;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        Dimensions.PADDING_SIZE_SMALL,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            margin: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
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
                    fillColor: (isColorFieldWhite == true)
                        ? ColorResources.WHITE
                        : ColorResources.NOT_ALLOW_EDIT,
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
                        hint: Text(hint),
                        isDense: true,
                        isExpanded: true,
                        value: value,
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
