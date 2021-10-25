import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:template/data/model/response/thong_so_ky_thuat_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/checkbox_custom.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/g6-excavation/g6_create_service_controller.dart';

class V1G6CreateServicePage extends GetView<V1G6CreateServiceController>{
  final V1G6CreateServiceController _controller = Get.find<V1G6CreateServiceController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: _controller.appBarTitle),
      body: GetBuilder(
        builder: (V1G6CreateServiceController controller) {
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
                  const GroupTitle(title: "Dịch vụ xe đào, cầu nặng , máy khác"),

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
  Widget form(BuildContext context,V1G6CreateServiceController controller ){
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

        /// Thông số kỹ thuật
        ///
        ///

        const Label(label: "Thông số kỹ thuật", obligatory: true),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: MultiSelectDialogField(
            buttonIcon: const Icon(Icons.arrow_drop_down),
            listType: MultiSelectListType.CHIP,
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
          controller: controller.startTimeController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "12-11-2021",
          label: "Ngày làm việc",
          obligatory: true,
          typeInput: TextInputType.datetime,
          width: DeviceUtils.getScaledWidth(context,1),
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),

        // Ngày kết thúc dự kiến
        TextFieldDate(
          isDate: true,
          allowEdit: true,
          controller: controller.endTimeController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "12-11-2021",
          label: "Ngày kết thúc dự kiến",
          obligatory: true,
          typeInput: TextInputType.datetime,
          width: DeviceUtils.getScaledWidth(context,1),
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),


       // Bề rộng mặt đường làm việc
        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.workWidthController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "100",
          hidden: false,
          label: "Bề rộng mặt đường làm việc(m)",
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
          holdplacer: "Diện tích móng/ móng đơn bằng 1/2 phương bằng 2 phương",
          hidden: false,
          label: "Miêu tả yêu cầu công việc cụ thể",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Hình ảnh bản vẽ nếu có
        sampleProductImages(controller: controller)
      ],
    );
  }

  ///
  ///Hình ảnh bản vẽ
  ///
  Widget sampleProductImages({required V1G6CreateServiceController controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label(
          label: "Hình ảnh sản phẩm mẫu (nếu có)",
          obligatory: false,
          paddingTitle: 0
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxImage(images: controller.productImages,isAddImage: true,onPress:()=> controller.pickerMuilFile(files: controller.productImages) ,onDelete: (File? file, List<File> files)=>controller.onDeleteImage(file: file!,files: files),),
        ),
      ],
    );
  }

  ///
  /// Nút tiếp tục
  ///
  Widget nextButton({required V1G6CreateServiceController controller}){
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