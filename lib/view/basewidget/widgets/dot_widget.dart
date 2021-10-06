import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

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
        top: 3,
        right: Dimensions.MARGIN_SIZE_SMALL,
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: ColorResources.PRIMARYCOLOR,
        borderRadius: BorderRadius.circular(100)
      ),
    );
  }
}
