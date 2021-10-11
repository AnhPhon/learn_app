import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/image_url.dart';

class ImageCardInWorkDonePage extends StatelessWidget {
  final String title;

  final bool isRequired;
  const ImageCardInWorkDonePage(
      {required this.title, required this.isRequired});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // địa điểm nhận
        Container(
          alignment: Alignment.centerLeft,
          height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
          child: Row(
            children: [
              Text(
                title,
                style: Dimensions.fontSizeStyle16w600(),
              ),
              if (isRequired == true)
                const Text(
                  "*",
                  style: TextStyle(
                    color: ColorResources.RED,
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ],
          ),
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, Dimensions.SCALE_SMALL),
        ),
        // content
        Container(
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
            itemCount: 3,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
                  child: FadeInImage.assetNetwork(
                    image: ImageURL.location_example,
                    height: 90,
                    fit: BoxFit.fill,
                    placeholder: '',
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
