import 'package:flutter/material.dart';
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
            height: DeviceUtils.getScaledHeight(context, 0.197),
          ),
        ),
        SizedBox(height: DeviceUtils.getScaledHeight(context, 0.006)),
        SizedBox(
          height: DeviceUtils.getScaledSize(context, 0.098),
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
