import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';

class V1GroupOrderFeedBack5Controller extends GetxController {
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();


  DonDichVuResponse? donDichVu;
  DanhSachBaoGiaDonDichVuResponse? donPhanHoi;
  bool isLoading = true;
  double soTien = 0;
  double phiDichVu = 0;
  double khuyenMai = 0;
  double tongTien = 0;
  double tienCoc = 0;

  //khuyenMai
  double phanTramKhuyenMai = 0;
  //phí dịch vụ
  double phanTramPhiDichVu = 0;

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
            soTien = double.parse(donPhanHoi!.tongTien != 'null' ? donPhanHoi!.tongTien! : '0');
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
    donDichVu!.soTien = donPhanHoi!.tongTien;
    donDichVu!.tongDon = donPhanHoi!.tongTien;
    donDichVu!.idNhomDichVu = donDichVu!.idNhomDichVu;
    if(donDichVu!.idLoaiCongViec != null){
      donDichVu!.idLoaiCongViec = donDichVu!.idLoaiCongViec;
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
          print("V1GroupOrderFeedBack5Controller onFeebacked: $onError");
        });
  }
}
