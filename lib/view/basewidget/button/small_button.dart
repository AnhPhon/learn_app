import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    Key? key,
    required this.title,
    required this.color,
    required this.onPressed,
    this.height,
  }) : super(key: key);
  final String title;
  final Color color;
  final Function onPressed;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        right: Dimensions.PADDING_SIZE_EXTRA_SMALL
      ),
      child: MaterialButton(
        height: height ?? 40,
        onPressed: () => onPressed(),
        minWidth: DeviceUtils.getScaledSize(context, 0.4),
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL)),
        child: Text(
          title,
          style: const TextStyle(
              color: ColorResources.WHITE,
              fontSize: Dimensions.FONT_SIZE_LARGE),
        ),
      ),
    );
  }
}
