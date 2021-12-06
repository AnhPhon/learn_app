import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/basewidget/widgets/preview_image.dart';

class ImageListHorizontal extends StatelessWidget {
  final List imageList;
  final String? label;
  final bool? labelBold, obligatory;
  final EdgeInsetsGeometry? padding;
  const ImageListHorizontal({
    Key? key,
    required this.imageList,
    this.label,
    this.labelBold = false,
    this.obligatory = false,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
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
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: Dimensions.MARGIN_SIZE_SMALL,
            ),
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              border: Border.all(color: ColorResources.PRIMARY),
              borderRadius:
                  BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
            ),
            width: double.infinity,
            height: DeviceUtils.getScaledHeight(context, .158),
            child: imageList.isEmpty
                ? const Align(
                    child: Text("Trống"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: imageList.length,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(ReviewImagePage(
                            image: imageList[index].toString(),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: Dimensions.PADDING_SIZE_EXTRA_SMALL + 3),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                            child: FadeInImage.assetNetwork(
                              placeholder: Images.placeholder,
                              image: imageList[index].toString(),
                              height:
                                  DeviceUtils.getScaledHeight(context, .122),
                              width: DeviceUtils.getScaledWidth(context, .254),
                              fit: BoxFit.fill,
                              imageErrorBuilder: (c, o, s) => Image.asset(
                                Images.placeholder,
                                height:
                                    DeviceUtils.getScaledHeight(context, .122),
                                width:
                                    DeviceUtils.getScaledWidth(context, .254),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
