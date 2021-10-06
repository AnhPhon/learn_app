import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component_border.dart';

class V1CartController extends GetxController {
  String title = "Giỏ hàng";

  String imgProduct = "assets/images/news_template.png";

  int qualityProduct = 1;

  ///
  ///incre quality
  ///
  void increQuality() {
    qualityProduct += 1;
    update();
  }

  ///
  ///decre quality
  ///
  void decreQuality() {
    if (qualityProduct > 1) {
      qualityProduct -= 1;
    } else {
      return;
    }
    update();
  }

  ///
  ///delete product
  ///
  void deleteProduct(BuildContext context, double height, double width) {
    Get.dialog(Center(
      child: Container(
        height: DeviceUtils.getScaledHeight(context, 250 / height),
        margin: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 25 / width),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, 20 / width),
          vertical: DeviceUtils.getScaledHeight(context, 20 / height),
        ),
        decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(7)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Xác nhận",
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 20 / height),
            ),
            const Flexible(
              child: Text(
                "Bạn có muốn xoá sản phẩm này khỏi giỏ hàng của mình không?",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE),
              ),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 20 / height),
            ),
            Row(
              children: [
                BtnCustomBorder(
                  onTap: () {},
                  text: "Đồng ý",
                  width: DeviceUtils.getScaledWidth(context, 0.7) / 2,
                ),
                BtnCustom(
                  onTap: () => Get.back(),
                  color: ColorResources.PRIMARY,
                  text: "Huỷ",
                  width: DeviceUtils.getScaledWidth(context, 0.7) / 2,
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
