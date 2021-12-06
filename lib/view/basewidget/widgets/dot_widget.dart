import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';

class DotWidget extends StatelessWidget {
  const DotWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        right: Dimensions.MARGIN_SIZE_SMALL,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: ColorResources.PRIMARYCOLOR,
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_LARGE)
      ),
    );
  }
}
