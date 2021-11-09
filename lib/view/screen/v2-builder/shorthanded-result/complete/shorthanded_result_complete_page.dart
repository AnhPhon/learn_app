import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/tab_bar_widget.dart';
import 'package:template/view/basewidget/getx_smart_refresh/getx_smart_refresh_page.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/bill_widget.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/order_content.dart';
import 'package:template/view/screen/v2-builder/shorthanded-result/complete/shorthanded_result_complete_controller.dart';
import 'package:template/view/screen/v2-builder/shorthanded-result/shorthanded_result_controller.dart';

class V2ShorthandedCompletePage
    extends GetView<V2ShorthandedCompleteController> {
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
                // physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: boxShadow,
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      color: ColorResources.WHITE,
                    ),
                    height: MediaQuery.of(context).size.height - 300,
                    child: ListView(
                      // physics: const NeverScrollableScrollPhysics(),
                      children: [
                        rowInfoKhachHang(
                          title: 'Tên KH',
                          content: controller.idDonDichVu.idTaiKhoan!.hoTen
                              .toString(),
                        ),
                        rowInfoKhachHang(
                          title: 'Địa chỉ KH',
                          content: controller.idDonDichVu.idTaiKhoan!.diaChi
                              .toString(),
                        ),
                        rowInfoKhachHang(
                          title: 'Địa chỉ dự án',
                          content:
                              controller.idDonDichVu.diaDiemLamViec.toString(),
                        ),
                        rowInfoKhachHang(
                          title: 'Số điện thoại',
                          content: controller
                              .idDonDichVu.idTaiKhoan!.soDienThoai
                              .toString(),
                        ),
                      ],
                    ),
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
          Text(
            title,
            style: const TextStyle(fontSize: Dimensions.FONT_SIZE_LARGE),
          ),
          Text(
            content,
            style: TextStyle(
              color: ColorResources.BLACK,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
        ],
      ),
    );
  }
}
