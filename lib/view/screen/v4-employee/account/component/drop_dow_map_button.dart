import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';

class V4DropDownMapButton<T> extends StatelessWidget {
  const V4DropDownMapButton({
    Key? key,
    this.hint = "",
    required this.onChanged,
    required this.data,
    required this.width,
    required this.value,
    this.fillColor,
    this.colorText,
    this.label,
    required this.obligatory,
  }) : super(key: key);

  final String? hint;
  final double width;
  final Color? fillColor;
  final Color? colorText;
  final Function(T? value) onChanged;
  final Map<T, String> data;
  final T? value;
  final String? label;
  final bool obligatory;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
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
                  Text(label.toString(),
                      style: Dimensions.fontSizeStyle16w600().copyWith(
                        color: ColorResources.BLACK,
                      )),
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
          const SizedBox(
            height: Dimensions.PADDING_SIZE_SMALL,
          ),
          Container(
              height: DeviceUtils.getScaledHeight(context, 0.071),
              width: DeviceUtils.getScaledWidth(context, width),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    color: ColorResources.BLACK.withOpacity(.2),
                    offset: const Offset(0, 2)),
              ]),
              child: FormField(
                builder: (field) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: fillColor ?? Colors.transparent,
                        isDense: true,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                            borderSide:
                                const BorderSide(color: Colors.transparent)),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: Dimensions.PADDING_SIZE_DEFAULT + 3,
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
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
                                  child: Text(item.value.toString())))
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
