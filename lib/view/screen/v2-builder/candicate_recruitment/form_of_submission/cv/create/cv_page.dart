import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/small_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/text_highlight.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/custom_file_button.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/form_of_submission/cv/create/cv_controller.dart';

class V2CvPage extends GetView<V2CvController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          textInputAction: TextInputAction.next,
          focusNode: controller.titleFocusNode,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(title: "Tên ứng viên: ", content: "Nguyễn Văn A"),
              text(title: "Giới tính: ", content: "Nam"),
              text(title: "Ngày sinh: ", content: "20/10/1992"),
              text(title: "Điện thoại: ", content: "0932132132"),
              text(title: "Email: ", content: "Exmaple@gmail.com"),
            ],
          ),
        ),

        // Địa chỉ chọn tỉnh
        DropDownButton<TinhTpResponse>(
            onChanged: (item) => controller.onChangedTinhTp(item!),
            data: controller.tinhTpListModel,
            width: DeviceUtils.getScaledWidth(context, 1),
            value: controller.tinhTp,
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
            data: controller.quanHuyenListModel,
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
            data: controller.phuongXaListModel,
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
          focusNode: controller.addressFocusNode,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập địa chỉ",
          hidden: false,
          label: "Địa chỉ",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context, 1),
          textInputAction: TextInputAction.next,
        ),

        // hôn nhân
        DropDownButton<String>(
          onChanged: (val) {},
          data: const [],
          width: DeviceUtils.getScaledWidth(context, 1),
          value: "Độc thân",
          obligatory: true,
          label: "Hôn nhân",
          hint: "Độc thân",
        ),

        // Hình thức làm việc
        DropDownButton<String>(
          onChanged: (val) {},
          data: const [],
          width: DeviceUtils.getScaledWidth(context, 1),
          value: "Bán thời gian",
          obligatory: true,
          label: "Hình thức làm việc",
          hint: "Hình thức làm việc",
        ),

        const Label(label: "Mục tiêu nghê nghiệp", obligatory: true),
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxShadowWidget(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Text(
                "Được làm việc trong môi trường chuyên nghiệp, có chế độ tốt.Nâng cao được trình độ, kỹ năng chuyên môn Cống hiến năng lực bản thân và mong có cơ hội thăng tiến",
                style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                )),
          ),
        ),

        // file hô so xin việc
        const Label(label: "File hồ sơ xin việc", obligatory: true),
        // Cập nhật Cv đầy đủ thông tin
        CustomFileButton(
            title: "Cập nhật file CV đầy đủ thông tin", onTap: () {}),
        CustomFileButton(
            title: "Thêm file",
            verticalPadding: Dimensions.PADDING_SIZE_DEFAULT,
            onTap: () {})
      ],
    );
  }

  ///
  /// Button
  ///
  Widget button({required V2CvController controller}) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmallButton(
              title: "Xem trước",
              color: ColorResources.RED,
              onPressed: () {
                controller.onClickPreviewButton();
              }),
          SmallButton(
              title: "Nộp hồ sơ",
              color: ColorResources.PRIMARYCOLOR,
              onPressed: () {}),
        ],
      ),
    );
  }
}
