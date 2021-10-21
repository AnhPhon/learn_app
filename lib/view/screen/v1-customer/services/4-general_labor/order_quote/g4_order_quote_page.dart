

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/bang_gia_don_hang_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/order_quote/g4_order_quote_controller.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class V1G4OrderQuotePage extends GetView<V1G4OrderQuoteController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Báo giá đơn hàng"),
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
          
                /// Size cách bottom sheet
                const SizedBox(
                  height: Dimensions.SIZE_SUPER_LARGE + Dimensions.PADDING_SIZE_LARGE,
                )
              ],
            ),
          );
        },
      ),
      bottomSheet: BottomAppBar(
        child: GestureDetector(
          onTap: ()=> controller.onNextPage(),
          child: Container(
            width: DeviceUtils.getScaledWidth(context,1),
            height: Dimensions.SIZE_SUPER_LARGE,
            color: ColorResources.PRIMARYCOLOR,
            alignment: Alignment.center,
            child: const Text("Tiếp tục", style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              fontWeight: FontWeight.bold,
              color: ColorResources.WHITE
            ))
          ),
        ),
      ),
    );
  }


  Widget form(BuildContext context, {required V1G4OrderQuoteController controller}){
    return Column(
      children: [
        DropDownButton<LoaiCongViecResponse>(
            data: controller.workTypes,
            obligatory: true,
            onChanged: (value) => controller.onChangedWorkType(value!),
            value: controller.work,
            width: DeviceUtils.getScaledSize(context,1),
            label: "Loại dịch vụ",
            hint: "Loại dịch vụ",
        ),

        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.priceController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
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
          controller: controller.timeNumberContrller,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "10",
          hidden: false,
          label: "Số lượng thời gian",
          obligatory: true,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        InputField(
          allowEdit: true,
          allowMultiline: false,
          controller: controller.personNumberContrller,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "10",
          hidden: false,
          label: "Số lượng người",
          obligatory: true,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.descController,
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          holdplacer: "mô tả công việc",
          hidden: false,
          label: "Mô tả lại dịch vụ yêu cầu của quý khách để chúng tôi nắm rõ và phục vụ tốt hơn (tránh trường hợp nhầm lẫn",
          obligatory: true,
          typeInput: TextInputType.text,
          width: DeviceUtils.getScaledWidth(context,1),
        ),
        
      ],
    );
  }
}