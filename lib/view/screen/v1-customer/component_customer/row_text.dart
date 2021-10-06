import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class RowText extends StatelessWidget {
  final String text1;
  final String text2;
  final bool? colorRed;
  const RowText(
      {Key? key, required this.text1, required this.text2, this.colorRed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 0.025),
          vertical: DeviceUtils.getScaledHeight(context, 0.01)),
      child: DefaultTextStyle(
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: ColorResources.BLACK),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text1, textAlign: TextAlign.center),
            SizedBox(height: DeviceUtils.getScaledWidth(context, 0.025)),
            Text(text2,
                textAlign: TextAlign.center,
                style: colorRed == true
                    ? const TextStyle(color: ColorResources.RED)
                    : null),
          ],
        ),
      ),
    );
  }
}
