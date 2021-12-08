import 'package:flutter/material.dart';

import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_device.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

class IZICard extends StatelessWidget {
  const IZICard({Key? key, this.isBorder = false, required this.urlImage, required this.title, this.subtitle, this.child, this.titleStyle, this.subTitleStyle}) : super(key: key);
  final bool? isBorder;
  final String urlImage;
  final String title;
  final String? subtitle;
  final Widget? child;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 190,
          width: 190,
          decoration: BoxDecoration(
            border: isBorder! ? Border.all(width: 5, color: ColorResources.CIRCLE_COLOR_BG4) : null,
            borderRadius: BorderRadius.circular(
              IZIDimensions.BLUR_RADIUS_3X,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              IZIDimensions.BLUR_RADIUS_3X,
            ),
            child: IZIImage(
              urlImage: urlImage,
              isTypeUrlImage: true,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: IZIDimensions.SPACE_SIZE_1X,
            horizontal: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IZIText(
                text: title,
                style: titleStyle,
                maxLine: 2,
              ),
              if (subtitle != null)
                IZIText(
                  text: subtitle!,
                  style: subTitleStyle,
                ),
              child ?? SizedBox.fromSize()
            ],
          ),
        ),
      ],
    );
  }
}
