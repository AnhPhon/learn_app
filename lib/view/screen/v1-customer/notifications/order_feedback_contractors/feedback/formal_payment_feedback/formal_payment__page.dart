import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/dot_widget.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/feedback/formal_payment_feedback/formal_payment_controller.dart';

class V1FormalPaymentFeedbackPage extends GetView<V1FormalPaymentFeedbackController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Hình thức thanh toán"),
      body: GetBuilder(
        builder: (V1FormalPaymentFeedbackController controller) {
          return Column(
            children: [
              const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT,),

              formalPaymentItem(title: "Tự thanh toán cho bên cung cấp dịch vụ",value: 1  ,content:[
                "Thanh toán trước tiền cọc ${CurrencyConverter.currencyConverterVND(controller.soTien*10/100)} VNĐ",
                "Tự thanh toán sau cho Bên cung cấp dịch vụ ${CurrencyConverter.currencyConverterVND(controller.soTien - controller.soTien *10/100)} VNĐ (đã khấu trừ tiền cọc)",
              ] ,groupValue: controller.formalPaymentGroup, controller: controller),
              formalPaymentItem(title: "Ủy quyền",value:0,content:[
                'Thanh toán trước ${CurrencyConverter.currencyConverterVND(controller.soTien)} VNĐ, FSS sẽ chịu trách nhiệm thanh toán cho bên cung cấp dịch vụ.',
                "FSS sẽ hoàn tiền chênh lệch nếu có",
              ] ,groupValue: controller.formalPaymentGroup, controller: controller),
            ],
          );
        },
      ),
      bottomSheet: GetBuilder(
        builder: (V1FormalPaymentFeedbackController controller) {
          return OrderBottomSheet(
            itemValue: controller.formalPaymentGroup == 0 ?  controller.thanhToan : controller.tongTien2,
            title: controller.formalPaymentGroup == 0 ? "Cần thanh toán" : 'Cần đặt cọc',
            child: Center(
              child: LongButton(
                minWidth: DeviceUtils.getScaledWidth(context, 1),
                title: "Tiếp tục",
                color: ColorResources.PRIMARYCOLOR,
                onPressed: controller.onClickContinueButton,
              ),
            ),
          );
        },
      )
    );
  }

  Widget formalPaymentItem({required String title, required int value, required int groupValue, required List<String> content, required V1FormalPaymentFeedbackController controller}){
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_SMALL,
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: BoxShadowWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioButton<int>(title: title, 
            onChanged: (val)=> controller.onChangedFormalPayment(val!), value: value, groupValue: groupValue
            ),
            Padding(
              padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...content.map((e) => Padding(
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_SMALL,
                      bottom: Dimensions.PADDING_SIZE_DEFAULT
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DotWidget(height: 10,width: 10,),
                        Flexible(
                          child: Text(e)
                        )
                      ],
                    ),
                  ),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
