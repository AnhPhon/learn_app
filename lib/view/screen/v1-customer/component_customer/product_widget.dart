import 'package:flutter/material.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

class ProductWidget extends StatelessWidget {
  final String name;
  final String price;
  final String imgUrl;
  const ProductWidget(
      {Key? key, required this.imgUrl, required this.name, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
          ),
          child: FadeInImage.assetNetwork(
            placeholder: Images.logo,
            image: imgUrl,
            fit: BoxFit.fill,
            height: DeviceUtils.getScaledHeight(context, .197),
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
        ),
        SizedBox(
          height: DeviceUtils.getScaledSize(context, .098),
          child: Text(
            name,
            maxLines: 2,
            style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(price),
      ],
    );
  }
}
