import 'dart:io';

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    Key? key,
    required this.image,
    required this.isAddImage,
    this.onDelete,
    //this.imageUrl
  }) : super(key: key);
  final dynamic image;
  // final String? imageUrl;
  final bool isAddImage;
  final Function? onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Container(
        decoration: BoxDecoration(
          color: ColorResources.GREY,
          borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL)
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
                child: image is File ? Image.file(
                  image as File, fit: BoxFit.cover,
                ) : Image.network(image as String, fit: BoxFit.cover)
              ),
            ),
            if(isAddImage)
            GestureDetector(
              onTap: ()=> onDelete!(),
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
