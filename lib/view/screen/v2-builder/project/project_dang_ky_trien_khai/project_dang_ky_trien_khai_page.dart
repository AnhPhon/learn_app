import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v2-builder/component_builder/btn_component.dart';
import 'package:template/view/screen/v2-builder/project/project_dang_ky_trien_khai/project_dang_ky_trien_khai_controller.dart';

class V2ProjectDangKyTrienKhaiPage extends GetView<V2ProjectDangKyTrienKhaiController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ProjectDangKyTrienKhaiController>(
      init: V2ProjectDangKyTrienKhaiController(),
      builder: (controller) {
        return controller.duAnKhachHangResponse == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                extendBodyBehindAppBar: false,
                appBar: AppBarWidget(title: controller.title),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                      _textTitle(),

                      //content
                      _content(),
                    ],
                  ),
                ),
              );
      },
    );
  }

  ///
  ///text title
  ///
  Widget _textTitle() {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      margin: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
      child: Text(
        'Tên dự án: ' + controller.duAnKhachHangResponse!.ten.toString(),
        style: Dimensions.fontSizeStyle22w600(),
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content() {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      // margin: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Địa điểm:",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          Text(
            controller.duAnKhachHangResponse!.diaDiem.toString(),
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Text(
            "Giới thiệu:",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          Text(
            controller.duAnKhachHangResponse!.gioiThieu.toString(),
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Row(
            children: [
              Text(
                "Dự kiến kết thúc: ",
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18w600(),
              ),
              Text(
                DateConverter.isoStringToddMMYYYY(controller.duAnKhachHangResponse!.ngayKetThuc.toString()),
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18(),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Text(
            "Thợ thầu đăng ký hạng mục tham gia báo giá",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),

          // nhom cong viec
          if (controller.nhomDichVuResponse != null && controller.nhomDichVuResponse!.length > 2)
            DropDownButton<NhomDichVuResponse>(
              onChanged: (val) => controller.updateNhomDichVu(val!),
              data: controller.nhomDichVuResponse!,
              width: DeviceUtils.getScaledWidth(Get.context!, 1),
              value: controller.currentNhomDichVuResponse,
              obligatory: true,
              label: "Chọn nhóm công việc phù hợp",
              hint: controller.currentNhomDichVuResponse.tenDichVu.toString(),
            )
          else
            const SizedBox(),

          const Label(
            label: "Chọn công việc phù hợp",
            obligatory: true,
            horizontalPadding: 0,
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w600,
            ),
          ),
          // cong viec phu hop
          if (controller.nhomDichVuResponse != null && controller.nhomDichVuResponse!.length > 2)
            MultiSelectDialogField(
              listType: MultiSelectListType.CHIP,
              items: controller.loaiCongViecMultiSelectItem,
              title: const Text("Hãy chọn các công việc phù hợp"),
              selectedColor: Colors.blue,
              selectedItemsTextStyle: const TextStyle(color: ColorResources.WHITE),
              checkColor: ColorResources.WHITE,
              buttonText: const Text(
                "Chọn công việc phù hợp",
                style: TextStyle(
                  color: ColorResources.GREY,
                  fontSize: 16,
                ),
              ),
              onConfirm: (List<LoaiCongViecResponse?> results) {
                controller.selectedCongViecPhuHop(results);
              },
            )
          else
            const SizedBox(),

          const Label(
            label: "Thời gian bắt đầu làm",
            obligatory: true,
            horizontalPadding: 0,
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFieldDate(
            paddingTop: 0,
            allowEdit: false,
            controller: controller.textDateController,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            holdplacer: 'Chọn ngày',
            obligatory: false,
            typeInput: TextInputType.datetime,
            width: DeviceUtils.getScaledWidth(Get.context!, 1),
            onDateTimeChanged: (val){
              controller.danhSachThoThauBaoGiaRequest.thoiGianBatDauLam = val;
            },
            isDate: true,
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          const Label(
            label: "Số lượng người",
            obligatory: true,
            horizontalPadding: 0,
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            child: TextField(
              textInputAction: TextInputAction.next,
              textAlignVertical: TextAlignVertical.center,
              controller: controller.soLuongNguoiLamController,
              keyboardType: TextInputType.number,
              cursorColor: ColorResources.PRIMARY,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_DEFAULT,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                ),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT), borderSide: const BorderSide(color: ColorResources.PRIMARY)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT), borderSide: const BorderSide(color: ColorResources.GREY)),
                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT), borderSide: const BorderSide(color: ColorResources.GREY)),
                hintText: "Nhập số lượng người tham gia",
                filled: true,
                fillColor: Colors.transparent,
              ),
              onChanged: (val){
                if(val.isNotEmpty && val.isNumericOnly){
                  controller.danhSachThoThauBaoGiaRequest.soLuongNguoi = int.parse(val);
                }
              },
            ),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          BtnCustom(
            onTap: () {
              controller.moViewDangKyViecMoi();
            },
            color: ColorResources.PRIMARY,
            text: "Đăng ký",
            width: DeviceUtils.getScaledWidth(Get.context!, 1),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
        ],
      ),
    );
  }
}
