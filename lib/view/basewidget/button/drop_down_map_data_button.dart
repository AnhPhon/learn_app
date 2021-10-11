import 'package:flutter/material.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class DropDownMapButton<T> extends StatelessWidget {
  const DropDownMapButton({
    Key? key,
    this.hint = "",
    required this.onChanged,
    required this.data,
    required this.width,
    required this.value,
    this.fillColor,
    this.colorText,
  }) : super(key: key);

  final String? hint;
  final double width;
  final Color? fillColor;
  final Color? colorText;
  final Function(T? value) onChanged;
  final Map<T, String> data;
  final T value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        // padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        width: DeviceUtils.getScaledWidth(context, width),
        child: FormField(
          builder: (field) {
            return InputDecorator(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: fillColor ?? Colors.transparent,
                  isDense: true,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_SMALL - 3,
                      horizontal: Dimensions.PADDING_SIZE_SMALL),
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
        ));
  }
}
