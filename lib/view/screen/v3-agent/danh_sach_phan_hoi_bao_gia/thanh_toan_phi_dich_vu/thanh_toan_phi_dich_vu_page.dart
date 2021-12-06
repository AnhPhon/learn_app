import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/thanh_toan_phi_dich_vu/thanh_toan_phi_dich_vu_controller.dart';

class V3ThanhToanPhiDichVuPage extends GetView<V3ThanhToanPhiDichVuController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: controller.title),
      body: GetBuilder<V3ThanhToanPhiDichVuController>(
        init: V3ThanhToanPhiDichVuController(),
        builder: (V3ThanhToanPhiDichVuController controller) {
          // if (controller.isLoading) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  // note label
                  Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    height: DeviceUtils.getScaledHeight(context, .75),
                    decoration: const BoxDecoration(
                      color: ColorResources.WHITE,
                      boxShadow: [
                        BoxShadow(
                          color: ColorResources.LIGHT_BLACK,
                          blurRadius: 2,
                        )
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          Dimensions.BORDER_RADIUS_SMALL,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Bạn cần thanh toán phi dịch vụ để chúng tôi cung cấp thông tin khách hàng giao dịch",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),
                        LabelContent(
                          title: "Thông tin đơn hàng",
                          content: Column(
                            children: [
                              Row(
                                children: [
                                  const Text("Phí dịch vụ app"),
                                  const Spacer(),
                                  Text(
                                      "${PriceConverter.convertPrice(context, controller.phiDichVuApp)} VND"),
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_SMALL),
                              Row(
                                children: [
                                  const Text("Khuyến mãi của app"),
                                  const Spacer(),
                                  Text(
                                      "${PriceConverter.convertPrice(context, controller.khuyenMaiApp)} VND"),
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_SMALL),
                              splitWidget(),
                              const SizedBox(
                                  height: Dimensions.MARGIN_SIZE_DEFAULT),
                              Row(
                                children: [
                                  const Text("Cần thanh toán"),
                                  const Spacer(),
                                  Text(
                                    "${PriceConverter.convertPrice(context, controller.canThanhToan)} VND",
                                    style: const TextStyle(
                                      color: ColorResources.RED,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          isRequired: false,
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                  // Hinh Anh Khoi Luong
                  LongButton(
                    title: "Thanh toán",
                    color: ColorResources.THEME_DEFAULT,
                    onPressed: () {
                      controller.onTaiKhoanCuaBanClick();
                    },
                  ),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// split widget
  ///
  Widget splitWidget() {
    return Container(
      decoration: const BoxDecoration(
        color: ColorResources.LIGHT_BLACK,
      ),
      height: 2,
    );
  }
}
