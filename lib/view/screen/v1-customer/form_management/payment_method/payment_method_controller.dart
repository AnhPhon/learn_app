import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/provider/cai_dat_chung_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phi_app_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/utils/app_constants.dart';

class V1PaymentMethodController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  CaiDatChungProvider caiDatChungProvider = GetIt.I.get<CaiDatChungProvider>();
  PhiAppProvider phiAppProvider = GetIt.I.get<PhiAppProvider>();
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  String title = "Hình thức thanh toán";

  double soTien = 1000000;
  double phiDichVu = 50000;
  double khuyenMaiCuaApp = 0;
  double giaTriDonHangMoney = 0;
  int paymentMethodIndex = 0;
  double contentMoney = 0;
  double tienCoc = 0;
  bool isLoading = true;

  List<String>? paymentMethodTitle;
  List<List<String>>? paymentMethodSubTitle;

  DonDichVuResponse? donDichVu;
  bool isCoc = true;

  @override
  void onInit() {
    super.onInit();

    // set argument
    donDichVu = Get.arguments[0] as DonDichVuResponse;
    soTien = Get.arguments[1][0] as double;
    tienCoc = (Get.arguments[1][0] as double) * .1;
    phiDichVu = Get.arguments[1][1] as double;
    khuyenMaiCuaApp = Get.arguments[1][2] as double;

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
    // payment method subtitle
    paymentMethodSubTitle = [
      [
        '\u2022 Thanh toán trước phí dịch vụ ${PriceConverter.convertPriceNoContext(phiDichVu)} VNĐ và tiền cọc ${PriceConverter.convertPriceNoContext(soTien * .1)} VNĐ',
        '\u2022 Tự thanh toán sau cho "Bên cung cấp dịch vụ" ${PriceConverter.convertPriceNoContext(soTien)} VNĐ (đã khấu trừ tiền cọc)',
      ],
      [
        '\u2022 Thanh toán trước ${PriceConverter.convertPriceNoContext(soTien)} VNĐ, FSS sẽ chịu trách nhiệm thanh toán cho bên cung cấp dịch vụ',
        '\u2022 FSS sẽ hoàn tiền chênh lệch nếu có',
      ],
    ];

    contentMoney = tienCoc;

    isLoading = false;
  }

  ///
  /// set selected payment method
  ///
  void setSelectedPaymentMethod(int? index) {
    if (index == 0) {
      contentMoney = tienCoc;
      isCoc = true;
    } else {
      contentMoney = soTien;
      isCoc = false;
    }
    paymentMethodIndex = index!;
    update();
  }

  ///
  /// to tai khoan
  ///
  Future<void> toTaiKhoan() async {
    String url =
        '${AppRoutes.ORDER_INFORMATION}?soTien=${soTien.toStringAsFixed(0)}&tienCoc=${tienCoc.toStringAsFixed(0)}&noiDung=Thanh toán đơn dịch vụ';
    if (isCoc == false) {
      url =
          '${AppRoutes.ORDER_INFORMATION}?soTien=${soTien.toStringAsFixed(0)}&noiDung=Thanh toán đơn dịch vụ';
    }
    await Get.toNamed(url)!.then(
      (value) {
        if (value != null) {
          // update trang thai chot gia
          donDichVuProvider.update(
            data: DonDichVuRequest(
              id: donDichVu!.id,
              idTrangThaiDonDichVu: CHOT_GIA,
              idTrangThaiThanhToanKhac: DA_THANH_TOAN,
            ),
            onSuccess: (data) {
              Get.back(result: true);
              Get.back(result: true);
              Get.back(result: true);
              Get.back(result: true);
            },
            onError: (error) {
              print(error);
            },
          );
        }
      },
    );
  }
}
