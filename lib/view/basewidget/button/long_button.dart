




import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class LongButton extends StatelessWidget {
  const LongButton({
    Key? key,
    required this.title,
    required this.color,
    required this.onPressed,
    this.vertical = 0.0,
    this.horizontal = 0.0,
  }) : super(key: key);
  final String title;
  final Color color;
  final  Function onPressed;
  final double? vertical;
  final double? horizontal;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical!,
        horizontal: horizontal!,
      ),
      child: MaterialButton(
        onPressed: ()=> onPressed(),
        minWidth: DeviceUtils.getScaledSize(context,1),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(title,style: const TextStyle(
            color: ColorResources.WHITE,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE
          ),),
        ),
      ),
    );
  }
}
