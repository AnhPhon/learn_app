import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/attach_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/checkbox_custom.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/g2-regular_service/create/g2_create_work_controller.dart';

class V1G2CreateWorkPage extends GetView<V1G2CreateWorkController>{

  final V1G2CreateWorkController _controller = Get.find<V1G2CreateWorkController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Tạo đơn công việc"),
      body: GetBuilder(
        builder: (V1G2CreateWorkController controller) {
          if(controller.isLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Tiêu tề nhóm công việc
                  const GroupTitle(title: "Dịch vụ thường xuyên khảo sát chờ báo giá"),

                  // Form nhập dữ 
                  form(context, _controller),
                  
                  // Button tiếp tục
                  nextButton(controller: _controller)
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
  Widget form(BuildContext context,V1G2CreateWorkController controller ){
    return Column(
      children: [
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.workTitleController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Tiêu đề",
          hidden: false,
          label: "Tiêu đề công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

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

        TextFieldDate(
          isDate: true,
          allowEdit: false,
          controller: controller.startTime,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "12-11-2021",
          label: "Thời gian bắt đầu dự kiến",
          obligatory: true,
          typeInput: TextInputType.datetime,
          width: DeviceUtils.getScaledWidth(context,1),
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),

        TextFieldDate(
          allowEdit: false,
          controller: controller.endTime,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "22-11-2021",
          label: "Thời gian kết thúc dự kiến",
          obligatory: false,
          typeInput: TextInputType.datetime,
          width: DeviceUtils.getScaledWidth(context,1), 
          isDate: true,
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),

        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.workDesc,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Mô tả nội dung công việc",
          hidden: false,
          textInputAction: TextInputAction.next,
          label: "Mô tả công việc",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // Thực trạng
        currentImage(controller: controller),
        // San phẩm mẫu
        sampleProductImages(controller: controller),

        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.massDesc,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Mô khối lượng công việc của bạn",
          hidden: false,
          label: "Mô tả khối lượng công việc (nếu có)",
          obligatory: false,
          textInputAction: TextInputAction.next,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        // HÌnh ảnh bảng khối lượng
        massTableImage(controller: controller),
        // Thêm file
        attchFile(context, controller: controller),
      ],
    );
  }

  ///
  ///Hình ảnh hiện trạng
  ///
  Widget currentImage({required V1G2CreateWorkController controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label(
          label: "Hình ảnh hiện trạng nếu có",
          obligatory: false,
          paddingTitle: 0
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text("(Những công viêc mang tính chất cải tạo cần nhiều hình ảnh chi tiết, cụ thể, rõ ràng để báo giá sát nhất,...)"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxImage(
            images: controller.currentStatusimages,
            isAddImage: true,
            onPress:()=> controller.pickImages(data: controller.currentStatusimages),
            onDelete: (String file, List<String> files)=> controller.onDeleteImage(file: file,files: files,)
          ),
        ),
      ],
    );
  }

  ///
  ///Hình ảnh sản phầm mẫu
  ///
  Widget sampleProductImages({required V1G2CreateWorkController controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const Label(
          label: "Hình ảnh sản phẩm mẫu (nếu có)",
          obligatory: false,
          paddingTitle: 0
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxImage(
            images: controller.productImages,
            isAddImage: true,
            onPress:()=> controller.pickImages(data: controller.productImages),
            onDelete: (String file, List<String> files)=> controller.onDeleteImage(file: file,files: files,)
          ),
        ),
      ],
    );
  }

  ///
  /// Hinh ảnh bảng khối lượng
  ///

  Widget massTableImage({required V1G2CreateWorkController controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        const Label(
          label: "Hình ảnh bảng khối lượng (nếu có)",
          obligatory: false,
          paddingTitle: 0
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxImage(
            images: controller.massImages,
            isAddImage: true,
            onPress:()=> controller.pickImages(data: controller.massImages),
            onDelete: (String file, List<String> files)=> controller.onDeleteImage(file: file,files: files,)
          ),
        ),
      ],
    );
  }

  ///
  /// Nút thêm file
  ///

  Widget attchFile(BuildContext context,{required V1G2CreateWorkController controller}){
    return Column(
      children: [
        const Label(
          label: "Đính kèm file excel hoặc khác (nêu có)",
          obligatory: false,
        ),
        AttachButton(
          title: controller.donDichVuFiles.isEmpty ? "Thêm tập tin" : controller.donDichVuFiles.first, 
          color: ColorResources.WHITE, 
          onPressed: controller.pickFiles,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        )
      ],
    );
  }

  ///
  /// Nút tiếp tục
  ///

  Widget nextButton({required V1G2CreateWorkController controller}){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: ()=> controller.onClickContinueButton(),
        title: "Tiếp tục",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }

}