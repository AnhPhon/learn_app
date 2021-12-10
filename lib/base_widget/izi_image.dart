import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';

import 'package:template/utils/images_path.dart';

// param
// url image (asset,network)
// 2. Fitbox = cover
// 3. width height
// Nếu không có url => not image (Placehoder image)
// Nếu network ImageCaccheBuilder
// Loading khi đang load ảnh
enum IZIImageType {
  SVG,
  IMAGE,
  NOTIMAGE,
}
enum IZIImageUrlType {
  NETWORK,
  ASSET,
  FILE,
  ICON,
}

class IZIImage extends StatelessWidget {
  IZIImage(
    String this.urlImage, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);
  String? urlImage;
  final double? width;
  final double? height;
  final BoxFit? fit;
  File? file;
  IconData? icon;
  Color? color;
  double? size;
  IZIImage.file(
    File? this.file, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  IZIImage.icon(
    IconData this.icon, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color = ColorResources.BLACK,
    this.size,
  }) : super(key: key);

  IZIImageType checkImageType(String url) {
    if (IZIValidate.nullOrEmpty(url) && IZIValidate.nullOrEmpty(file)) {
      return IZIImageType.NOTIMAGE;
    }
    if (url.endsWith(".svg")) {
      return IZIImageType.SVG;
    }
    return IZIImageType.IMAGE;
  }

  IZIImageUrlType checkImageUrlType(String url) {
    if (IZIValidate.nullOrEmpty(url)) {
      return IZIImageUrlType.FILE;
    }
    if (url.startsWith('http') || url.startsWith('https')) {
      return IZIImageUrlType.NETWORK;
    } else if (url.startsWith('assets/')) {
      return IZIImageUrlType.ASSET;
    }
    return IZIImageUrlType.FILE;
  }

  Widget imageTypeWidget(String urlImage, IZIImageType imageType, IZIImageUrlType imageUrlType) {
    print(imageUrlType);
    if (imageType == IZIImageType.IMAGE) {
      if (imageUrlType == IZIImageUrlType.NETWORK) {
        return Container(
          height: height,
          width: width,
          child: CachedNetworkImage(
            imageUrl: urlImage,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                ),
              ),
            ),
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.ASSET) {
        return Container(
          height: height,
          width: width,
          child: Image.asset(
            urlImage,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.FILE) {
        return Container(
          height: height,
          width: width,
          child: Image.file(
            file!,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
        );
      }
    }

    if (imageType == IZIImageType.SVG) {
      if (imageUrlType == IZIImageUrlType.NETWORK) {
        return Container(
          height: height,
          width: width,
          child: SvgPicture.network(
            urlImage,
            fit: fit!,
            placeholderBuilder: (BuildContext context) => const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.ASSET) {
        return Expanded(
          child: Container(
            height: height,
            width: width,
            child: SvgPicture.asset(
              urlImage,
              fit: fit!,
              placeholderBuilder: (BuildContext context) => const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        );
      } else if (imageUrlType == IZIImageUrlType.FILE) {
        return Expanded(
          child: Container(
            color: Colors.green,
            height: height,
            width: width,
            child: SvgPicture.file(
              file!,
              fit: fit!,
              placeholderBuilder: (BuildContext context) => const SizedBox(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        );
      }
    }

    if (imageType == IZIImageType.NOTIMAGE) {
      return Container(
        height: height ?? IZIDimensions.ONE_UNIT_SIZE * 50,
        width: width ?? IZIDimensions.ONE_UNIT_SIZE * 50,
        child: Image.asset(
          ImagesPath.placeholder,
          fit: fit,
        ),
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final imageType = checkImageType(urlImage.toString());
    final imageUrlType = checkImageUrlType(urlImage.toString());
    print(imageType);
    print(imageUrlType);
    return Container(
      width: width,
      height: height,
      child: imageTypeWidget(urlImage.toString(), imageType, imageUrlType),
    );
  }
}
