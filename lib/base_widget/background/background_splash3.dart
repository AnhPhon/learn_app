import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/helper/izi_device.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

class BackgroundSplash3 extends StatelessWidget {
  const BackgroundSplash3({
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
                ImagesPath.splash3,
                fit: BoxFit.contain,
                width: IZIDimensions.iziSize.width ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}