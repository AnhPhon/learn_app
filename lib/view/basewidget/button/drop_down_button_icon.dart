import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class DropDownButtonIcon<T> extends StatelessWidget {
  const DropDownButtonIcon({
    Key? key,
    this.hint,
    required this.width,
    required this.onChanged,
    this.label,
    required this.data,
    required this.icon,
    this.padding,
    this.dropIcon,
    this.fillColor,
    this.filled,
    this.style,
    this.value,
  }) : super(key: key);
  final String? hint;
  final double width;
  final Function(T? value) onChanged;
  final String? label;
  final List<T> data;
  final Widget icon;
  final EdgeInsets? padding;
  final Widget? dropIcon;
  final Color? fillColor;
  final bool? filled;
  final TextStyle? style;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        child: FormField(
          builder: (field) {
            return InputDecorator(
                decoration: InputDecoration(
                  prefixIcon: icon,
                  fillColor: fillColor ?? Colors.transparent,
                  filled: filled ?? false,
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
                      vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    hint: Text(hint!,
                        style: style ??
                            const TextStyle(color: ColorResources.LIGHT_BLACK)),
                    value: value,
                    icon: dropIcon ?? const Icon(Icons.arrow_drop_down),
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
                ));
          },
        ),
      ),
    );
  }
}
