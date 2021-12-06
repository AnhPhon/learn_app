

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/order_quote/g4_order_quote_controller.dart';

class V1G4OrderQuotePage extends GetView<V1G4OrderQuoteController> {
  final V1G4OrderQuoteController _controller = Get.find<V1G4OrderQuoteController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBarWidget(
          title: "Báo giá đơn hàng",
          leading: IconButton(onPressed: (){
            _controller.onBack();
          }, icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.WHITE,
            )
          ),
        ),
        body: GetBuilder(
          builder: (V1G4OrderQuoteController controller) {
            if(controller.isLoading){
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Tiêu tề nhóm công việc
                  const GroupTitle(title: "Dịch vụ lao động thủ công"),
                  // Bảng giá từng loại
                  form(context, controller: controller),
            
                  //Button
                  nextButton(controller: controller)
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  Widget form(BuildContext context, {required V1G4OrderQuoteController controller}){
    return Column(
      children: [
        SearchDropDownButton<LoaiCongViecResponse>(
            data: controller.workTypes,
            obligatory: true,
            onChanged: (value) => controller.onChangedWorkType(value!),
            value: controller.work,
            width: DeviceUtils.getScaledSize(context,1),
            label: "Loại dịch vụ",
            hint: "Loại dịch vụ",
            padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),

        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.priceController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "0",
          hidden: false,
          label: "Đơn giá",
          obligatory: true,
          typeInput: TextInputType.number,
          isFormatCurrency: true,
          width: DeviceUtils.getScaledWidth(context,1),
        ),


        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.timeNumberController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập số lượng thời gian yêu cầu",
          hidden: false,
          label: "Số lượng thời gian",
          isInteger: true,
          obligatory: true,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.personNumberController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập số lượng yêu cầu",
          hidden: false,
          label: "Số lượng",
          isInteger: true,
          obligatory: true,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.descController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập nội dung mô tả công việc",
          hidden: false,
          label: "Mô tả lại dịch vụ yêu cầu của quý khách để chúng tôi nắm rõ và phục vụ tốt hơn (tránh trường hợp nhầm lẫn)",
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

  Widget nextButton({required V1G4OrderQuoteController controller}){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: ()=> controller.onNextPage(),
        title: "Tiếp tục",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }

}