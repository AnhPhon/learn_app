import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class LabelDropdown extends StatelessWidget {
  String label;
  String labelText;
  bool isRequire;
  String currentSelectvalue;
  List<String> currencies;
  TextEditingController controller;
  Function(String?) onChanged;

  LabelDropdown({
    required this.label,
    required this.labelText,
    required this.controller,
    required this.isRequire,
    required this.currentSelectvalue,
    required this.currencies,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(label, style: Dimensions.textTitleStyleCard()),
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
        SizedBox(
            height:
                DeviceUtils.getScaledHeight(context, Dimensions.SCALE_DEFAULT)),
        FormField<String>(
          builder: (FormFieldState<String> state) {
            return InputDecorator(
              decoration: InputDecoration(
                  labelStyle: Dimensions.textNormalStyleCard(),
                  errorStyle: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16.0,
                  ),
                  hintText: labelText,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              isEmpty: currentSelectvalue == '',
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currentSelectvalue,
                  isDense: true,
                  onChanged: onChanged,
                  items: currencies.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
