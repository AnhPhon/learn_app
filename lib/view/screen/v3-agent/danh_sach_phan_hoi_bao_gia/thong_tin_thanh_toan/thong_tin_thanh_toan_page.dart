import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/thong_tin_thanh_toan/thong_tin_thanh_toan_controller.dart';

class V3ThongTinThanhToanPage extends GetView<V3ThongTinThanhToanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: controller.title),
      body: GetBuilder<V3ThongTinThanhToanController>(
        init: V3ThongTinThanhToanController(),
        builder: (V3ThongTinThanhToanController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      children: [
                        const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
                        const Text(
                          "Hướng dẫn thực hiện thanh toán",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          ),
                        ),
                        huongDanThanhToanWidget(context),
                        const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                            left: Dimensions.MARGIN_SIZE_SMALL,
                          ),
                          child: const Text(
                            "Nhớ chụp màn hình giao dịch để cập nhật thông tin nhanh hơn",
                            style: TextStyle(
                              color: ColorResources.RED,
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                            ),
                          ),
                        ),

                        // nội dung chuyển khoản
                        const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                        noiDungChuyenKhoanWidget(context),

                        // nội dung chuyển khoản
                        const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),
                        _file(),
                      ],
                    ),
                  ),
                  // Hinh Anh Khoi Luong
                  LongButton(
                    title: "Xác nhận",
                    color: ColorResources.THEME_DEFAULT,
                    onPressed: () {
                      controller.onXacNhanClick();
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
  ///
  ///
  Widget huongDanThanhToanWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: Dimensions.MARGIN_SIZE_DEFAULT),
      child: Column(
        children: List.generate(
          controller.labels.length,
          (index) {
            final String title = controller.labels[index][0].toString();
            String value = controller.labels[index][1].toString();
            if (title.toLowerCase().contains("số tiền tối thiểu")) {
              value =
                  "${PriceConverter.convertPrice(context, double.parse(value))} VND";
            }
            return SizedBox(
              height: 50,
              width: DeviceUtils.getScaledWidth(context, 1),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: Dimensions.FONT_SIZE_LARGE + 12,
                    child: SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .4),
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_LARGE),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: DeviceUtils.getScaledWidth(context, .3),
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: DeviceUtils.getScaledWidth(context, 1),
                      child: Wrap(
                        children: [
                          Text(
                            value,
                            style: const TextStyle(
                                fontSize: Dimensions.FONT_SIZE_LARGE),
                          ),
                          const SizedBox(width: Dimensions.MARGIN_SIZE_SMALL),
                          if (title.toLowerCase().contains("số tài khoản"))
                            GestureDetector(
                              onTap: () {
                                Alert.success(message: "Đã copy thành công");
                                Clipboard.setData(ClipboardData(text: value));
                              },
                              child: const Icon(
                                Icons.file_copy_rounded,
                                color: ColorResources.BLACKGREY,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  ///
  /// nội dung chuyển khoản widget
  ///
  Widget noiDungChuyenKhoanWidget(BuildContext context) {
    return Column(
      children: [
        // label
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Tải ảnh đơn giao dịch",
            style: TextStyle(
              color: ColorResources.BLACKGREY,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),

        // content
        Stack(
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.all(
                Dimensions.PADDING_SIZE_SMALL,
              ),
              alignment: Alignment.topLeft,
              decoration: const BoxDecoration(
                color: ColorResources.WHITE,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Dimensions.BORDER_RADIUS_SMALL,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorResources.LIGHT_GREY,
                    blurRadius: 2,
                  )
                ],
              ),
              child: Text(controller.noiDungChuyenKhoan),
            )
          ],
        )
      ],
    );
  }

  ///
  ///file
  ///
  Widget _file() {
    return Column(
      children: [
        //show file
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            "Tải ảnh đơn giao dịch",
            style: TextStyle(
              color: ColorResources.BLACKGREY,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),

        //add file
        GestureDetector(
          onTap: controller.pickFiles,
          child: BoxShadowWidget(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_LARGE,
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, size: Dimensions.ICON_SIZE_EXTRA_LARGE),
                  Text("Cập nhật file báo giá"),
                ],
              )),
        ),
      ],
    );
  }
}
