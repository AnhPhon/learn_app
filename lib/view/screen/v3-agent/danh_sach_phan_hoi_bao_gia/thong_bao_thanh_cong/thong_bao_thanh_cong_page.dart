import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/screen/v3-agent/danh_sach_phan_hoi_bao_gia/thong_bao_thanh_cong/thong_bao_thanh_cong_controller.dart';

class V3ThongBaoThanhCongPage extends GetView<V3ThongBaoThanhCongController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3ThongBaoThanhCongController>(
        init: V3ThongBaoThanhCongController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),
                  //image
                  _image(),

                  //note
                  _note(context)
                ],
              ),
            ),
            bottomNavigationBar: _btnBottomSheet(controller),
          );
        });
  }

  ///
  ///image
  ///
  Widget _image() {
    return Image.asset(Images.payment_success);
  }

  ///
  ///note
  ///
  Widget _note(BuildContext context) {
    return DefaultTextStyle(
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: ColorResources.BLACK,
        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: Column(
          children: const [
            SizedBox(
              height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
            ),
            Text(
              "Bạn đã thanh toán thành công!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
            Text(
                "Đề nghị chuẩn bị đơn hàng để giao đến khách hàng đúng thời hạn!"),
            SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
            Text("Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!"),
          ],
        ),
      ),
    );
  }

  ///
  ///btn bottomsheet
  ///
  Widget _btnBottomSheet(V3ThongBaoThanhCongController controller) {
    return BtnCustom(
      onTap: () => controller.onXacNhanClick(),
      color: ColorResources.PRIMARY,
      text: "Xác nhận",
      width: double.infinity,
    );
  }
}
