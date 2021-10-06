import 'package:get/get.dart';

class V1PaymentMethodController extends GetxController {
  String title = "Hình thức thanh toán";

  List<String> paymentMethodTitle = [
    "Tự thanh toán cho bên cung cấp dịch vụ",
    "Ủy quyền",
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

  ///
  /// set selected payment method
  ///
  void setSelectedPaymentMethod(int? index) {
    paymentMethodIndex = index!;
    update();
  }
}
