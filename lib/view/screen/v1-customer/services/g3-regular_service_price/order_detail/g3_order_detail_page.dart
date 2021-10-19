import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/bottomsheet/order_bottom_sheet.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/widgets/group_title.dart';
import 'package:template/view/screen/v1-customer/notifications/order_feedback_contractors/components/bill_widget.dart';
import 'package:template/view/screen/v1-customer/services/components/order_content_string_value.dart';
import 'package:template/view/screen/v1-customer/services/g3-regular_service_price/order_detail/g3_order_detail_controller.dart';
import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

class V1G3OrderDetailPage extends GetView<V1G3OrderDetailController> {
  V1G3OrderDetailPage({Key? key}) : super(key: key);
  final V1G3OrderDetailController _controller =
      Get.find<V1G3OrderDetailController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Chi tiết đơn hàng"),
      body: Column(
        children: [
          const GroupTitle(title: "Dịch vụ thường xuyên đã có giá"),

          // Bảng thông tin đơn hàng
<<<<<<< HEAD
          Padding(
              padding: const EdgeInsets.all(
                Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: GetBuilder(
                builder: (V1G3OrderDetailController controller) {
                  return BillWidget(
                      isHasDeposit: false,
                      title: "Chi tiết đơn hàng",
                      orderContents: [
                        OrderContentStringValue(
                          title: controller.donDichVuRequest!.tieuDe!,
                          value:
                              "${CurrencyConverter.currencyConverterVND(double.parse(controller.donDichVuRequest!.soTien!))} đ/công",
                          boldValue: true,
                        ),
                        OrderContentStringValue(
                          title: "Số giờ làm việc/ngày",
                          value:
                              "${controller.donDichVuRequest!.thoiGianLamViec!.length * 4}",
                          boldValue: true,
                        ),
                        OrderContentStringValue(
                          title: "Số lượng",
                          value: controller.donDichVuRequest!.soLuongYeuCau!,
                          boldValue: true,
                        ),
                        OrderContentStringValue(
                          title: "Số ngày làm việc dự kiến",
                          value: controller.donDichVuRequest!.soNgay!,
                          boldValue: true,
                        ),
                        OrderContentStringValue(
                          title: "Giá trị đơn hàng",
                          value:
                              "${CurrencyConverter.currencyConverterVND(double.parse(controller.donDichVuRequest!.soTien!))} VNĐ",
                          boldValue: true,
                        ),
                        OrderContentStringValue(
                          title: "Phí dịch vụ App",
                          value:
                              "${CurrencyConverter.currencyConverterVND(double.parse(controller.donDichVuRequest!.phiDichVu!))} VNĐ",
                          boldValue: true,
                        ),
                        OrderContentStringValue(
                          title: "Khuyến mãi của App",
                          value:
                              "${CurrencyConverter.currencyConverterVND(double.parse(controller.donDichVuRequest!.khuyenMai!))} VNĐ",
                          boldValue: true,
                        ),
                        OrderContentStringValue(
                          title: "Tổng tiền đơn hàng",
                          value:
                              "${CurrencyConverter.currencyConverterVND(double.parse(controller.donDichVuRequest!.tongDon!))} VNĐ",
                          boldValue: true,
                        ),
                      ]);
                },
              )),

=======
           Padding(
            padding: const EdgeInsets.all(
              Dimensions.PADDING_SIZE_DEFAULT,
            ),
            child: GetBuilder(
              builder: (V1G3OrderDetailController controller) {
                return BillWidget(
                  isHasDeposit: false,
                  title: "Chi tiết đơn hàng",
                  orderContents: [
                  OrderContentStringValue(title:controller.donDichVuRequest!.tieuDe! , value:"${CurrencyConverter.currencyConverterVND(double.parse(controller.donDichVuRequest!.soTien!))} đ/công", boldValue: true,),
                  OrderContentStringValue(title:"Số giờ làm việc/ngày" , value:"${controller.donDichVuRequest!.idThoiGianLamViecs!.length * 4}", boldValue: true,),
                  OrderContentStringValue(title:"Số lượng" , value:controller.donDichVuRequest!.soLuongYeuCau!, boldValue: true,),
                  OrderContentStringValue(title:"Số ngày làm việc dự kiến" , value:controller.donDichVuRequest!.soNgay!, boldValue: true,),
                  OrderContentStringValue(title:"Giá trị đơn hàng" , value:"${CurrencyConverter.currencyConverterVND(double.parse(controller.donDichVuRequest!.soTien!))} VNĐ", boldValue: true,),
                  OrderContentStringValue(title:"Phí dịch vụ App" , value:"${CurrencyConverter.currencyConverterVND(double.parse(controller.donDichVuRequest!.phiDichVu!))} VNĐ", boldValue: true,),
                  OrderContentStringValue(title:"Khuyến mãi của App" , value:"${CurrencyConverter.currencyConverterVND(double.parse(controller.donDichVuRequest!.khuyenMai!))} VNĐ", boldValue: true,),
                  OrderContentStringValue(title:"Tổng tiền đơn hàng" , value:"${CurrencyConverter.currencyConverterVND(double.parse(controller.donDichVuRequest!.tongDon!))} VNĐ", boldValue: true,),
                ]);
              },
            )
          ),
          
>>>>>>> 4ca5df4 (create 6)
          // Khoản cách bottomSheet
          const SizedBox(
            height: BOTTOMSHEET + Dimensions.SIZE_LARGE,
          )
        ],
      ),
      bottomSheet: OrderBottomSheet(
        mainAxisAlignment: MainAxisAlignment.center,
        itemValue: double.parse(controller.donDichVuRequest!.tongDon!),
        child: Center(
          child: LongButton(
            color: ColorResources.PRIMARYCOLOR,
            onPressed: () => _controller.onNextPage(),
            title: "Tiếp tục",
          ),
        ),
      ),
    );
  }
}
