import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/help/help_controller.dart';

class V1HelpPage extends GetView<V1HelpController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1HelpController>(
        init: V1HelpController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: AppBarWidget(title: controller.title),
            body: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                Container(
                  margin: const EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL,
                    vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                    border: Border.all(color: ColorResources.GREY),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Liên hệ với chúng tôi!",
                        style: Dimensions.fontSizeStyle20w600(),
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),
                      _rowWidget(
                          label: "Địa chỉ",
                          content:
                              controller.lienHeCongTyResponse.diaChi.toString(),
                          controller: controller,
                          url: "",),
                      _rowWidget(
                          label: "Email",
                          content:
                              controller.lienHeCongTyResponse.email.toString(),
                          controller: controller,
                          url:
                              "mailto:${controller.lienHeCongTyResponse.email}",),
                      _rowWidget(
                          label: "Số điện thoại",
                          content: controller.lienHeCongTyResponse.soDienThoai
                              .toString(),
                          controller: controller,
                          url:
                              "tel:${controller.lienHeCongTyResponse.soDienThoai}",),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  ///
  ///row widget
  ///
  Widget _rowWidget({
    required String label,
    required String content,
    required String url,
    required V1HelpController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () => controller.btnContact(url: url),
              child: Text(
                content,
                maxLines: 2,
                textAlign: TextAlign.right,
                style: Dimensions.fontSizeStyle18()
                    .copyWith(color: ColorResources.GREY),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
