

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/bang_gia_don_hang_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/order_quote/g3_order_quote_controller.dart';

class V1G3OrderQuotePage extends GetView<V1G3OrderQuoteController> {
  V1G3OrderQuotePage({Key? key}) : super(key: key);
  final V1G3OrderQuoteController _controller = Get.find<V1G3OrderQuoteController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBarWidget(title: "Báo giá đơn hàng",
        leading: IconButton(onPressed: (){
          _controller.onBack();
        }, icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          )),
        ),
        body: GetBuilder(
          builder: (V1G3OrderQuoteController controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Tiêu tề nhóm công việc
                  const GroupTitle(title: "Dịch vụ thường xuyên đã có giá"),
                  form(context, controller: controller),
                  // Button
                  nextButton(controller: controller)
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget form(BuildContext context, {required V1G3OrderQuoteController controller}){
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
            padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT,
              right: Dimensions.PADDING_SIZE_DEFAULT, 
              top: Dimensions.PADDING_SIZE_SMALL
            ),
        ),

        SearchDropDownButton<BangGiaDonHangResponse>(
            data: controller.priceTable,
            obligatory: true,
            onChanged: (value) => controller.onChangedSubService(value!),
            value: controller.subServices,
            width: DeviceUtils.getScaledSize(context,1),
            label: "Chọn chi tiết dịch vụ theo bảng giá mà bạn cần sử dụng (thật chính xác)",
            hint: "Chọn dịch vụ phù hợp",
            padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_DEFAULT,
              right: Dimensions.PADDING_SIZE_DEFAULT, 
              top: Dimensions.PADDING_SIZE_SMALL
            ),
        ),

        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.priceController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "0",
          hidden: false,
          label: "Đơn giá",
          textInputAction: TextInputAction.next,
          obligatory: true,
          typeInput: TextInputType.number,
          isFormatCurrency: true,
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
          textInputAction: TextInputAction.next,
          obligatory: true,
          isInteger: true,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context,1),
        ),

        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.descController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập mô tả công việc",
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

  Widget nextButton({required V1G3OrderQuoteController controller}){
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