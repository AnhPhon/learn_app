

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
  final  Function onPressed;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: MaterialButton(
        height: height ?? 45,
        onPressed: ()=> onPressed(),
        minWidth: DeviceUtils.getScaledSize(context,0.4),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        child: Text(title,style: const TextStyle(
          color: ColorResources.WHITE,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
        ),),
      ),
    );
  }
}
