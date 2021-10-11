import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class LabelTextarea extends StatelessWidget {
  final String label;
  final String labelText;
  final bool isRequire;
  final TextEditingController controller;

  const LabelTextarea({
    required this.label,
    required this.labelText,
    required this.controller,
    required this.isRequire,
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
          height: DeviceUtils.getScaledHeight(
            context,
            Dimensions.SCALE_DEFAULT,
          ),
        ),
        const TextField(
          minLines: 3,
          maxLines: 7,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        )
      ],
    );
  }
}
