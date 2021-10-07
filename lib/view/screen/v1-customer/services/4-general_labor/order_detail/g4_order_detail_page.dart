

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/bill_widget.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/order_content.dart';
import 'package:template/view/screen/v1-customer/services/4-general_labor/order_detail/g4_order_detail_controller.dart';
import 'package:template/view/screen/v1-customer/services/components/order_content_string_value.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class V1G4OrderDetailPage extends GetView<V1G4OrderDetailController> {
  V1G4OrderDetailPage({Key? key}) : super(key: key);
  final V1G4OrderDetailController _controller = Get.find<V1G4OrderDetailController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Chi tiết đơn hàng"),
      body: Column(
        children: const [
          GroupTitle(title: "Dịch vụ lao động thủ công"),

          // Bảng thông tin đơn hàng
           Padding(
            padding: EdgeInsets.all(
              Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: BillWidget(
              isHasDeposit: false,
              title: "Chi tiết đơn hàng",
              orderContents: [
              OrderContentStringValue(title:"Gội đầu tại nhà" , value:"300.000 đ/công", boldValue: true,),
              OrderContentStringValue(title:"Số giờ làm việc/ngày" , value:"8.000 VNĐ", boldValue: true,),
              OrderContentStringValue(title:"Số lượng" , value:"8 người", boldValue: true,),
              OrderContentStringValue(title:"Số ngày làm việc dự kiến" , value:"10 giờ", boldValue: true,),
              OrderContentStringValue(title:"Giá trị đơn hàng" , value:"300.000 đồng", boldValue: true,),
              OrderContentStringValue(title:"Phí dịch vụ App" , value:"0 đồng", boldValue: true,),
              OrderContentStringValue(title:"Khuyến mãi của App" , value:"5000 đồng", boldValue: true,),
              OrderContentStringValue(title:"Tổng tiền đơn hàng" , value:"11.050.000 VNĐ", boldValue: true,),
            ]),
          ),
          
          // Khoản cách bottomSheet
          SizedBox(height: BOTTOMSHEET,)
        ],
      ),
      bottomSheet: OrderBottomSheet(
        mainAxisAlignment: MainAxisAlignment.center, 
        itemValue: 337500,
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