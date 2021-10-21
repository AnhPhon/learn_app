import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v3-agent/finish_update/finish_update_controller.dart';

class V3FinishUpdatePage extends GetView<V3FinishUpdateController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3FinishUpdateController>(
      init: V3FinishUpdateController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _textOnClick(
                      "Đăng ký thuế và cam kết thuế (đối với tổ đội/thợ/lao động phổ thông)",
                      controller.onDangKyVaCamKetClick),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  _textOnClick("Đăng ký ký hợp đồng nguyên tăc hợp tác với FSS",
                      controller.onDangKyHopDongClick),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  _textOnClick(
                      "Bổ sung hoặc đăng ký mua bảo tai nạn chưa có trước khi làm việc",
                      controller.onBaoHiemTaiNanClick),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  _textOnClick(
                      "Bổ sung Giấy chứng nhận khám sức khỏe đạt đủ điều kiện làm việc",
                      controller.onGiayChungNhanKhamSucKhoeClick),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  _textOnClick("Bổ sung Mã số thuế (áp dụng tổ đội/ cá nhân)",
                      controller.onMaSoThueClick),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  _textOnClick("Cập nhập sản phẩm mẫu",
                      controller.onCapNhatSanPhamClick),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _textOnClick(String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: Dimensions.textNormalStyle(),
        ),
      ),
    );
  }
}
