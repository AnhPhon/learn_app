import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1PaymentMethodController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
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

    // tien coc va phi dich vu
    tienCocVaPhiDichVu();
  }

  ///
  /// init tien co và phi dịch vụ
  ///
  void tienCocVaPhiDichVu() {
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      donDichVuProvider.find(
        id: workFlowId!,
        onSuccess: (data) {
          phiDichVu = double.parse(data.phiDichVu!);
          depositMoney = double.parse(data.tienCoc!);

          // program init
          programInit();
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// program init
  ///
  void programInit() {
    sl.get<SharedPreferenceHelper>().giaTriDonHang.then((giaTriDonHang) {
      // payment method subtitle
      paymentMethodSubTitle = [
        [
          '\u2022 Thanh toán trước phí dịch vụ ${PriceConverter.convertPriceNoContext(phiDichVu)} VNĐ và tiền cọc ${PriceConverter.convertPriceNoContext(depositMoney)} VNĐ',
          '\u2022 Tự thanh toán sau cho "Bên cung cấp dịch vụ" ${PriceConverter.convertPriceNoContext(phiDichVu + depositMoney)} VNĐ (đã khấu trừ tiền cọc)',
        ],
        [
          '\u2022 Thanh toán trước ${PriceConverter.convertPriceNoContext(giaTriDonHang!)} VNĐ, FSS sẽ chịu trách nhiệm thanh toán cho bên cung cấp dịch vụ',
          '\u2022 FSS sẽ hoàn tiền chênh lệch nếu có',
        ],
      ];

      // first load
      contentMoney = phiDichVu + depositMoney;
      isLoading = false;
      update();
    });
  }

  ///
  /// set selected payment method
  ///
  void setSelectedPaymentMethod(int? index) {
    if (index == 0) {
      contentMoney = phiDichVu + depositMoney;
    } else {
      contentMoney = giaTriDonHangMoney;
    }
    paymentMethodIndex = index!;
    update();
  }

  ///
  /// to tai khoan
  ///
  Future<void> toTaiKhoan() async {
    await Get.toNamed(
            '${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${contentMoney.toStringAsFixed(0)}&url=${AppRoutes.V1_DASHBOARD}')!
        .then(
      (value) {},
    );
  }
}
