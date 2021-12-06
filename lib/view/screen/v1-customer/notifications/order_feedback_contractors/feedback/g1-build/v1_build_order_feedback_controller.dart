import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/provider/chi_tiet_cong_viec_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';

class V1BuildOrderFeedBackController extends GetxController {
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  final ChiTietCongViecProvider chiTietCongViecProvider =
      GetIt.I.get<ChiTietCongViecProvider>();
  final DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  DonDichVuResponse? donDichVu;
  // Khối lương công việc
  DanhSachBaoGiaDonDichVuResponse? donPhanHoi;
  bool isLoading = true;
  double soTien = 0;
  double phiDichVu = 0;
  double khuyenMai = 0;
  double tongTien = 0;
  double tienCoc = 0;

  @override
  void onInit() {
    if (Get.arguments != null) {
      donDichVu = Get.arguments as DonDichVuResponse;
    }

    super.onInit();
    getJobMass();
  }

  ///
  /// Load báo giá công việc or vâtk liệu thuộc đơn dịch vụ
  ///
  void getJobMass() {
    danhSachBaoGiaDonDichVuProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idDonDichVu=${donDichVu!.id!}',
        onSuccess: (donBaoGia) {
          if (donBaoGia.isNotEmpty) {
            donPhanHoi = donBaoGia.where((element) => element.idTaiKhoanBaoGia!.id! == donDichVu!.idTaiKhoanNhanDon!.id!).toList().first;
            soTien = double.parse(donPhanHoi!.giaBao != 'null' ? donPhanHoi!.giaBao! : '0');
            phiDichVu = double.parse(donDichVu!.phiDichVu != 'null' ? donDichVu!.phiDichVu! : '0');
            khuyenMai = double.parse(donDichVu!.khuyenMai != 'null' ? donDichVu!.khuyenMai! : '0');
            tongTien = double.parse(donPhanHoi!.tongTien != 'null' ? donPhanHoi!.tongTien! : '0');
            tienCoc = double.parse(donDichVu!.tienCoc != 'null' ? donDichVu!.tienCoc! : '0');
          }
          isLoading = false;
          update();
        },
        onError: (onError) {
          print("V1BuildOrderFeedBackController getJobMass onError $onError");
        });
  }

  void onClickAgreeButton() {
    // Đến màn hình chọn phương thức thanh toán
    if (donPhanHoi != null) {
      donDichVu!.soTien = donPhanHoi!.giaBao;
      donDichVu!.tongDon = donPhanHoi!.tongTien;
      donDichVu!.idNhomDichVu = donDichVu!.idNhomDichVu;
      if(donDichVu!.idLoaiCongViec != null){
        donDichVu!.idLoaiCongViec = donDichVu!.idLoaiCongViec;
      }
    }
    Get.toNamed(AppRoutes.V1_FORMAL_FEEDBACK_PAYMENT, arguments: donDichVu);
  }

  void showDialog() {
    Get.defaultDialog(
        title: "Bạn có chắc chắn từ chối đơn dịch vụ này ?",
        content: const Text(''),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ColorResources.RED)),
              onPressed: () {
                Get.back();
              },
              child: const Text("Huỷ")),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(ColorResources.GREY)),
              onPressed: () {
                onFeebacked();
                Get.back();
              },
              child: const Text("Đồng ý"))
        ]);
  }

  ///
  /// Đã phản hồi nhưng không đồng ý thanh toán
  ///
  void onFeebacked() {
    EasyLoading.show(status: "Phản hồi đơn dich vụ ...");
    final DonDichVuRequest dichVuRequest = DonDichVuRequest();
    dichVuRequest.id = donDichVu!.id;
    dichVuRequest.idTrangThaiDonDichVu = THAT_BAI;
    dichVuRequest.idTrangThaiThanhToan = CHUA_THANH_TOAN;
    donDichVuProvider.update(
        data: dichVuRequest,
        onSuccess: (onSuccess) {
          EasyLoading.dismiss();
          Get.back();
          IZIAlert.success(message: "Phản hồi thành công");
        },
        onError: (onError) {
          print("V1BuildOrderFeedBackController onFeebacked: $onError");
        });
  }
}
