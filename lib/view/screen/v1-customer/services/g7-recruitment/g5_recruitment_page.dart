import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/checkbox_custom.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/g5-car_rental/g5_create_service_controller.dart';

class V1G5CreateServicePage extends GetView<V1G5CreateServiceController>{

  final V1G5CreateServiceController _controller = Get.find<V1G5CreateServiceController>();

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
              const GroupTitle(title: "Dịch vụ xe tải, xe ben, cầu thùng"),

              // Form nhập dữ 
              form(context, controller),
              
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
  Widget form(BuildContext context,V1G5CreateServiceController controller ){
    return Column(
      children: [

        // Tiêu đề này đổ dữ liệu từ màn hình tạo dịch vụ đầu tiên
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.workTitleController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Xây nhà",
          hidden: false,
          label: "Tiêu đề công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Thông số kỹ thuật
        const Label(label: "Thông số kỹ thuật", obligatory: true),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: Material(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)
            ),
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CheckBoxCustom(title: "Thông số kỹ thuật", onChanged: (bool? val) {  },status: false,);
                },
                itemCount: 10,
              ),
            ),
          ),
        ),

        // Thời gian làm việc trong ngày
        const Label(label: "Thời gian làm trong ngày", obligatory: true),
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE * 2),
          child: Column(
            children: [
              CheckBoxCustom(title: "Sáng: từ 7h30 - 11h30", onChanged: (bool? val) {  },status: false,),
              CheckBoxCustom(title: "Sáng: từ 7h30 - 11h30", onChanged: (bool? val) {  },status: false,),
              CheckBoxCustom(title: "Sáng: từ 7h30 - 11h30", onChanged: (bool? val) {  },status: false,),
            ],
          ),
        ),

        /// Số lượng yêu cầu
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.amountController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "5",
          hidden: false,
          label: "Số lượng yêu cầu",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Ngày làm việc
        TextFieldDate(
          isDate: true,
          allowEdit: true,
          controller: controller.startWorkController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "12-11-2021",
          label: "Ngày làm việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Địa điểm bốc hàng
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.estimatedPickUpLocation,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Thanh Khê - Đà Nẵng",
          hidden: false,
          label: "Địa điểm bốc hàng dự kiến",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Địa điểm trả hàng dự kiến
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.estimatedDeliveryLocation,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Thanh Khê - Đà Nẵng",
          hidden: false,
          label: "Địa điểm trả hàng dự kiến",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Cự ly vận chuyển đương đối* (km)
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.distanceController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Thanh Khê - Đà Nẵng",
          hidden: false,
          label: "Cự ly vận chuyển đương đối(km)",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Bề rộng mặt đường nhận hàng(m)
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.receivingWidthController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Thanh Khê - Đà Nẵng",
          hidden: false,
          label: "Bề rộng mặt đường nhận hàng (m)",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Bề rộng mặt đường trả hàng (m)
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.receivingWidthController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Thanh Khê - Đà Nẵng",
          hidden: false,
          label: "Bề rộng mặt đường trả hàng (m)",
          obligatory: false,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        

        //Miêu tả yêu cầu công việc cụ thể* 
        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.workDescController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "Xây nhà lầu",
          hidden: false,
          label: "Miêu tả yêu cầu công việc cụ thể",
          obligatory: true,
          textInputAction: TextInputAction.newline,
          typeInput: TextInputType.multiline,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

      ],
    );
  }

  ///
  /// Nút tiếp tục
  ///

  Widget nextButton({required V1G5CreateServiceController controller}){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: controller.onClickContinueButton,
        title: "Tiếp tục",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }

}