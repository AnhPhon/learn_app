import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/basewidget/my_dialog.dart';
import 'package:template/view/screen/checkout/checkout_controller.dart';
import 'package:template/view/screen/register/register_controller.dart';

class CheckoutPage extends GetView<CheckoutController> {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
        init: CheckoutController(),
        builder: (CheckoutController value) {
          return Scaffold(
            appBar: CustomAppBar().customAppBar(title: "Thanh toán"),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DeviceUtils.getScaledSize(context, 0.1),
                          vertical: DeviceUtils.getScaledSize(context, 0.01)),
                      child: Image.asset(
                        "assets/images/bank.png",
                        height: 200,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.1),
                        vertical: DeviceUtils.getScaledSize(context, 0.01)),
                    child: DefaultTextStyle(
                      style: Dimensions.fontSizeStyle16().copyWith(
                          decoration: TextDecoration.none,
                          color: ColorResources.BLACK),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text("Thông tin tài khoản"),
                          const Text("Số tài khoản: XXXX XXXX XXXX"),
                          const Text("Tên chủ tài khoản: Nguyễn Văn A"),
                          const Text("Tên ngân hàng: Ngân hàng Sacombank"),
                          const Text("Chi nhánh Gia Lai"),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: DeviceUtils.getScaledSize(context, 0.02),
                        horizontal: DeviceUtils.getScaledSize(context, 0.07)),
                    child: const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DeviceUtils.getScaledSize(context, 0.1),
                          vertical: DeviceUtils.getScaledSize(context, 0.01)),
                      child: Column(
                          children: List.generate(
                        registerController.orderList.length,
                        (index) => Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.asset(
                                    registerController
                                        .items[
                                            registerController.orderList[index]]
                                        .url,
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      registerController
                                          .items[registerController
                                              .orderList[index]]
                                          .title,
                                      style: titilliumSemiBold.copyWith(
                                          fontSize: 16),
                                    ),
                                    Text(
                                      PriceConverter.convertPrice(
                                          context,
                                          registerController
                                              .items[registerController
                                                  .orderList[index]]
                                              .amount
                                              .toDouble()),
                                      style: titilliumSemiBold.copyWith(
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "x${registerController.items[registerController.orderList[index]].quality.toString()}",
                                      style: titilliumSemiBold.copyWith(
                                          color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      DeviceUtils.getScaledSize(context, 0.01),
                                  horizontal:
                                      DeviceUtils.getScaledSize(context, 0.1)),
                              child: const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ))),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.1),
                        vertical: DeviceUtils.getScaledSize(context, 0.005)),
                    child: Text(
                      "Tổng tiền phải trả: ${PriceConverter.convertPrice(context, registerController.sum * .75)}",
                      style: titilliumSemiBold.copyWith(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.1),
                        vertical: DeviceUtils.getScaledSize(context, 0.07)),
                    child: GestureDetector(
                      onTap: () {
                        registerController.pickImage();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Tải lên hình ảnh thanh toán",
                            style: Dimensions.fontSizeStyle16w600().copyWith(
                                decoration: TextDecoration.underline,
                                color: ColorResources.LIGHT_SKY_BLUE),
                          ),
                          SizedBox(
                              width: DeviceUtils.getScaledSize(context, 0.01)),
                          if (registerController.image != null)
                            Image.file(
                              registerController.image!,
                              height: DeviceUtils.getScaledSize(context, 0.127),
                              width: DeviceUtils.getScaledSize(context, 0.178),
                            )
                          else
                            Icon(
                              Icons.image_outlined,
                              size: DeviceUtils.getScaledSize(context, 0.08),
                            ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (registerController.image != null) {
                        Get.offNamed(AppRoutes.DASHBOARD);

                        showAnimatedDialog(
                            context,
                            const MyDialog(
                              icon: Icons.check,
                              title: "Hoàn tất",
                              description: "Đặt hàng thành công",
                            ),
                            dismissible: false,
                            isFlip: true);
                      } else {
                        Get.snackbar(
                          "Thất bại",
                          "Vui lòng tải lên hình ảnh thanh toán",
                          colorText: ColorResources.RED,
                          backgroundGradient: const LinearGradient(colors: [
                            Color(0xffffb8b3),
                            Color(0xffff9b94),
                            Color(0xffffb8b3),
                          ], begin: Alignment(2, -1), end: Alignment(1, 5)),
                        );
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: DeviceUtils.getScaledSize(context, 0.1)),
                      alignment: Alignment.center,
                      height: DeviceUtils.getScaledSize(context, 0.12),
                      decoration: BoxDecoration(
                          color: ColorResources.PRIMARY,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "Hoàn tất",
                        style: Dimensions.fontSizeStyle16w600()
                            .copyWith(color: ColorResources.WHITE),
                      ),
                    ),
                  ),
                  SizedBox(height: DeviceUtils.getScaledSize(context, 0.15)),
                ],
              ),
            ),
          );
        });
  }
}
