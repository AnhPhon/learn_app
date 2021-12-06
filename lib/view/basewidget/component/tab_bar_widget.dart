import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class TabBarWidget extends StatelessWidget {
  final VoidCallback onTap;
  final int index;
  final int currentIndex;
  final String title;

  const TabBarWidget({
    Key? key,
    required this.onTap,
    required this.index,
    required this.currentIndex,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isRight;
    if (index == 0) {
      isRight = false;
    } else {
      isRight = true;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: DeviceUtils.getScaledWidth(context, .9).roundToDouble() / 2,
        decoration: BoxDecoration(
          borderRadius: isRight == false
              ? const BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                ),
          color: currentIndex == index ? ColorResources.PRIMARY : ColorResources.WHITE,
          border: currentIndex == index ? null : Border.all(color: ColorResources.PRIMARY),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: currentIndex == index ? ColorResources.WHITE : ColorResources.BLACK,
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
