

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.image,
    required this.isAddImage,
  }) : super(key: key);
  final String image;
  final bool isAddImage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorResources.GREY,
          borderRadius: BorderRadius.circular(5)
        ),
        height: 120,
        width: 120,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                child: Image.asset(
                  image, fit: BoxFit.cover,
                )
              ),
            ),
            if(isAddImage)
            GestureDetector(
              onTap: (){
                print("Xoá ảnh");
              },
              child: const Icon(
                Icons.cancel_outlined, 
                color: ColorResources.RED,
              )
            )
          ],
        ),
      ),
    );
  }
}
