import 'dart:io';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';

class ImageListHorizontalAdd<T> extends StatelessWidget {
  final VoidCallback pickImage;
  final List<T> imageFileList;
  final String? label;
  final bool? labelBold, obligatory, isAddImage;
  final EdgeInsetsGeometry? padding;
  final double? height;
  const ImageListHorizontalAdd({
    Key? key,
    required this.pickImage,
    required this.imageFileList,
    this.label,
    this.labelBold = false,
    this.obligatory = false,
    this.padding,
    this.height,
    this.isAddImage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
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
              height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
            ),
          Container(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              border: Border.all(color: ColorResources.PRIMARY),
              borderRadius:
                  BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
            ),
            height: DeviceUtils.getScaledHeight(context, height ?? .158),
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
                              child: (T == File)
                                  ? Image.file(
                                      imageFileList[index] as File,
                                      fit: BoxFit.fill,
                                      height: double.infinity,
                                      width: DeviceUtils.getScaledWidth(
                                        context,
                                        .254,
                                      ),
                                    )
                                  : FadeInImageCustom(
                                      urlImage: imageFileList[index].toString(),
                                      height: .122,
                                      width: .254,
                                    ),
                            ),
                          );
                        }),
                    if (isAddImage == true)
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          alignment: Alignment.center,
                          width: DeviceUtils.getScaledWidth(context, .254),
                          padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),
                          decoration: BoxDecoration(
                              color:
                                  ColorResources.LIGHT_SKY_BLUE.withOpacity(.5),
                              borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_DEFAULT)),
                          child: const Icon(Icons.add),
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
