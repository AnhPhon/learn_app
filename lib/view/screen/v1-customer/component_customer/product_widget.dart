import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class ProductWidget extends StatelessWidget {
  final String name;
  final String price;
  final String imgUrl;
  const ProductWidget(
      {Key? key, required this.imgUrl, required this.name, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(7),
          ),
          child: Image.asset(
            imgUrl,
            fit: BoxFit.fill,
            height: DeviceUtils.getScaledHeight(context, 150 / height),
          ),
        ),
        SizedBox(height: DeviceUtils.getScaledHeight(context, 5 / height)),
        SizedBox(
          height: DeviceUtils.getScaledSize(context, 75 / height),
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
