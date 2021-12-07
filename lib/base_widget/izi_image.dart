import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:template/utils/images_path.dart';

// param
// url image (asset,network)
// 2. Fitbox = cover
// 3. width height
// Nếu không có url => not image (Placehoder image)
// Nếu network ImageCaccheBuilder
// Loading khi đang load ảnh
class IZIImage extends StatelessWidget {
  const IZIImage({
    Key? key,
    required this.urlImage,
    required this.isTypeUrlImage,
    this.fit,
    this.height,
    this.width,
  }) : super(key: key);
  final String urlImage;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool isTypeUrlImage;

  @override
  Widget build(BuildContext context) {
    if (isTypeUrlImage == true) {
      return CachedNetworkImage(
        imageUrl: urlImage,
        imageBuilder: (context, imageProvider) => Container(
          height: width ?? 0,
          width: height ?? 0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Colors.red,
                BlendMode.colorBurn,
              ),
            ),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Image.asset(
          ImagesPath.placeholder,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Image(
        image: AssetImage(urlImage),
        fit: fit ?? BoxFit.cover,
        height: height ?? 0,
        width: width ?? 0,
      );
    }
  }
}
