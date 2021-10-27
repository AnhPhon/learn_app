import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/finish_update/finish_update_controller.dart';

class V2FinishUpdatePage extends GetView<V2FinishUpdateController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2FinishUpdateController>(
      init: V2FinishUpdateController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Đăng ký thuế và cam kết thuế
                  _textOnClick(
                    "Đăng ký thuế và cam kết thuế (đối với tổ đội/thợ/lao động phổ thông)",
                    controller.onDangKyVaCamKetClick,
                    controller.thueValid == true &&
                        controller.camKetValid == true,
                  ),

                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  // Đăng ký ký hợp đồng nguyên tăc hợp tác với FSS
                  _textOnClick(
                    "Đăng ký ký hợp đồng nguyên tăc hợp tác với FSS",
                    controller.onDangKyHopDongClick,
                    controller.hopDongValid,
                  ),

                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  // bổ sung hoặc đăng ký mua bảo hiểm tai nạn chưa có trước khi làm việc
                  _textOnClick(
                    "Bổ sung hoặc đăng ký mua bảo hiểm tai nạn chưa có trước khi làm việc",
                    controller.onBaoHiemTaiNanClick,
                    controller.baoHiemValid,
                  ),

                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  // bổ sung giấy chứng nhận khám sức khỏe đạt đủ điều kiện làm việc
                  _textOnClick(
                    "Bổ sung Giấy chứng nhận khám sức khỏe đạt đủ điều kiện làm việc",
                    controller.onGiayChungNhanKhamSucKhoeClick,
                    controller.chungNhanValid,
                  ),

                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  // bổ sung mã số thuế
                  _textOnClick(
                    "Bổ sung Mã số thuế (áp dụng tổ đội/ cá nhân)",
                    controller.onDangKyHopDongClick,
                    controller.maSoThueValid,
                  ),

                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  // cập nhật sản phẩm mẫu
                  _textOnClick(
                    "Cập nhập sản phẩm mẫu",
                    controller.onCapNhatSanPhamClick,
                    controller.sanPhamMauValid,
                  ),

                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  // cập nhật sản phẩm mẫu
                  _textOnClick(
                    "Cập nhập bảng giá",
                    controller.onCapNhatSanPhamClick,
                    controller.bangGiaValid,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _textOnClick(String label, Function() onTap, bool isPass) {
    return GestureDetector(
      onTap: () {
        if (!isPass) {
          onTap();
        }
      },
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: const BoxDecoration(
          color: ColorResources.WHITE,
          boxShadow: [
            BoxShadow(
              color: ColorResources.LIGHT_GREY,
              blurRadius: 5,
            )
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(
              Dimensions.BORDER_RADIUS_DEFAULT,
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: TextStyle(
                  color: (isPass == true)
                      ? const Color(Dimensions.TEXT_NORMAL_COLOR)
                      : ColorResources.RED,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  color: (isPass == true)
                      ? ColorResources.GREEN
                      : ColorResources.RED,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      Dimensions.BORDER_RADIUS_BIG,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: Text(
                  (isPass == true) ? "Đầy đủ" : "Cần bổ sung",
                  style: const TextStyle(
                    color: ColorResources.WHITE,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
