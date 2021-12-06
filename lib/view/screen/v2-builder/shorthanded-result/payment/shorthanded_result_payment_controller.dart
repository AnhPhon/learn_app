import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/screen/payment/payment_account/patment_dialog_accept.dart';

class V2ShorthandedPaymentController extends GetxController with SingleGetTickerProviderMixin {
  String title = "Kết quả báo giá";

  bool isLoading = true;
  bool showButton = true;

  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider = GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  DanhSachBaoGiaDonDichVuResponse danhSachBaoGiaDonDichVu = DanhSachBaoGiaDonDichVuResponse.fromJson({});

  @override
  void onInit() {
    super.onInit();

    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['danhSachBaoGiaDonDichVu'] != null) {
      danhSachBaoGiaDonDichVu = arguments!['danhSachBaoGiaDonDichVu'] as DanhSachBaoGiaDonDichVuResponse;

      if (arguments!['showButton'] != null) {
        showButton = arguments!['showButton'] as bool;
      }
    }
  }

  Future<void> khongDongY() async {
    ///
    /// Pick multi images
    ///
    try {
      EasyLoading.show(status: 'Loading...');

      final DonDichVuRequest donDichVuRequest = DonDichVuRequest.fromJson({
        'id': danhSachBaoGiaDonDichVu.idDonDichVu!.id.toString(),
      });
      donDichVuRequest.idTrangThaiDonDichVu = DA_HUY;

      donDichVuProvider.update(
        data: donDichVuRequest,
        onSuccess: (value) {
          EasyLoading.dismiss();
          Alert.success(message: "Từ chối thành công");
          update();
          Get.back(result: {'reload': true});
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  Future<void> dongY() async {
    final DonDichVuRequest donDichVuRequest = DonDichVuRequest.fromJson({
      'id': danhSachBaoGiaDonDichVu.idDonDichVu!.id.toString(),
    });

    donDichVuRequest.idTrangThaiThanhToanKhac = DAT_COT;
    donDichVuRequest.idTrangThaiDonDichVu = TRUNG_THAU;

    final double tongTien = 1.0 * int.parse((danhSachBaoGiaDonDichVu.tongTien != null && danhSachBaoGiaDonDichVu.tongTien!.isNotEmpty) ? danhSachBaoGiaDonDichVu.tongTien.toString() : '0') as double;
    final double tienCoc = 0.05 * int.parse((danhSachBaoGiaDonDichVu.tongTien != null && danhSachBaoGiaDonDichVu.tongTien!.isNotEmpty) ? danhSachBaoGiaDonDichVu.tongTien.toString() : '0');

    Get.toNamed('${AppRoutes.V2_PAYMENT_ORDER}?soTien=$tongTien&tienCoc=$tienCoc&noiDung=Thanh toán đơn dịch vụ')!.then((value) {
      //đã thanh toán
      if (value != null && value['type'] == 1) {
        donDichVuRequest.tienCocKhac = tienCoc.toString();
        donDichVuRequest.khuyenMaiKhac = value['khuyenMai'].toString();
        donDichVuRequest.phiDichVuKhac = value['phiDichVu'].toString();

        donDichVuProvider.update(
          data: donDichVuRequest,
          onSuccess: (value) {
            EasyLoading.dismiss();
            Alert.success(message: "Nhận việc thành công");
            update();
            Get.back(result: {'reload': true});
          },
          onError: (e) {
            EasyLoading.dismiss();
            Alert.error(message: e.toString());
          },
        );
      }
    });

  }

  Future<void> callToNumber() async {}

  // Tinh thoi gian lam viec
  String getTimeLamViec() {
    if (Validate.checkValueIsNullEmpty(danhSachBaoGiaDonDichVu.idDonDichVu) == false && Validate.checkValueIsNullEmpty(danhSachBaoGiaDonDichVu.idDonDichVu!.soNgay) == false) {
      return danhSachBaoGiaDonDichVu.idDonDichVu!.soNgay.toString();
    } else if (Validate.checkValueIsNullEmpty(danhSachBaoGiaDonDichVu.idDonDichVu) == false && Validate.checkValueIsNullEmpty(danhSachBaoGiaDonDichVu.idDonDichVu!.ngayBatDau) == false && Validate.checkValueIsNullEmpty(danhSachBaoGiaDonDichVu.idDonDichVu!.ngayKetThuc) == false) {
      final DateTime dateStart = DateTime.parse(danhSachBaoGiaDonDichVu.idDonDichVu!.ngayBatDau.toString());
      final DateTime dateEnd = DateTime.parse(danhSachBaoGiaDonDichVu.idDonDichVu!.ngayKetThuc.toString());
      return ' ${dateEnd.difference(dateStart).inDays + 1} ngày';
    }
    return ' Không có';
  }

  ///
  ///dialog button back
  ///
  void onCancleClick() {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      contentPadding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      title: "Bạn có chắc muốn từ chối nhận việc",
      content: PaymentDialogAccept(
        textContent: 'Bấm nút Từ chối nhận việc để từ chối nhận việc này, nút Trở lại để đóng popup',
        price: 0,
        isShowPrice: false,
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: const Text("Trở lại"),
      ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ColorResources.GREY,
        ),
        onPressed: () {
          Get.back();
          khongDongY();
        },
        child: const Text("Từ chối nhận việc"),
      ),
    );
  }
}
