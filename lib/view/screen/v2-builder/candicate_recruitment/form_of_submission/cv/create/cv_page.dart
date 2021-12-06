import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/hon_nhan_model.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/custom_file_button.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/cv/create/cv_controller.dart';

class V2CvPage extends GetView<V2CvController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: const AppBarWidget(title: "Tin tuyển dụng"),
          body: GetBuilder(
              init: V2CvController(),
              builder: (V2CvController controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      form(context, controller),
                      button(controller: controller),
                      const SizedBox(
                        height: Dimensions.SIZE_LARGE,
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget text({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: TextHighlight(
        title: title,
        titleStyle: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_LARGE,
          color: ColorResources.BLACK,
          fontWeight: FontWeight.bold,
        ),
        content: content,
        style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_LARGE,
        ),
      ),
    );
  }

  ///
  /// form tiêu đề công việc và mô tả công việc , Thời gian
  ///
  Widget form(BuildContext context, V2CvController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          textInputAction: TextInputAction.done,
          focusNode: controller.titleFocusNode,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                  title: "Tên ứng viên: ",
                  content: controller.tenUngVienController.text),
              text(
                  title: "Giới tính: ",
                  content: controller.gioiTinhVienController.text == '1'
                      ? 'Nam'
                      : 'Nữ'),
              text(
                  title: "Ngày sinh: ",
                  content: DateConverter.readMongoToString(
                      controller.ngaySinhController.text.toString())),
              text(
                  title: "Điện thoại: ",
                  content: controller.dienThoaiController.text),
              text(
                  title: "Email: ",
                  content: controller.emailController.text
                      .replaceAll("null", "Không có")),
            ],
          ),
        ),

        // Địa chỉ chọn tỉnh
        SearchDropDownButton<TinhTpResponse>(
            fillColor: ColorResources.WHITE,
            isColorFieldWhite: true,
            onChanged: (item) => controller.onChangedTinhTp(item!),
            data: controller.tinhTpListModel.isNotEmpty
                ? controller.tinhTpListModel
                : [],
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.tinhTp,
            obligatory: true,
            label: "Tỉnh/Tp",
            hint: "Chọn tỉnh",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_DEFAULT)),

        // Địa chỉ chọn huyện
        SearchDropDownButton<QuanHuyenResponse>(
            fillColor: ColorResources.WHITE,
            isColorFieldWhite: true,
            onChanged: (item) => controller.onChangedQuanHuyen(item!),
            data: controller.quanHuyenListModel.isNotEmpty
                ? controller.quanHuyenListModel
                : [],
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.quanHuyenResponse,
            obligatory: true,
            label: "Quận/Huyện",
            hint: "Chọn quận/huyện",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_DEFAULT)),
        // Địa chỉ chọn xã
        SearchDropDownButton<PhuongXaResponse>(
            fillColor: ColorResources.WHITE,
            isColorFieldWhite: true,
            onChanged: (item) => controller.onChangedPhuongXa(item!),
            data: controller.phuongXaListModel.isNotEmpty
                ? controller.phuongXaListModel
                : [],
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.phuongXaResponse,
            obligatory: true,
            label: "Phường/Xã",
            hint: "Chọn phường/xã",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_DEFAULT)),
        const SizedBox(
          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        ),
        //Địa chỉ
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.addressController,
          focusNode: controller.addressFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập địa chỉ",
          hidden: false,
          label: "Địa chỉ",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.done,
        ),

        // hôn nhân
        DropDownButton<HonNhanModel>(
            isColorFieldWhite: true,
            onChanged: (item) => controller.onChangedHonNhan(item!),
            data: controller.honNhanListModel,
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.honNhanModel,
            obligatory: true,
            label: "Hôn nhân",
            hint: "Chọn tình trạng hôn nhân",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_LARGE)),
        const SizedBox(
          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        ),

        // Hình thức làm việc
        SearchDropDownButton<HinhThucLamViecResponse>(
            fillColor: ColorResources.WHITE,
            isColorFieldWhite: true,
            onChanged: (item) => controller.onChangeHinhThucLamViec(item!),
            data: controller.hinhThucLamViecListModel.isNotEmpty
                ? controller.hinhThucLamViecListModel
                : [],
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.hinhThucLamViec,
            obligatory: true,
            label: "Hình thức việc làm",
            hint: "Chọn hình thức việc làm",
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_LARGE)),
        const SizedBox(
          height: Dimensions.PADDING_SIZE_SMALL,
        ),

        //mục tiêu nghề nghiệp
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.mucTieuController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập mục tiêu nghề nghiệp",
          hidden: false,
          label: "Mục tiêu nghề nghiệp",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.done,
          focusNode: controller.mucTieuFocusNode,
        ),
        const SizedBox(
          height: Dimensions.PADDING_SIZE_EXTRA_SMALL * 2,
        ),

        // file hô so xin việc
        if (controller.dangKyViecMoiResponse.fileHoSoXinViec.toString() !=
            'null')
          const Label(label: "File hồ sơ xin việc", obligatory: true),
        // Cập nhật Cv đầy đủ thông tin
        if (!Validate.checkValueIsNullEmpty(
            controller.dangKyViecMoiResponse.fileHoSoXinViec.toString()))
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: SizedBox(
              width: DeviceUtils.getScaledWidth(context, 1),
              child: GestureDetector(
                onTap: Validate.checkValueIsNullEmpty(controller
                        .dangKyViecMoiResponse.fileHoSoXinViec
                        .toString())
                    ? () => controller.onBtnDownloadCv(
                        url: controller.dangKyViecMoiResponse.fileHoSoXinViec
                            .toString())
                    : () {},
                child: BoxShadowWidget(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Text(
                      Validate.checkValueIsNullEmpty(
                              controller.tenFile.toString())
                          ? 'File hồ sơ xin việc'
                          : controller.tenFile.toString(),
                      style: const TextStyle(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                      )),
                ),
              ),
            ),
          ),

        CustomFileButton(
            title: Validate.checkValueIsNullEmpty(
                    controller.dangKyViecMoiResponse.fileHoSoXinViec.toString())
                ? 'Thêm file hồ sơ'
                : 'Cập nhật tập tin',
            verticalPadding: Dimensions.PADDING_SIZE_DEFAULT,
            onTap: () => controller.pickFiles())
      ],
    );
  }

  ///
  /// Button
  ///
  Widget button({required V2CvController controller}) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: LongButton(
          title: "Nộp hồ sơ",
          color: ColorResources.PRIMARYCOLOR,
          onPressed: () => controller.nopHoSO()),
    );
  }
}
