import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

// ignore: must_be_immutable
class DropDownButtonHorizontal<T> extends StatelessWidget {
  DropDownButtonHorizontal({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.data,
    required this.value,
    required this.width,
  }) : super(key: key);

  final String label;
  final Function(T? value) onChanged;
  final List<T> data;
  T value;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, 1),
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_LARGE,
            ),
            alignment: Alignment.centerLeft,
            child: Wrap(
              children: [
                Text(
                  label,
                  style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.BLACK.withOpacity(0.7)),
                ),
                const Text(
                  '*',
                  style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                )
              ],
            ),
          ),
          const SizedBox(
            width: Dimensions.PADDING_SIZE_SMALL,
          ),
          // ignore: sized_box_for_whitespace
          Container(
            margin: const EdgeInsets.only(
              top: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
            ),
            width: width,
            child: FormField(
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    //isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: ColorResources.PRIMARYCOLOR),
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: ColorResources.PRIMARYCOLOR),
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: ColorResources.PRIMARYCOLOR),
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_SMALL - 3,
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<T>(
                      value: value,
                      style: const TextStyle(
                          fontSize: Dimensions.PADDING_SIZE_DEFAULT,
                          color: ColorResources.BLACK),
                      isDense: true,
                      isExpanded: true,
                      onChanged: onChanged,
                      items: data
                          .map((e) => DropdownMenuItem<T>(
                              value: e, child: Text(e.toString())))
                          .toList(),
                    ),
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
