import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3PaymentMethodController extends GetxController {
  String title = "Hình thức thanh toán";

  List<String> paymentMethodTitle = [
    "Tự thanh toán cho bên cung cấp dịch vụ",
    "Ủy quyền",
  ];

  List<List<String>> paymentMethodSubTitleIsBuy = [
    [
      '\u2022 Thanh toán trước phí dịch vụ 7.500 VNĐ',
      '\u2022 Tự thanh toán sau cho "Bên cung cấp dịch vụ" 110.000 VNĐ',
    ],
    [
      '\u2022 Thanh toán trước 11.050.000VNĐ, FSS sẽ chịu trách nhiệm thanh toán cho bên cung cấp dịch vụ',
      '\u2022 FSS sẽ hoàn tiền chênh lệch nếu có',
    ],
  ];

  List<List<String>> paymentMethodSubTitle = [
    [
      '\u2022 Thanh toán trước phí dịch vụ 50.000 VNĐ và tiền cọc 1.000.000 VNĐ',
      '\u2022 Tự thanh toán sau cho "Bên cung cấp dịch vụ" 10.000.000 VNĐ (đã khấu trừ tiền cọc)',
    ],
    [
      '\u2022 Thanh toán trước 11.050.000VNĐ, FSS sẽ chịu trách nhiệm thanh toán cho bên cung cấp dịch vụ',
      '\u2022 FSS sẽ hoàn tiền chênh lệch nếu có',
    ],
  ];

  int paymentMethodIndex = 0;

  bool? isBuy;

  @override
  void onInit() {
    super.onInit();
    isBuy = Get.parameters['isBuy']!.toLowerCase() == 'true';
  }

  ///
  /// set selected payment method
  ///
  void setSelectedPaymentMethod(int? index) {
    paymentMethodIndex = index!;
    update();
  }

  ///
  ///on continue click
  ///
  void onContinueClick() {
    Get.toNamed(AppRoutes.V3_PAYMENT_ACCOUNT);
  }
}
