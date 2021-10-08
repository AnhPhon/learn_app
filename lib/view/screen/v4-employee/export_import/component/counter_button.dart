import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    Key? key,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final Function() press;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, 0.07),
      height: DeviceUtils.getScaledWidth(context, 0.07),
      decoration: BoxDecoration(
        color: ColorResources.PRIMARYCOLOR,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: Dimensions.BLUR_RADIUS_LIGHT,
            color: ColorResources.BLACK.withAlpha(20),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL - 15,
            left: Dimensions.PADDING_SIZE_EXTRA_SMALL - 15,
            child: IconButton(
              onPressed: press,
              icon: icon,
            ),
          )
        ],
      ),
    );
  }
}
