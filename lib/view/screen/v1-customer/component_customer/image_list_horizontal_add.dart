import 'dart:io';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

class ImageListHorizontalAdd<T> extends StatelessWidget {
  final VoidCallback pickImage;
  final List<T> imageFileList;
  final String? label;
  final bool? labelBold, obligatory;
  const ImageListHorizontalAdd({
    Key? key,
    required this.pickImage,
    required this.imageFileList,
    this.label,
    this.labelBold = false,
    this.obligatory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
          if (label != null)
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                children: [
                  Text(
                    label.toString(),
                    style: labelBold == true
                        ? Dimensions.fontSizeStyle16w600().copyWith(
                            color: ColorResources.BLACK,
                          )
                        : Dimensions.fontSizeStyle16().copyWith(
                            color: ColorResources.BLACK,
                          ),
                  ),
                  if (obligatory == true)
                    const Text(
                      "*",
                      style: TextStyle(
                        color: ColorResources.RED,
                      ),
                    ),
                ],
              ),
            ),
          if (label != null)
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_SMALL,
            ),
          Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              border: Border.all(color: ColorResources.PRIMARY),
              borderRadius:
                  BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
            ),
            height: DeviceUtils.getScaledHeight(context, .158),
            child: Align(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: imageFileList.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: Dimensions.PADDING_SIZE_EXTRA_SMALL + 3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                              child: Image.file(
                                imageFileList[index] as File,
                                fit: BoxFit.fill,
                                height:
                                    DeviceUtils.getScaledHeight(context, .122),
                                width:
                                    DeviceUtils.getScaledWidth(context, .254),
                              ),
                            ),
                          );
                        }),
                    GestureDetector(
                      onTap: pickImage,
                      child: Image.asset(
                        Images.add_image,
                        height: DeviceUtils.getScaledHeight(context, .122),
                        width: DeviceUtils.getScaledWidth(context, .254),
                        fit: BoxFit.fill,
                        color: ColorResources.PRIMARY,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
