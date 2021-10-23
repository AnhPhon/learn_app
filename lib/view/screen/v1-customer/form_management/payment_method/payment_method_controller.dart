import 'package:get/get.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1PaymentMethodController extends GetxController {
  String title = "Hình thức thanh toán";

  double depositMoney = 1000000;
  double phiDichVu = 50000;
  double khuyenMaiCuaApp = 0;
  double giaTriDonHangMoney = 0;

  List<String>? paymentMethodTitle;

  List<List<String>>? paymentMethodSubTitle;

  int paymentMethodIndex = 0;

  double contentMoney = 0;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    // payment method title
    paymentMethodTitle = [
      "Tự thanh toán cho bên cung cấp dịch vụ",
      "Ủy quyền",
    ];

    // program init
    programInit();
  }

  ///
  /// program init
  ///
  void programInit() {
    sl.get<SharedPreferenceHelper>().giaTriDonHang.then((giaTriDonHang) {
      giaTriDonHangMoney = giaTriDonHang!;
      contentMoney = giaTriDonHangMoney - phiDichVu;

      // payment method subtitle
      paymentMethodSubTitle = [
        [
          '\u2022 Thanh toán trước phí dịch vụ ${PriceConverter.convertPriceNoContext(phiDichVu)} VNĐ và tiền cọc ${PriceConverter.convertPriceNoContext(depositMoney)} VNĐ',
          '\u2022 Tự thanh toán sau cho "Bên cung cấp dịch vụ" ${PriceConverter.convertPriceNoContext(giaTriDonHangMoney - phiDichVu + khuyenMaiCuaApp - depositMoney)} VNĐ (đã khấu trừ tiền cọc)',
        ],
        [
          '\u2022 Thanh toán trước ${PriceConverter.convertPriceNoContext(giaTriDonHang)} VNĐ, FSS sẽ chịu trách nhiệm thanh toán cho bên cung cấp dịch vụ',
          '\u2022 FSS sẽ hoàn tiền chênh lệch nếu có',
        ],
      ];

      // first load
      contentMoney =
          giaTriDonHangMoney - phiDichVu + khuyenMaiCuaApp - depositMoney;
      isLoading = false;
      update();
    });
  }

  ///
  /// get tong don hang
  ///
  double getTongDonHang() {
    return giaTriDonHangMoney + phiDichVu - khuyenMaiCuaApp;
  }

  ///
  /// get tong don hang
  ///
  double getTongDonHangTienCoc() {
    return giaTriDonHangMoney + phiDichVu - khuyenMaiCuaApp - depositMoney;
  }

  ///
  /// set selected payment method
  ///
  void setSelectedPaymentMethod(int? index) {
    if (index == 0) {
      contentMoney =
          giaTriDonHangMoney - phiDichVu + khuyenMaiCuaApp - depositMoney;
    } else {
      contentMoney = giaTriDonHangMoney;
    }
    paymentMethodIndex = index!;
    update();
  }

  ///
  /// to tai khoan
  ///
  void toTaiKhoan() async {
    await Get.toNamed(
            '${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${contentMoney.toStringAsFixed(0)}&url=${AppRoutes.V1_DASHBOARD}')!
        .then(
      (value) {},
    );
  }
}
