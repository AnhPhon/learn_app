import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/dot_widget.dart';
import 'package:template/view/screen/v1-customer/services/formal_payment/formal_payment_controller.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class V1FormalPaymentPage extends GetView<V1FormalPaymentController> {
  final V1FormalPaymentController _controller =
      Get.find<V1FormalPaymentController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Hình thức thanh toán"),
      body: GetBuilder(
        builder: (V1FormalPaymentController controller) {
          return Column(
            children: [
              const SizedBox(
                height: Dimensions.SPACE_HEIGHT_DEFAULT,
              ),
              formalPaymentItem(
                  title: "Tự thanh toán cho bên cung cấp dịch vụ",
                  value: 1,
                  content: [
                    "Thanh toán trước phí dịch vụ 50.000 VNĐ và tiền cọc 1.000.000 VNĐ",
                    "Tự thanh toán sau cho Bên cung cấp dịch vụ 10.000.000 VNĐ (đã khấu trừ tiền cọc)",
                  ],
                  groupValue: controller.formalPaymentGroup,
                  controller: controller),
              formalPaymentItem(
                  title: "Ủy quyền",
                  value: 0,
                  content: [
                    'Tự thanh toán sau cho "Bên cung cấp dịch vụ" 10.000.000 VNĐ (đã khấu trừ tiền cọc)',
                    "Ủy quyền thì bạn không phải cọc tiền dịch vụ",
                    "FSS sẽ hoàn tiền chênh lệch nếu có"
                  ],
                  groupValue: controller.formalPaymentGroup,
                  controller: controller),
            ],
          );
        },
      ),
      bottomSheet: OrderBottomSheet(
        itemValue: 1111100,
        title: "Cần thanh toán",
        child: Center(
          child: LongButton(
            minWidth: DeviceUtils.getScaledWidth(context, 1),
            title: "Tiếp tục",
            color: ColorResources.PRIMARYCOLOR,
            onPressed: _controller.onClickPayment,
          ),
        ),
      ),
    );
  }

  Widget formalPaymentItem(
      {required String title,
      required int value,
      required int groupValue,
      required List<String> content,
      required V1FormalPaymentController controller}) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: BoxShadowWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioButton<int>(
                title: title,
                onChanged: (val) => controller.onChangedFormalPayment(val!),
                value: value,
                groupValue: groupValue),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...content.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(
                          top: Dimensions.PADDING_SIZE_SMALL,
                          bottom: Dimensions.PADDING_SIZE_DEFAULT),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DotWidget(
                            height: 10,
                            width: 10,
                          ),
                          Flexible(child: Text(e))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
