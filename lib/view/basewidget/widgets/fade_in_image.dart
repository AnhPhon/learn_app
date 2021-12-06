import 'package:flutter/material.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/utils/images_path.dart';

class FadeInImageCustom extends StatelessWidget {
  final String urlImage;
  final double height;
  final double width;
  final BoxFit? fit;
  const FadeInImageCustom({
    Key? key,
    required this.urlImage,
    required this.height,
    required this.width,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: Images.placeholder,
      image: urlImage,
      height: DeviceUtils.getScaledSize(context, height),
      width: DeviceUtils.getScaledSize(context, width),
      fit: fit ?? BoxFit.cover,
      imageErrorBuilder: (c, o, s) => Image.asset(
        Images.placeholder,
        height: DeviceUtils.getScaledSize(context, height),
        width: DeviceUtils.getScaledSize(context, width),
        fit: fit ?? BoxFit.fill,
      ),
    );
  }
}
