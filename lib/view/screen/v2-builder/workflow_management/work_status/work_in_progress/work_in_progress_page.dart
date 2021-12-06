import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/trang_thai_don_dich_vu_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/btn_component_border.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v2-builder/workflow_management/work_status/work_in_progress/work_in_progress_controller.dart';

class V2WorkInProgressPage extends GetView<V2WorkInProgressController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2WorkInProgressController>(
      init: V2WorkInProgressController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return UnFocusTextField(
          widget: Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //image
                  _image(context, controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_SMALL,
                  ),

                  //title
                  _title(controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_SMALL,
                  ),

                  //content
                  _content(controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  _trangThaiWidget(context),
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //customers opinion
                  _customersOpinion(controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //agents opinion
                  _agentsOpinion(controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //btn send
                  _btnSend(context, controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  ///image
  ///
  Widget _image(BuildContext context, {required V2WorkInProgressController controller}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        Dimensions.BORDER_RADIUS_DEFAULT,
      ),
      child: FadeInImageCustom(
        urlImage: controller.donDichVuResponse.idNhomDichVu!.hinhAnhDaiDien.toString(),
        height: .45,
        width: .95,
        fit: BoxFit.cover,
      ),
    );
  }

  ///
  ///title
  ///
  Widget _title({required V2WorkInProgressController controller}) {
    return GroupTitle(
      title: controller.donDichVuResponse.tieuDe.toString(),
    );
  }

  ///
  ///item
  ///
  Widget _item({required Icon icon, String? title}) {
    return Row(
      children: [
        icon,
        if (title != null)
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }

  ///
  ///content
  ///
  Widget _content({required V2WorkInProgressController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _item(
            icon: const Icon(
              Icons.location_city_rounded,
              color: ColorResources.PRIMARY,
            ),
            title: controller.donDichVuResponse.idTinhTp != null ? controller.donDichVuResponse.idTinhTp!.ten : null,
          ),
          _item(
            icon: const Icon(
              Icons.location_on,
              color: ColorResources.PRIMARY,
            ),
            title: controller.donDichVuResponse.idQuanHuyen != null ? controller.donDichVuResponse.idQuanHuyen!.ten : null,
          ),
          _item(
            icon: const Icon(
              Icons.access_time_outlined,
              color: ColorResources.PRIMARY,
            ),
            title: (controller.donDichVuResponse.ngayKetThuc == 'null')
                ? controller.getDeadline(
                    start: controller.donDichVuResponse.ngayBatDau.toString(),
                    end: DateTime.now().toIso8601String(),
                  )
                : controller.getDeadline(
                    start: controller.donDichVuResponse.ngayBatDau.toString(),
                    end: controller.donDichVuResponse.ngayKetThuc.toString(),
                  ),
          ),
        ],
      ),
    );
  }

  ///
  /// trang thai widget
  ///
  Widget _trangThaiWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //label
          const Text(
            "Trạng thái",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          //dropdown
          DropDownButton<TrangThaiDonDichVuResponse>(
            data: controller.trangThais.map((e) {
              if (e.tieuDe.toString() == "Trúng thầu") {
                e.tieuDe = "Đang làm";
              }

              if (e.tieuDe.toString() == "Chưa nghiệm thu") {
                e.tieuDe = "Hoàn thành";
              }
              return e;
            }).toList(),
            value: controller.trangThais[0],
            obligatory: false,
            width: DeviceUtils.getScaledWidth(context, 0.4),
            onChanged: (data) {
              controller.onThayDoiTrangThaiChange(
                data: data!,
                widget: _dialogItem(
                  context,
                  controller: controller,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  ///
  ///customer's opinion
  ///
  Widget _customersOpinion({required V2WorkInProgressController controller}) {
    return Container(
      padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Khách hàng đánh giá",
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (controller.phanHoiDonDichVuRequest.khachHangDanhGia == null)
            const SizedBox.shrink()
          else
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                controller.phanHoiDonDichVuRequest.khachHangDanhGia.toString(),
                style: const TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
              ),
            ),
        ],
      ),
    );
  }

  ///
  ///customer's opinion
  ///
  Widget _agentsOpinion({required V2WorkInProgressController controller}) {
    return InputWidget(
      label: "Ý kiến thợ thầu",
      labelBold: true,
      hintText: "Ý kiến phản hồi của thợ thầu",
      textEditingController: controller.yKienThoThauController,
      fillColor: ColorResources.WHITE,
      allowEdit: controller.phanHoiDonDichVuRequest.khachHangDanhGia != null && controller.phanHoiDonDichVuRequest.yKienThoThau == null,
      width: .95,
      maxLine: 5,
    );
  }

  ///
  ///btn send
  ///
  Widget _btnSend(
    BuildContext context, {
    required V2WorkInProgressController controller,
  }) {
    return BtnCustom(
      onTap: (controller.phanHoiDonDichVuRequest.khachHangDanhGia == null || controller.phanHoiDonDichVuRequest.yKienThoThau != null) ? () {} : () => controller.onBtnSendClick(),
      color: (controller.phanHoiDonDichVuRequest.khachHangDanhGia == null || controller.phanHoiDonDichVuRequest.yKienThoThau != null) ? ColorResources.GREY : ColorResources.PRIMARY,
      text: "Gửi",
      width: DeviceUtils.getScaledWidth(context, .95),
    );
  }

  ///
  ///dialog
  ///
  Widget _dialogItem(
    BuildContext context, {
    required V2WorkInProgressController controller,
  }) {
    return Center(
      child: Container(
        height: DeviceUtils.getScaledHeight(context, .35),
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
            //title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.error_outline,
                  color: ColorResources.RED,
                ),
                SizedBox(
                  width: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                ),
                Text(
                  "Xác nhận",
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Divider(
              thickness: 2,
              color: ColorResources.GREY.withOpacity(.5),
            ),

            //note
            const Flexible(
              child: Text(
                "Bạn có chắc chắn muốn chuyển đổi trạng thái không?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                ),
              ),
            ),

            const SizedBox(
              height: Dimensions.MARGIN_SIZE_LARGE,
            ),

            //btn
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //accept
                BtnCustomBorder(
                  onTap: () {
                    Get.back();
                  },
                  text: "Huỷ",
                  width: DeviceUtils.getScaledWidth(context, 0.7) / 2,
                ),

                const SizedBox(
                  width: Dimensions.MARGIN_SIZE_SMALL,
                ),

                //cancel
                BtnCustom(
                  onTap: () {
                    controller.onAcceptClick();
                    Get.back();
                  },
                  color: ColorResources.PRIMARY,
                  text: "Đồng ý",
                  width: DeviceUtils.getScaledWidth(context, 0.7) / 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
