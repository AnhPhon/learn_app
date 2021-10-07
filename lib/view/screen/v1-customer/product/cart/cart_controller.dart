import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component_border.dart';

class V1CartController extends GetxController {
  String title = "Giỏ hàng";

  String imgProduct = Images.newsTemplate;

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
  ///go to shipping method
  ///
  void onSelectShippingMethod() {
    Get.toNamed(AppRoutes.V1_SHIPPING_METHOD);
  }

  ///
  ///go to shipping address
  ///
  void onSelectShippingAddress() {
    Get.toNamed(AppRoutes.V1_SHIPPING_ADDRESS);
  }

  ///
  ///go to payment account page
  ///
  void onCheckoutClick() {
    Get.toNamed(AppRoutes.V1_PAYMENT_ACCOUNT);
  }

  ///
  ///delete product
  ///
  void deleteProduct(BuildContext context) {
    Get.dialog(Center(
      child: Container(
        height: DeviceUtils.getScaledHeight(context, .329),
        margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_LARGE,
          vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
        ),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Xác nhận",
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_LARGE,
            ),
            const Flexible(
              child: Text(
                "Bạn có muốn xoá sản phẩm này khỏi giỏ hàng của mình không?",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE),
              ),
            ),
            const SizedBox(
              height: Dimensions.MARGIN_SIZE_LARGE,
            ),
            Row(
              children: [
                BtnCustomBorder(
                  onTap: () {},
                  text: "Đồng ý",
                  width: DeviceUtils.getScaledWidth(context, 0.7) / 2,
                ),
                const SizedBox(
                  width: Dimensions.MARGIN_SIZE_SMALL,
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
