import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class BtnCustomBorder extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  const BtnCustomBorder(
      {Key? key, required this.onTap, required this.text, required this.width})
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
          margin: const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_SMALL),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: ColorResources.PRIMARY, width: 2),
            borderRadius:
                BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
            color: ColorResources.WHITE,
          ),
          child: Text(
            text,
            style: const TextStyle(color: ColorResources.PRIMARY),
          ),
        ),
      ),
    );
  }
}
