import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/create/g7_recruitment_controller.dart';

class V1G7RecruitmentPage extends GetView<V1G7RecruitmentController>{

  final V1G7RecruitmentController _controller = Get.find<V1G7RecruitmentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Tạo đơn dịch vụ"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Tiêu tề nhóm công việc
              const GroupTitle(title: "Dịch vụ tuyển dụng ứng viên"),

              // Form nhập dữ 
              form(context, _controller),
              
              // Button tiếp tục
              nextButton(controller: _controller)
            ],
          ),
        ),
      )
    );
  }

  ///
  /// form tiêu đề công việc và mô tả công việc , Thời gian
  ///
  Widget form(BuildContext context,V1G7RecruitmentController controller ){
    return Column(
      children: [

        // Tiêu đề cần tuyển
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.titleController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Cần tuyển 2 nhân viên kế toán",
          hidden: false,
          label: "Tiêu đề",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Công ty *
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.companyController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "TNHH Five Start Bulding System",
          hidden: false,
          label: "Công ty",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Địa chỉ
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.addressController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "123B/22 Thanh Khê - Đà Nẵng",
          hidden: false,
          label: "Địa chỉ",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Giới tính
        Row(
          children: [
            const Label(label: "Giới tính", obligatory: true),
            Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              child: Row(
                children: [
                  RadioButton(title: 'Name', onChanged: (val){}, value: 1, groupValue: 1),
                  RadioButton(title: 'Nữ', onChanged: (val){}, value: 1, groupValue: 1)
                ],
              ),
            ),
          ],
        ),

        /// Số lượng ứng tuyển
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.amountController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "5",
          hidden: false,
          label: "Số lượng ứng tuyển",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Hình thức làm viêc
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Bán thời gian", 
          obligatory: true,
          label: "Hình thức làm việc",
          hint: "Bán thời gian",
        ),

        // Trình độ học vấn
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Bán thời gian", 
          obligatory: true,
          label: "Trình độ học vấn",
          hint: "Đại học",
        ),

        // Chuyên ngành chính
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Công nghệ thông tin", 
          obligatory: true,
          label: "Chuyên ngành chính",
          hint: "Công nghệ thông tin",
        ),

        // Số năm kinh nghiệm
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Công nghệ thông tin", 
          obligatory: true,
          label: "Số năm kinh nghiệm",
          hint: "Số năm kinh nghiệm",
        ),
        
        //Mức lương ban đầu dự kiến *
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Công nghệ thông tin", 
          obligatory: true,
          label: "Mức lương ban đầu dự kiến",
          hint: "Mức lương ban đầu dự kiến",
        ),

        //Nơi làm việc
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Công nghệ thông tin", 
          obligatory: true,
          label: "Nơi làm việc",
          hint: "Chọn tỉnh",
        ),

        //Thời gian làm việc
        DropDownButton<String>(
          onChanged: (val){}, 
          data: [], 
          width: DeviceUtils.getScaledWidth(context,1),
          value: "Công nghệ thông tin", 
          obligatory: true,
          label: "Thời gian làm việc",
          hint: "3 tháng",
        ),

        // Mô tả công việc
        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.descController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Phá hoại là chính",
          hidden: false,
          label: "Mô tả công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Yêu cẩu công việc
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.requiredController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Đập phá thiết bị",
          hidden: false,
          label: "Yêu cầu công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Chế độ quyển lợi
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.benifitController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Đập phá thiết bị",
          hidden: false,
          label: "Chế độ quyền lợi",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Ưu tiên
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.prioritizedController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Người biết phá hoại",
          hidden: false,
          label: "Ưu tiên",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Hạn nộp hết ngày
        TextFieldDate(
          allowEdit: true,
          controller: controller.endTimeController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "12-12-2021",
          label: "Hạn nộp hết ngày",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1), 
          isDate: true,
        ),

        const Label(label: "Liên hệ nộp hồ sơ:", obligatory: false, style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          fontWeight: FontWeight.bold,
        ),),

        // Họ và tên
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.nameController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Tập tành lập trình",
          hidden: false,
          label: "Họ và tên",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Số điện thoại 
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.phoneController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "999.999.9999",
          hidden: false,
          label: "Số điện thoại",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Địa chỉ
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.contactAddressController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Thanh Khê - Đà Nẵng",
          hidden: false,
          label: "Địa chỉ",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Email
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.emailController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Example@gmail.com",
          hidden: false,
          label: "Email",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

      ],
    );
  }

  ///
  /// Nút tiếp tục
  ///

  Widget nextButton({required V1G7RecruitmentController controller}){
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