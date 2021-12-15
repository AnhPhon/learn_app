import 'package:flutter/material.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/images_path.dart';

class backgroundSplash2 extends StatelessWidget {
  const backgroundSplash2({
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
                ImagesPath.splash2,
                fit: BoxFit.contain,
                width: IZIDimensions.iziSize.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
