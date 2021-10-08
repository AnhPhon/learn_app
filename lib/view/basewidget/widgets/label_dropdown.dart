import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class LabelDropdown extends StatelessWidget {
  String label;
  String labelText;
  bool isRequire;
  String currentSelectvalue;
  List<String> currencies;
  TextEditingController controller;

  LabelDropdown({
    required this.label,
    required this.labelText,
    required this.controller,
    required this.isRequire,
    required this.currentSelectvalue,
    required this.currencies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(label, style: Dimensions.textTitleStyleCard()),
            if (isRequire == true)
              Text("*", style: Dimensions.textTitleStyleCard())
          ],
        ),
        SizedBox(height: DeviceUtils.getScaledHeight(context, .02)),
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
                  onChanged: (value) {},
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
