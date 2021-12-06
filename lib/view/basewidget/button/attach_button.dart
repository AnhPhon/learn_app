import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class AttachButton extends StatelessWidget {
  const AttachButton({
    Key? key,
    required this.title,
    required this.color,
    required this.onPressed,
    this.vertical = 0.0,
    this.horizontal = 0.0,
  }) : super(key: key);
  final String title;
  final Color color;
  final Function onPressed;
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
        onPressed: () => onPressed(),
        minWidth: DeviceUtils.getScaledSize(context, 1),
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL)),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
            color: ColorResources.BLACK,
            fontSize: Dimensions.FONT_SIZE_LARGE
          ),),
        ),
      ),
    );
  }
}
