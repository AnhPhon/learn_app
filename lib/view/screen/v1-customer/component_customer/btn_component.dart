import 'package:flutter/material.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class BtnCustom extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String text;
  final double width;
  const BtnCustom(
      {Key? key,
      required this.onTap,
      required this.color,
      required this.text,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
        ),
        child: Container(
          height: DeviceUtils.getScaledHeight(context, .065),
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            color: color,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
