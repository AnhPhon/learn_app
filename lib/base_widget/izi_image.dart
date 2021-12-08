import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:template/utils/images_path.dart';

enum IZIImageType { NETWORK, ASSET }

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
    required this.type,
    this.fit,
    this.height,
    this.width,
  }) : super(key: key);
  final String urlImage;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final IZIImageType type;

  @override
  Widget build(BuildContext context) {
    if (type == IZIImageType.NETWORK) {
      return CachedNetworkImage(
        imageUrl: urlImage,
        imageBuilder: (context, imageProvider) => Container(
          height: width ?? 0,
          width: height ?? 0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit ?? BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
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
