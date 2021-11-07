import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/thong_so_ky_thuat_response.dart';
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
import 'package:multi_select_flutter/multi_select_flutter.dart';

class V1G5CreateServicePage extends GetView<V1G5CreateServiceController>{

  final V1G5CreateServiceController _controller = Get.find<V1G5CreateServiceController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: _controller.appBarTitle),
      body: GetBuilder(
        builder: (V1G5CreateServiceController controller) {
          if(controller.isLoading || controller.isThongSo){
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Tiêu tề nhóm công việc
                  const GroupTitle(title: "Dịch vụ xe tải, xe ben, cầu thùng"),

                  // Form nhập dữ 
                  form(context, controller),
                  
                  // Button tiếp tục
                  nextButton(controller: controller)
                ],
              ),
            ),
          );
        },
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
          fontSize: Dimensions.FONT_SIZE_LARGE,
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
          child: MultiSelectDialogField(
            listType: MultiSelectListType.CHIP,
            buttonIcon: const Icon(Icons.arrow_drop_down),
            items: controller.thongSoKyThuatList,
            title: const Text("Thông số kỹ thuật"),
            selectedColor: Colors.blue,
            selectedItemsTextStyle: const TextStyle(
              color: ColorResources.WHITE
            ),
            checkColor: ColorResources.WHITE,
            buttonText: Text(
              "Thông số kỹ thuật",
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            onConfirm: (List<ThongSoKyThuatResponse?> results) {
              controller.thongSo = results;
            },
          ),
        ),

        // Thời gian làm việc trong ngày
        const Label(label: "Thời gian làm trong ngày", obligatory: true),
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_LARGE * 2),
          child: Column(
            children: [
              CheckBoxCustom(title: "Sáng: từ 7h30 - 11h30", onChanged: (bool? val) { 
                    controller.onSelectedTommorow(val: val!);
                  },status: controller.tommorow,),
                  CheckBoxCustom(title: "Chiều: từ 13h30 - 17h30", onChanged: (bool? val) { 
                    controller.onSelectedAfternoon(val: val!);
                  },status: controller.afternoon,),
                  CheckBoxCustom(title: "Tối: từ 18h30 - 22h30", onChanged: (bool? val) {  
                    controller.onSelectedTonight(val: val!);
                  },status: controller.tonight,),
            ],
          ),
        ),

        /// Số lượng yêu cầu
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.amountController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "5",
          hidden: false,
          label: "Số lượng yêu cầu",
          obligatory: true,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Ngày làm việc
        TextFieldDate(
          isDate: true,
          allowEdit: true,
          controller: controller.startWorkController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "12-11-2021",
          label: "Ngày làm việc",
          obligatory: true,
          typeInput: TextInputType.datetime,
          width: DeviceUtils.getScaledWidth(context,1),
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),

        // Địa điểm bốc hàng
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.estimatedPickUpLocation,
          fontSize: Dimensions.FONT_SIZE_LARGE,
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
          fontSize: Dimensions.FONT_SIZE_LARGE,
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
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "10km",
          hidden: false,
          isDecimal: true,
          label: "Cự ly vận chuyển đương đối(km)",
          obligatory: true,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Bề rộng mặt đường nhận hàng(m)
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.receivingWidthController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "5.5m",
          hidden: false,
          isDecimal: true,
          label: "Bề rộng mặt đường nhận hàng(m)",
          obligatory: false,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        //Bề rộng mặt đường trả hàng (m)
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.returnWidthController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "5.5m",
          hidden: false,
          isDecimal: true,
          label: "Bề rộng mặt đường trả hàng (m)",
          obligatory: false,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        

        //Miêu tả yêu cầu công việc cụ thể* 
        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.workDescController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Bốc hàng",
          hidden: false,
          label: "Miêu tả yêu cầu công việc cụ thể",
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

  Widget nextButton({required V1G5CreateServiceController controller}){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
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