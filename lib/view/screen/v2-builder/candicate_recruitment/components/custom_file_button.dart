

import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/helper/dimensions.dart';

class CustomFileButton extends StatelessWidget {
  
  final String title;
  final double? verticalPadding;
  final Function onTap;
  const CustomFileButton({
    Key? key,
    required this.title,
    this.verticalPadding,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=> onTap(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            vertical: verticalPadding ?? 0
          ),
        child: Container(
          alignment: Alignment.center,
          height: Dimensions.SIZE_OVER_LARGE,
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            border: Border.all(color: ColorResources.PRIMARYCOLOR),
            borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
            boxShadow: boxShadow
          ),
          child: Text(title, style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: ColorResources.BLACK
          )),
        ),
      ),
    );
  }
}
