import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class LabelInput extends StatelessWidget {
  final String label;
  final String labelText;
  final bool isRequire;
  final TextEditingController controller;
  bool? isNumber;

  LabelInput({
    required this.label,
    required this.labelText,
    required this.controller,
    required this.isRequire,
    this.isNumber,
  });

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
          color: ColorResources.WHITE,
          child: TextField(
            keyboardType:
                (isNumber == true) ? TextInputType.number : TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: controller,
          ),
        )
      ],
    );
  }
}
