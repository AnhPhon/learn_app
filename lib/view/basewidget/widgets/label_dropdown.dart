import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';

import 'package:template/utils/dimensions.dart';

class LabelDropdown<T> extends StatelessWidget {
  final String label;
  final String labelText;
  final bool isRequire;
  final String currentSelectvalue;
  final List<List<String>> currencies;
  final TextEditingController controller;
  final Function(String?) onChanged;
  final EdgeInsetsGeometry? padding;

  const LabelDropdown(
      {required this.label,
      required this.labelText,
      required this.controller,
      required this.isRequire,
      required this.currentSelectvalue,
      required this.currencies,
      required this.onChanged,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isRequire == true)
              const Text(
                "*",
                style: TextStyle(
                  color: ColorResources.RED,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  fontWeight: FontWeight.bold,
                ),
              )
          ],
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
        ),
        Container(
          decoration: const BoxDecoration(
            color: ColorResources.WHITE,
          ),
          height: 55,
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  contentPadding: padding,
                  labelStyle: Dimensions.textNormalStyleCard(),
                  errorStyle: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                  hintText: labelText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ColorResources.THEME_DEFAULT,
                    ),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ColorResources.THEME_DEFAULT,
                    ),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: ColorResources.THEME_DEFAULT,
                    ),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                ),
                isEmpty: currentSelectvalue == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: currentSelectvalue,
                    isDense: true,
                    onChanged: onChanged,
                    items: currencies.map((List<String> value) {
                      return DropdownMenuItem<String>(
                        value: value[0],
                        child: Text(value[1], maxLines: 1, overflow: TextOverflow.ellipsis,),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
