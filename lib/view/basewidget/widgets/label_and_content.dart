import 'package:flutter/cupertino.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';

// ignore: must_be_immutable
class LabelContent extends StatelessWidget {
  final String title;
  final Widget content;
  final bool isRequired;
  double? height;
  LabelContent({
    required this.title,
    required this.content,
    required this.isRequired,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // địa điểm nhận
        Container(
          alignment: Alignment.centerLeft,
          height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isRequired == true)
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
        ),
        SizedBox(
          height: height ??
              DeviceUtils.getScaledHeight(context, Dimensions.SCALE_SMALL),
        ),
        // content
        content,
      ],
    );
  }
}
