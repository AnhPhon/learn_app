import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';

class IZIDialog {
  static Future<void> showDialog({required String lable,String? confirmLabel, String? cancelLabel  ,String? description, Function? onConfirm, Function? onCancel}) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: lable,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
            child: IZIText(
              textAlign: TextAlign.center,
              text: description ?? '',
              maxLine: 7,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!IZIValidate.nullOrEmpty(onCancel))
                IZIButton(
                  type: IZIButtonType.OUTLINE,
                  color: ColorResources.CIRCLE_COLOR_BG3,
                  label: cancelLabel ?? "Không",
                  borderRadius: IZIDimensions.BLUR_RADIUS_2X,
                  width: IZIDimensions.iziSize.width * 0.33,
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.ONE_UNIT_SIZE * 50,
                    vertical: IZIDimensions.ONE_UNIT_SIZE * 15,
                  ),
                  onTap: () {
                    onCancel!();
                  },
                ),
              if (!IZIValidate.nullOrEmpty(onConfirm))
                IZIButton(
                  colorBG: ColorResources.CIRCLE_COLOR_BG3,
                  color: ColorResources.WHITE,
                  borderRadius: IZIDimensions.BLUR_RADIUS_2X,
                  width: IZIDimensions.iziSize.width * 0.33,
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.ONE_UNIT_SIZE * 50,
                    vertical: IZIDimensions.ONE_UNIT_SIZE * 20,
                  ),
                  label: confirmLabel ?? "Đồng ý",
                  onTap: () {
                    onConfirm!();
                  },
                ),
            ],
          )
        ],
      ),
    );
  }
}
