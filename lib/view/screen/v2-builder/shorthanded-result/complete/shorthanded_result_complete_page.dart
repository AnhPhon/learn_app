import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/screen/v2-builder/shorthanded-result/complete/shorthanded_result_complete_controller.dart';

class V2ShorthandedCompletePage extends GetView<V2ShorthandedCompleteController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedCompleteController>(
        init: V2ShorthandedCompleteController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(
              title: controller.title,
              isNotBack: true,
            ),
            body: Container(
              padding: const EdgeInsets.all(
                Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: boxShadow,
                      borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      color: ColorResources.WHITE,
                    ),
                    height: MediaQuery.of(context).size.height - 400,
                    child: ListView(
                      children: [
                        // Label thong tin lien he voi khach hang
                        if (Validate.checkValueIsNullEmpty(controller.idDonDichVu.diaChiCuThe) == false)
                          rowInfoKhachHang(
                            title: 'Tên KH',
                            content: controller.idDonDichVu.idTaiKhoan!.hoTen.toString(),
                          )
                        else
                          const SizedBox(),
                        if (Validate.checkValueIsNullEmpty(controller.idDonDichVu.diaChiCuThe) == false)
                          rowInfoKhachHang(
                            title: 'Địa chỉ KH',
                            content: controller.idDonDichVu.idTaiKhoan!.diaChi.toString(),
                          )
                        else
                          const SizedBox(),
                        if (Validate.checkValueIsNullEmpty(controller.idDonDichVu.diaChiCuThe) == false)
                          rowInfoKhachHang(
                            title: 'Địa chỉ dự án',
                            content: controller.idDonDichVu.diaChiCuThe.toString(),
                          )
                        else
                          const SizedBox(),
                        if (Validate.checkValueIsNullEmpty(controller.idDonDichVu.diaChiCuThe) == false)
                          rowInfoKhachHang(
                            title: 'Số điện thoại',
                            content: controller.idDonDichVu.idTaiKhoan!.soDienThoai.toString(),
                          )
                        else
                          const SizedBox(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  const Text(
                    "Chúng tôi đã nhận được thông tin từ khách hàng và liên lạc với khách hàng trong thời gian sớm nhất ! Cảm ơn",
                    style: TextStyle(
                      color: ColorResources.GREY,
                      // fontWeight: FontWeight.bold,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox(),
                  ),
                  LongButton(
                    title: "Liên hệ khách hàng",
                    color: ColorResources.PRIMARYCOLOR,
                    onPressed: () {
                      controller.callToNumber();
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  LongButton(
                    title: "Quay về",
                    color: ColorResources.UNSELECT_TABBAR,
                    onPressed: () {
                      Get.offAndToNamed(AppRoutes.V2_NOTIFICATION);
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  /// Label thong tin lien he voi khach hang
  ///
  Widget rowInfoKhachHang({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_SMALL,
        right: Dimensions.PADDING_SIZE_SMALL,
        top: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              content,
              style: const TextStyle(
                color: ColorResources.BLACK,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
              textAlign: TextAlign.right,
              maxLines: 10,
            ),
          ),
        ],
      ),
    );
  }
}
