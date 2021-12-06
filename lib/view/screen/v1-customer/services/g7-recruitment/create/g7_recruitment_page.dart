import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/create/g7_recruitment_controller.dart';

class V1G7RecruitmentPage extends GetView<V1G7RecruitmentController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const AppBarWidget(title: "Tạo đơn dịch vụ"),
        body: SingleChildScrollView(
          child: GetBuilder(
            init: V1G7RecruitmentController(),
            builder: (V1G7RecruitmentController controller) {
              return Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
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
            },
          ),
        ),
      ),
    );
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
          label: "Tiêu đề tuyển dụng",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.next,
          focusNode: controller.titleFocusNode,
          onSubmitted: (val) {
            FocusScope.of(context).requestFocus(controller.companyFocusNode);
          },
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
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.next,
          focusNode: controller.companyFocusNode,
          onSubmitted: (val) {
            FocusScope.of(context).requestFocus(controller.addressFocusNode);
          },
        ),

        //Công ty *
        // InputField(
        //   allowEdit: true,
        //   allowMultiline: false,
        //   controller: controller.workController,
        //   fontSize: Dimensions.FONT_SIZE_LARGE,
        //   holdplacer: "Nhập địa chỉ công ty",
        //   hidden: false,
        //   label: "Địa chỉ công ty",
        //   obligatory: true,
        //   typeInput: TextInputType.text,
        //   width: DeviceUtils.getScaledWidth(context, 1),
        //   textInputAction: TextInputAction.next,
        //   focusNode: controller.workFocusNode,
        //   onSubmitted: (val) {
        //     FocusScope.of(context).requestFocus(controller.addressFocusNode);
        //   },
        // ),

        // Địa chỉ chọn tỉnh
        // SearchDropDownButton<TinhTpResponse>(isEnable: controller.isEdit, onChanged: (item) => controller.onChangedTinhThanh(item!), data: controller.tinhTpModel, width: DeviceUtils.getScaledWidth(context, 1), value: controller.tinhTpDiaChi, obligatory: true, label: "Tỉnh/Tp", hint: "Chọn tỉnh", padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_LARGE)),

        // Địa chỉ chọn huyện
        // SearchDropDownButton<QuanHuyenResponse>(isEnable: controller.isEdit, onChanged: (item) => controller.onChangedQuanHuyen(item!), data: controller.quanHuyenModel, width: DeviceUtils.getScaledWidth(context, 1), value: controller.quanHuyenResponse, obligatory: true, label: "Quận/Huyện", hint: "Chọn quận/huyện", padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_LARGE)),
        // Địa chỉ chọn xã
        // SearchDropDownButton<PhuongXaResponse>(isEnable: controller.isEdit, onChanged: (item) => controller.onChangedPhuongXa(item!), data: controller.phuongXaModel, width: DeviceUtils.getScaledWidth(context, 1), value: controller.phuongXaResponse, obligatory: true, label: "Phường/Xã", hint: "Chọn phường/xã", padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_LARGE)),
        //Địa chỉ
        InputField(
          allowEdit: controller.isEdit,
          allowMultiline: false,
          controller: controller.addressController,
          focusNode: controller.addressFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập địa chỉ công ty",
          hidden: false,
          label: "Địa chỉ công ty",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.next,
          onSubmitted: (val) {
            FocusScope.of(context).requestFocus(controller.amountFocusNode);
          },
        ),

        // Giới tính
        Row(
          children: [
            const Label(
                label: "Giới tính",
                obligatory: true,
                style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontWeight: FontWeight.w600)),
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
                      groupValue: controller.chooseSex),
                  RadioButton(
                      title: 'Tất cả',
                      onChanged: (int? val) {
                        controller.getChangeSex(val!);
                      },
                      value: 3,
                      groupValue: controller.chooseSex),
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
          focusNode: controller.amountFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập số lượng ứng tuyển",
          hidden: false,
          label: "Số lượng ứng tuyển",
          obligatory: true,
          typeInput: TextInputType.number,
          isInteger: true,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.next,
          onSubmitted: (val) {
            FocusScope.of(context)
                .requestFocus(controller.thoiGianThucTapFocusNode);
          },
        ),

        // Hình thức làm viêc
        SearchDropDownButton<HinhThucLamViecResponse>(
          onChanged: (item) => controller.onChangeHinhThucLamViec(item!),
          data: controller.hinhThucLamViecModel,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.hinhThucLamViec,
          obligatory: true,
          label: "Hình thức làm việc",
          hint: "Chọn hình thức làm việc",
          isSort: false,
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
            top: Dimensions.PADDING_SIZE_LARGE,
          ),
        ),

        // Trình độ học vấn
        SearchDropDownButton<TrinhDoHocVanResponse>(
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
            top: Dimensions.PADDING_SIZE_LARGE,
          ),
        ),

        // Chuyên ngành chính
        SearchDropDownButton<LoaiCongViecResponse>(
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
            top: Dimensions.PADDING_SIZE_LARGE,
          ),
        ),

        //Chuyên ngàng phụ
        //TODO: Baohq
        const Label(
          label: "Chuyên ngành phụ",
          obligatory: false,
          style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: Stack(
            children: [
              MultiSelectBottomSheetField(
                decoration: BoxDecoration(
                  border: Border.all(color: ColorResources.PRIMARYCOLOR),
                  borderRadius: BorderRadius.circular(
                    Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                  ),
                ),
                confirmText: const Text('Đồng ý'),
                cancelText: const Text('Hủy'),
                initialChildSize: 0.8,
                maxChildSize: 0.8,
                listType: MultiSelectListType.CHIP,
                searchable: true,
                buttonIcon: const Icon(Icons.arrow_drop_down),
                buttonText: const Text(
                  "Chọn chuyên ngành phụ",
                  style: TextStyle(
                    color: ColorResources.GREY,
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                ),
                title: const Text("Chuyên ngành phụ"),
                items: controller.chuyenNganhPhuModel
                    .map((item) => MultiSelectItem<LoaiCongViecResponse>(
                        item, item.tenCongViec!))
                    .toList(),
                onConfirm: (values) {
                  controller.chuyenNganhPhus = values;
                  DeviceUtils.unFocus(context);
                  // FocusScope.of(context).requestFocus(FocusNode());
                },
                chipDisplay: MultiSelectChipDisplay(
                  onTap: (value) {
                    controller.removerChuyenNganhPhu(value);
                  },
                ),
              ),
              if (controller.chuyenNgangChinh == null)
                GestureDetector(
                  onTap: () {
                    if (controller.chuyenNgangChinh == null) {
                      Alert.error(message: "Vui lòng chọn chuyên ngành chính");
                    }
                  },
                  child: Container(
                    height: 47,
                    color: Colors.transparent,
                  ),
                )
            ],
          ),
        ),

        // Số năm kinh nghiệm
        SearchDropDownButton<SoNamKinhNghiemResponse>(
          onChanged: (item) => controller.onChangeSoNamKinhNghiem(item!),
          data: controller.soNamKinhNghiemModel,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.soNamKinhNghiem,
          obligatory: true,
          isSort: false,
          label: "Số năm kinh nghiệm",
          hint: "Chọn số năm kinh nghiệm",
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
            top: Dimensions.PADDING_SIZE_LARGE,
          ),
        ),

        //Mức lương ban đầu dự kiến *
        SearchDropDownButton<MucLuongDuKienResponse>(
          onChanged: (item) => controller.onChangeMucLuongDuKien(item!),
          data: controller.mucLuongDuKienModel,
          width: DeviceUtils.getScaledWidth(context, 1),
          value: controller.mucLuongDuKien,
          obligatory: true,
          isSort: false,
          label: "Mức lương ban đầu dự kiến",
          hint: "Chọn mức lương ban đầu dự kiến",
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
            top: Dimensions.PADDING_SIZE_LARGE,
          ),
        ),

        //Nơi làm việc
        const Label(
          label: "Nơi làm việc",
          obligatory: true,
          style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: MultiSelectDialogField(
            decoration: BoxDecoration(
              border: Border.all(color: ColorResources.PRIMARYCOLOR),
              borderRadius: BorderRadius.circular(
                Dimensions.BORDER_RADIUS_EXTRA_SMALL,
              ),
            ),
            buttonIcon: const Icon(Icons.arrow_drop_down),
            listType: MultiSelectListType.CHIP,
            items: controller.noiLamViecList,
            title: const Text("Nơi làm việc"),
            selectedColor: Colors.blue,
            selectedItemsTextStyle:
                const TextStyle(color: ColorResources.WHITE),
            checkColor: ColorResources.WHITE,
            searchable: true,
            buttonText: const Text(
              "Nơi làm việc",
              style: TextStyle(
                color: ColorResources.GREY,
                fontSize: 16,
              ),
            ),
            onConfirm: (List<TinhTpResponse?> results) {
              controller.noiLamViecs = results;
              // FocusScope.of(context).requestFocus(FocusNode());
              FocusScope.of(context).canRequestFocus;
            },
          ),
        ),

        // Thời gian thử việc
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.thoiGianThucTapController,
          focusNode: controller.thoiGianThucTapFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập thời gian thử việc (tháng)",
          hidden: false,
          label: "Thời gian thử việc (tháng)",
          obligatory: true,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.next,
          onSubmitted: (val) {
            FocusScope.of(context).requestFocus(controller.descFocusNode);
          },
        ),

        // Mô tả công việc
        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.descController,
          focusNode: controller.descFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Vui lòng nhập mô tả công việc",
          hidden: false,
          label: "Mô tả công việc",
          obligatory: true,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.newline,
          typeInput: TextInputType.multiline,
          onSubmitted: (val) {
            FocusScope.of(context).requestFocus(controller.requiredFocusNode);
          },
        ),

        // Yêu cẩu công việc
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.requiredController,
          focusNode: controller.requiredFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập yêu cầu công việc",
          hidden: false,
          label: "Yêu cầu công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.next,
          onSubmitted: (val) {
            FocusScope.of(context).requestFocus(controller.benifitFocusNode);
          },
        ),

        // Chế độ quyển lợi
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.benifitController,
          focusNode: controller.benifitFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập chế độ quyền lợi",
          hidden: false,
          label: "Chế độ quyền lợi",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.next,
          onSubmitted: (val) {
            FocusScope.of(context)
                .requestFocus(controller.prioritizedFocusNode);
          },
        ),

        // Ưu tiên
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.prioritizedController,
          focusNode: controller.prioritizedFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập ưu tiên",
          hidden: false,
          label: "Ưu tiên",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.next,
          onSubmitted: (val) {
            FocusScope.of(context).requestFocus(controller.nameFocusNode);
          },
        ),

        // Hạn nộp hết ngày
        GestureDetector(
          onTap: () {
            controller.selectDate(context);
            DeviceUtils.unFocus(context);
          },
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
                      bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: const [
                        Text(
                          'Hạn nộp hết ngày',
                          style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorResources.PRIMARYCOLOR),
                      borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                      ),
                    ),
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
                            color: ColorResources.GREY,
                          ),
                        ),
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
          focusNode: controller.nameFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập họ tên người liên hệ",
          hidden: false,
          label: "Họ và tên",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.next,
          onSubmitted: (val) {
            FocusScope.of(context).requestFocus(controller.phoneFocusNode);
          },
        ),

        //Số điện thoại
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.phoneController,
          focusNode: controller.phoneFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập số điện thoại",
          hidden: false,
          label: "Số điện thoại",
          obligatory: true,
          typeInput: TextInputType.phone,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.next,
          onSubmitted: (val) {
            FocusScope.of(context)
                .requestFocus(controller.contactFocusNodetroller);
          },
        ),

        //Địa chỉ
        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.contactAddressController,
          focusNode: controller.contactFocusNodetroller,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập địa chỉ người liên hệ",
          hidden: false,
          label: "Địa chỉ",
          line: 2,
          obligatory: true,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.newline,
          typeInput: TextInputType.multiline,
          onSubmitted: (val) {
            FocusScope.of(context).requestFocus(controller.emailFocusNode);
          },
        ),

        //Email
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.emailController,
          focusNode: controller.emailFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập email người liên hệ",
          hidden: false,
          label: "Email",
          obligatory: true,
          typeInput: TextInputType.emailAddress,
          width: DeviceUtils.getScaledWidth(context, 1),
        ),

        //hình ảnh đại điện
        Container(
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_DEFAULT,
            right: Dimensions.PADDING_SIZE_DEFAULT,
            top: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          width: DeviceUtils.getScaledWidth(context, 1),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: Dimensions.PADDING_SIZE_DEFAULT),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    children: const [
                      Text(
                        'Hình ảnh đại diện',
                        style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_LARGE, // * 2.1,
                          fontWeight: FontWeight.w600,
                          color: ColorResources.BLACK,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _uploadImage(context, controller)
            ],
          ),
        )
      ],
    );
  }

  ///
  ///upload image
  ///
  Widget _uploadImage(
      BuildContext context, V1G7RecruitmentController controller) {
    return GestureDetector(
      onTap: () => controller.pickHinhDaiDien(),
      child: Container(
        child: controller.hinhAnhDaiDien != null
            ? ClipRRect(
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                child: Image.network(
                  controller.hinhAnhDaiDien!,
                  fit: BoxFit.cover,
                  height: Dimensions.AVATAR_SQUARE_SIZE_DEFAULT,
                  width: Dimensions.AVATAR_SQUARE_SIZE_DEFAULT,
                ),
              )
            : Image.asset(
                Images.add_image,
                height: DeviceUtils.getScaledHeight(context, .092),
                width: DeviceUtils.getScaledWidth(context, .25),
                fit: BoxFit.fill,
                color: ColorResources.PRIMARY,
              ),
      ),
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
