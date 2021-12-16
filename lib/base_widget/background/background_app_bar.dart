import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';

class BackgroundAppBar extends StatelessWidget {
  const BackgroundAppBar({
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
            Container(
              height: MediaQuery.of(context).padding.top + kToolbarHeight,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: ColorResources.CIRCLE_COLOR_BG3,
                  gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                    ColorResources.CIRCLE_COLOR_BG3,
                    ColorResources.CIRCLE_COLOR_BG2,
                  ], stops: [
                    0.7,
                    1
                  ])),
            ),
            Positioned(
              top: -90,
              left: -70,
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
              top: -100,
              right: -70,
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
