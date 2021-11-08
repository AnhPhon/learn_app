import 'dart:io';

import 'package:flutter/material.dart';

import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/image_card.dart';

class BoxImage extends StatelessWidget {
  const BoxImage({
    Key? key,
    this.isAddImage = false,
    this.onPress,
    this.images,
    this.imagesUrl,
    this.onDelete,
  }) : super(key: key);
  final bool? isAddImage;
  final Function()? onPress;
  final List<String>? images;
  // final List<String>? imagesUrl;
  final Function(String file, List<String> files)? onDelete;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:
              const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          width: DeviceUtils.getScaledWidth(context, 1),
          height: 120,
          decoration: BoxDecoration(
              color: ColorResources.GREY.withOpacity(0.1),
              borderRadius:
                  BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              border: Border.all(color: ColorResources.PRIMARYCOLOR)),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imagesUrl != null
                ? imagesUrl!.length
                : isAddImage!
                    ? images!.length + 1
                    : images!.length,
            itemBuilder: (context, index) {
              if (isAddImage!) {
                if (index == images!.length) {
                  // == images.length
                  return GestureDetector(
                    onTap: onPress,
                    child: Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Container(
                          decoration: BoxDecoration(
                              color:
                                  ColorResources.PRIMARYCOLOR.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_EXTRA_SMALL)),
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                            child: IconButton(
                                onPressed: onPress,
                                icon: const Icon(
                                  Icons.add,
                                  size: Dimensions.ICON_SIZE_LARGE,
                                  color: ColorResources.BLACK,
                                )),
                          ),
                        )),
                  );
                }
                return ImageCard(
                  image: images![index],
                  isAddImage: isAddImage!,
                  onDelete: () => onDelete!(images![index], images!),
                );
              } else {
                return imagesUrl != null
                    ? imagesUrl![index].isNotEmpty &&
                            !imagesUrl![index].contains('null')
                        ? ImageCard(
                            image: imagesUrl![index], isAddImage: isAddImage!)
                        : const SizedBox()
                    : ImageCard(
                        image: images![index],
                        isAddImage: isAddImage!,
                        onDelete: () => onDelete!(images![index], images!),
                      );
              }
            },
          ),
        ),
      ],
    );
  }
}
