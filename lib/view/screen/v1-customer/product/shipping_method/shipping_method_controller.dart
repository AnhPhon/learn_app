import 'package:get/get.dart';

class V1ShippingMethodController extends GetxController {
  String title = "Phương thức giao hàng";

  int shippingMethodIndex = 0;

  List<String> shippingMethodPriceList = [
    "25.000 VND",
    "50.000 VND",
    "20.000 VND",
  ];
  List<String> shippingMethodNameList = [
    "Giao hàng tiết kiệm",
    "Viettel post",
    "Giao hàng trực tiếp",
  ];
  List<String> shippingMethodSubTileList = [
    "Giao hàng tiết kiệm là hình thức vận chuyển hàng hóa bằng đường bộ, thời gian giao hàng sẽ được tính theo ngày",
    "Nhận hàng vào 4 tháng 10 - 12 tháng 10",
    "Nhận hàng vào 4 tháng 10 - 20 tháng 10",
  ];

  String? shippingMethodPrice;

  @override
  void onInit() {
    super.onInit();
    shippingMethodPrice = shippingMethodPriceList[0];
  }

  ///
  /// set selected payment method
  ///
  void setSelectedShippingMethod(int? index) {
    shippingMethodIndex = index!;
    shippingMethodPrice = shippingMethodPriceList[index];
    update();
  }
}
