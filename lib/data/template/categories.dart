import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

class CategoryWidget extends GetView {
  const CategoryWidget({
    required this.text,
    required this.label,
    required this.content,
    required this.hasMore,
    this.icon,
    this.onPressed,
  });

  final String text;
  final String label;
  final Widget content;
  final bool hasMore;
  final Icon? icon;
  final VoidCallback? onPressed;

  static const  double labelFontSize = Dimensions.FONT_SIZE_EXTRA_LARGE;
  static const Color labelColor = ColorResources.BLACKGREY;
  static const double moreFontSize = Dimensions.FONT_SIZE_LARGE;
  static const Color moreColor = ColorResources.PRIMARY;

  static const double elementFontSize = Dimensions.FONT_SIZE_SMALL;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_LARGE,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          bottom: Dimensions.PADDING_SIZE_LARGE,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_SMALL),
                  width: DeviceUtils.getScaledSize(context, .6),
                  child: Text(
                    label,
                    style: const TextStyle(
                        fontSize: labelFontSize,
                        fontWeight: FontWeight.bold,
                        color: labelColor),
                  ),
                ),
                Container(
                  // width: width * .5,
                  child: (hasMore == true)
                      ? ElevatedButton(
                          style: ButtonStyle(
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                          ),
                          onPressed: onPressed,
                          child: Row(
                            children: [
                              Text(
                                text,
                                style: const TextStyle(
                                    fontSize: moreFontSize,
                                    color: ColorResources.PRIMARY),
                              ),
                              icon ??
                                  const Icon(Icons.arrow_forward_ios_outlined,
                                      color: ColorResources.PRIMARY,
                                      size: Dimensions.FONT_SIZE_EXTRA_LARGE)
                            ],
                          ),
                        )
                      : Container(),
                )
              ],
            ),
            Container(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: content),
          ],
        ));
  }
}
