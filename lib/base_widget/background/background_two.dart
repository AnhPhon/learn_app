import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/helper/izi_device.dart';
import 'package:template/utils/color_resources.dart';

class BackgroundTwo extends StatelessWidget {
  const BackgroundTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/splash.png",
                fit: BoxFit.contain,
                width: IZIDevice.getScaledWidth(context, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
