

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/bill_widget.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/order_detail/g4_order_detail_controller.dart';
import 'package:template/view/screen/v1-customer/services/components/order_content_string_value.dart';

class V1G4OrderDetailPage extends GetView<V1G4OrderDetailController> {
  V1G4OrderDetailPage({Key? key}) : super(key: key);
  final V1G4OrderDetailController _controller = Get.find<V1G4OrderDetailController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Chi tiết đơn hàng"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GroupTitle(title: "Dịch vụ lao động thủ công"),
      
            // Bảng thông tin đơn hàng
             Padding(
              padding: const EdgeInsets.all(
                Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: GetBuilder(
                builder: (V1G4OrderDetailController controller) {
                  return BillWidget(
                    isHasDeposit: false,
                    title: "Chi tiết đơn hàng",
                    orderContents: [
                    OrderContentStringValue(title:"Giá trị đơn hàng" , value:"${CurrencyConverter.currencyConverterVND(controller.soTien)} VNĐ", boldValue: true,),
                    OrderContentStringValue(title:"Phí dịch vụ App" , value:"${CurrencyConverter.currencyConverterVND(controller.phiDichVu)} VNĐ", boldValue: true,),
                    OrderContentStringValue(title:"Khuyến mãi của App" , value:"${CurrencyConverter.currencyConverterVND(controller.khuyenMai)} VNĐ", boldValue: true,),
                    OrderContentStringValue(title:"Tổng tiền đơn hàng" , value:"${CurrencyConverter.currencyConverterVND(controller.tongTien)} VNĐ", boldValue: true,),
                  ]);
                },
              )
            ),
            
            // Khoản cách bottomSheet
            const SizedBox(height: BOTTOMSHEET + Dimensions.SIZE_LARGE,)
          ],
        ),
      ),
      bottomSheet: OrderBottomSheet(
        mainAxisAlignment: MainAxisAlignment.center, 
        itemValue: double.parse(_controller.donDichVuRequest!.tongDon!),
        child: Center(
          child: LongButton(
            color: ColorResources.PRIMARYCOLOR,
            onPressed: ()=> _controller.onNextPage(),
            title: "Tiếp tục",
          ),
        ),
      ),
    );
  }

}