import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:template/data/model/response/chuyen_nganh_chinh_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/thoi_gian_lam_viec_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/create/g7_recruitment_controller.dart';

class V1G7RecruitmentPage extends GetView<V1G7RecruitmentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(title: "Tạo đơn dịch vụ"),
        body: SingleChildScrollView(
          child: GetBuilder(
              init: V1G7RecruitmentController(),
              builder: (V1G7RecruitmentController controller) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: !controller.isLoading
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tiêu tề nhóm công việc
                            const GroupTitle(
                                title: "Dịch vụ tuyển dụng ứng viên"),

                            // Form nhập dữ
                            form(context, controller),

                            // Button tiếp tục
                            nextButton(controller: controller)
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                );
              }),
        ));
  }

  ///
  /// form tiêu đề công việc và mô tả công việc , Thời gian
  ///
  Widget form(BuildContext context, V1G7RecruitmentController controller) {
    return Column(
      children: [
        // Tiêu đề cần tuyển
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.titleController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập tiêu đề",
          hidden: false,
          label: "Tiêu đề",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        //Công ty *
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.companyController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập tên công ty",
          hidden: false,
          label: "Công ty",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        // Địa chỉ chọn tỉnh
        DropDownButton<TinhTpResponse>(
            onChanged: (item) => controller.onChangedTinhThanh(item!),
            data: controller.tinhTpModel,
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.tinhTpDiaChi,
            obligatory: true,
            label: "Tỉnh/Tp",
            hint: "Chọn tỉnh",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_LARGE)),

        // Địa chỉ chọn huyện
        DropDownButton<QuanHuyenResponse>(
            onChanged: (item) => controller.onChangedQuanHuyen(item!),
            data: controller.quanHuyenModel,
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.quanHuyenResponse,
            obligatory: true,
            label: "Quận/Huyện",
            hint: "Chọn quận/huyện",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_LARGE)),
        // Địa chỉ chọn xã
        DropDownButton<PhuongXaResponse>(
            onChanged: (item) => controller.onChangedPhuongXa(item!),
            data: controller.phuongXaModel,
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.phuongXaResponse,
            obligatory: true,
            label: "Phường/Xã",
            hint: "Chọn phường/xã",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_LARGE)),
        //Địa chỉ
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.addressController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập địa chỉ",
          hidden: false,
          label: "Địa chỉ",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        // Giới tính
        Row(
          children: [
            const Label(
                label: "Giới tính",
                obligatory: true,
                style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding:
                  const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              child: Row(
                children: [
                  RadioButton(
                      title: 'Nam',
                      onChanged: (int? val) {
                        controller.getChangeSex(val!);
                      },
                      value: 1,
                      groupValue: controller.chooseSex),
                  RadioButton(
                      title: 'Nữ',
                      onChanged: (int? val) {
                        controller.getChangeSex(val!);
                      },
                      value: 2,
                      groupValue: controller.chooseSex)
                ],
              ),
            ),
          ],
        ),

        /// Số lượng ứng tuyển
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.amountController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập số lượng ứng tuyển",
          hidden: false,
          label: "Số lượng ứng tuyển",
          obligatory: true,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context, 1),
          paddingTop: Dimensions.PADDING_SIZE_SMALL,
        ),

        // Hình thức làm viêc
        DropDownButton<HinhThucLamViecResponse>(
          onChanged: (item) => controller.onChangeHinhThucLamViec(item!),
          data: controller.hinhThucLamViecModel,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.hinhThucLamViec,
          obligatory: true,
          label: "Hình thức làm việc",
          hint: "Chọn hình thức làm việc",
          padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT,
              right: Dimensions.PADDING_SIZE_DEFAULT,
              top: Dimensions.PADDING_SIZE_LARGE),
        ),

        // Trình độ học vấn
        DropDownButton<TrinhDoHocVanResponse>(
            onChanged: (item) => controller.onChangeTrinhDoHocVan(item!),
            data: controller.trinhDoHocVanModel,
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.trinhDoHocVan,
            obligatory: true,
            label: "Trình độ học vấn",
            hint: "Chọn trình độ học vấn",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_LARGE)),

        // Chuyên ngành chính
        DropDownButton<ChuyenNganhChinhResponse>(
            onChanged: (item) => controller.onChangeChuyenNganhChinh(item!),
            data: controller.chuyenNganhChinhModel,
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.chuyenNgangChinh,
            obligatory: true,
            label: "Chuyên ngành chính",
            hint: "Chọn chuyên ngành chính",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_LARGE)),

        //Chuyên ngàng phụ
        const Label(
          label: "Chuyên ngành phụ",
          obligatory: true,
          style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: MultiSelectBottomSheetField(
            decoration: BoxDecoration(
                border: Border.all(color: ColorResources.PRIMARYCOLOR),
                borderRadius: BorderRadius.circular(
                    Dimensions.BORDER_RADIUS_EXTRA_SMALL)),
            confirmText: const Text('Đồng ý'),
            cancelText: const Text('Hủy'),
            initialChildSize: 0.4,
            listType: MultiSelectListType.CHIP,
            searchable: true,
            buttonText: const Text(
              "Chọn chuyên ngành phụ",
              style: TextStyle(
                  color: ColorResources.GREY,
                  fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
            title: const Text("Chuyên ngành phụ"),
            items: controller.chuyenNganhPhuModel
                .map((item) => MultiSelectItem<ChuyenNganhChinhResponse>(
                    item, '${item.tieuDe}'))
                .toList(),
            onConfirm: (values) {
              controller.chuyenNganhPhus = values;
            },
            chipDisplay: MultiSelectChipDisplay(
              onTap: (value) {
                controller.removerChuyenNganhPhu(value);
              },
            ),
          ),
        ),

        // Số năm kinh nghiệm
        DropDownButton<SoNamKinhNghiemResponse>(
          onChanged: (item) => controller.onChangeSoNamKinhNghiem(item!),
          data: controller.soNamKinhNghiemModel,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.soNamKinhNghiem,
          obligatory: true,
          label: "Số năm kinh nghiệm",
          hint: "Chọn số năm kinh nghiệm",
          padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT,
              right: Dimensions.PADDING_SIZE_DEFAULT,
              top: Dimensions.PADDING_SIZE_LARGE),
        ),

        //Mức lương ban đầu dự kiến *
        DropDownButton<MucLuongDuKienResponse>(
            onChanged: (item) => controller.onChangeMucLuongDuKien(item!),
            data: controller.mucLuongDuKienModel,
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.mucLuongDuKien,
            obligatory: true,
            label: "Mức lương ban đầu dự kiến",
            hint: "Chọn mức lương ban đầu dự kiến",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_LARGE)),

        //Nơi làm việc
        DropDownButton<TinhTpResponse>(
            onChanged: (item) => controller.onChangeTinhTp(item!),
            data: controller.tinhTpModel,
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.tinhTp,
            obligatory: true,
            label: "Nơi làm việc",
            hint: "Chọn tỉnh",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_LARGE)),

        //Thời gian làm việc
        DropDownButton<ThoiGianLamViecResponse>(
            onChanged: (item) => controller.onChangeThoiGianLamViec(item!),
            data: controller.thoiGianLamViecModel,
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.thoiGianLamViec,
            obligatory: true,
            label: "Thời gian làm việc",
            hint: "Chọn thời gian làm việc",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_LARGE)),

        // Mô tả công việc
        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.descController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Vui lòng nhập mô tả công việc",
          hidden: false,
          label: "Mô tả công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        // Yêu cẩu công việc
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.requiredController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập yêu cầu công việc",
          hidden: false,
          label: "Yêu cầu công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        // Chế độ quyển lợi
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.benifitController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập chế độ quyền lợi",
          hidden: false,
          label: "Chế độ quyền lợi",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        // Ưu tiên
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.prioritizedController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập ưu tiên",
          hidden: false,
          label: "Ưu tiên",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        // Hạn nộp hết ngày
        GestureDetector(
          onTap: () => controller.selectDate(context),
          child: Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: Container(
              padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              width: DeviceUtils.getScaledWidth(context, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: const [
                        Text(
                          'Hạn nộp hết ngày',
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_LARGE,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorResources.PRIMARYCOLOR),
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL)),
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            controller.dateFormat
                                .format(controller.selectedDate)
                                .toString(),
                            style: const TextStyle(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                color: ColorResources.GREY)),
                        const Icon(
                          Icons.date_range,
                          color: ColorResources.PRIMARYCOLOR,
                          size: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        // thời gian thực tập
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.thoiGianThucTapController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập thời gian thực tập (tháng)",
          hidden: false,
          label: "Thời gian thực tập (tháng)",
          obligatory: true,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        const Label(
          label: "Liên hệ nộp hồ sơ:",
          obligatory: false,
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Họ và tên
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.nameController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập họ tên người liên hệ",
          hidden: false,
          label: "Họ và tên",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        //Số điện thoại
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.phoneController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập số điện thoại",
          hidden: false,
          label: "Số điện thoại",
          obligatory: true,
          typeInput: TextInputType.phone,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        //Địa chỉ
        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.contactAddressController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập địa chỉ người liên hệ",
          hidden: false,
          label: "Địa chỉ",
          line: 2,
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        //Email
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.emailController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập email người liên hệ",
          hidden: false,
          label: "Email",
          obligatory: true,
          typeInput: TextInputType.emailAddress,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),
      ],
    );
  }

  ///
  /// Nút tiếp tục
  ///

  Widget nextButton({required V1G7RecruitmentController controller}) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: controller.onClickContinueButton,
        title: "Xem trước tin đăng tuyển",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }
}
