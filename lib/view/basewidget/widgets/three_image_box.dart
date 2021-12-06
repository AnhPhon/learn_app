import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';

class ThreeImageBox extends StatelessWidget {
  final bool allowPicker;
  final List<String> images;

  const ThreeImageBox({
    required this.images,
    required this.allowPicker
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 115,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorResources.THEME_DEFAULT),
        borderRadius: const BorderRadius.all(
            Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
      ),
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 90,
          crossAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
              child: FadeInImage.assetNetwork(
                placeholder: Images.V4NewsExample,
                image: images[index],
                height: 90,
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
