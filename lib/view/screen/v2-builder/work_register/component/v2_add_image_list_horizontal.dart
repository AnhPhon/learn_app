import 'dart:io';
import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';

class V2ImageListHorizontalAdd<T> extends StatelessWidget {
  final VoidCallback pickImage;
  final List<T>? imageFileList;
  final String? label;
  final Function(T file, List<T> files)? onDelete;
  final bool? labelBold, obligatory;
  final EdgeInsetsGeometry? padding;
  const V2ImageListHorizontalAdd({
    Key? key,
    required this.pickImage,
    required this.imageFileList,
    this.label,
    this.onDelete,
    this.labelBold = false,
    this.obligatory = false,
    this.padding,
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
            height: DeviceUtils.getScaledHeight(context, .158),
            child: Align(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: imageFileList!.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: Dimensions.PADDING_SIZE_EXTRA_SMALL + 3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                              child: (T == File)
                                  ? Stack(
                                      children: [
                                        Image.file(
                                          imageFileList![index] as File,
                                          fit: BoxFit.fill,
                                          height: DeviceUtils.getScaledHeight(
                                            context,
                                            .122,
                                          ),
                                          width: DeviceUtils.getScaledWidth(
                                            context,
                                            .254,
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: GestureDetector(
                                              onTap: () => onDelete!(
                                                  imageFileList![index],
                                                  imageFileList!),
                                              child: const Icon(
                                                Icons.cancel_outlined,
                                                size: Dimensions
                                                    .ICON_SIZE_DEFAULT,
                                                color: ColorResources.RED,
                                              )),
                                        ),
                                      ],
                                    )
                                  : Stack(
                                      children: [
                                        FadeInImageCustom(
                                          urlImage:
                                              imageFileList![index].toString(),
                                          height: .255,
                                          width: .254,
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: GestureDetector(
                                              onTap: () => onDelete!(
                                                  imageFileList![index],
                                                  imageFileList!),
                                              child: const Icon(
                                                Icons.cancel_outlined,
                                                size: Dimensions
                                                    .ICON_SIZE_DEFAULT,
                                                color: ColorResources.RED,
                                              )),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        }),
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
