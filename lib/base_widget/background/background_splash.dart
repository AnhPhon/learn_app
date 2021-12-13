import 'package:flutter/material.dart';
import 'package:template/helper/izi_device.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class BackgroundSplash extends StatelessWidget {
  const BackgroundSplash({
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
              child: Container(
                height: IZIDimensions.iziSize.height,
                width: IZIDimensions.iziSize.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorResources.CIRCLE_COLOR_BG3,
                    ColorResources.CIRCLE_COLOR_BG2,
                    ColorResources.CIRCLE_COLOR_BG3,
                  ],
                  stops: [
                    0.3,
                    0.6,
                    1,
                  ],
                )),
              ),
            ),
            Positioned(
              top: -70,
              left: -25,
              child: Container(
                height: IZIDimensions.iziSize.width * 0.5,
                width: IZIDimensions.iziSize.width * 0.4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorResources.CIRCLE_COLOR_BG,
                      ColorResources.CIRCLE_COLOR_BG2,
                      ColorResources.CIRCLE_COLOR_BG3,
                      ColorResources.CIRCLE_COLOR_BG4,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -90,
              right: -35,
              child: Container(
                height: IZIDimensions.iziSize.height * 0.5,
                width: IZIDimensions.iziSize.width * 0.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorResources.CIRCLE_COLOR_BG,
                      ColorResources.CIRCLE_COLOR_BG2,
                      ColorResources.CIRCLE_COLOR_BG3,
                      ColorResources.CIRCLE_COLOR_BG4,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
