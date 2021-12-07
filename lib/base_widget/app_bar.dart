import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/helper/izi_device.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';

class IZIAppBar extends StatelessWidget {
  const IZIAppBar({
    Key? key,
    required this.title,
    this.iconBack,
    this.actions = const [],
    this.callbackSearch,
  }) : super(key: key);
  final String title;
  final Widget? iconBack;
  final List<Widget>? actions;
  final Function(String)? callbackSearch;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: kToolbarHeight,
              padding: const EdgeInsets.only(
                left: IZIDimensions.SPACE_SIZE_3X,
              ),
              alignment: Alignment.centerLeft,
              width: IZIDevice.getScaledWidth(context, 0.125),
              child: iconBack ??
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: ColorResources.BLACK,
                    ),
                  ),
            ),
            Container(
              height: kToolbarHeight,
              padding: const EdgeInsets.only(
                right: IZIDimensions.SPACE_SIZE_3X,
              ),
              alignment: Alignment.centerRight,
              width: IZIDevice.getScaledWidth(context, 0.125) * actions!.length,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions!,
              ),
            )
          ],
        ),
        Container(
          height: kToolbarHeight,
          alignment: Alignment.center,
          width: IZIDevice.getScaledWidth(context, 1),
          child: !IZIValidate.nullOrEmpty(callbackSearch)
              ? search(context)
              : Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: IZIDimensions.FONT_SIZE_H4,
                    color: ColorResources.WHITE,
                  ),
                ),
        ),
      ],
    );
  }

  Widget search(BuildContext context) {
    return IZIInput(
      width: IZIDevice.getScaledWidth(context, 1) - (IZIDevice.getScaledWidth(context, 0.125) * (actions!.length + 1) * 2),
      type: IZIInputType.TEXT,
      isRequired: false,
      allowEdit: true,
      disbleError: true,
      miniSize: true,
      prefixIcon: const Icon(Icons.search),
      holdplacer: "Tìm kiếm",
      onChanged: callbackSearch,
    );
  }
}
