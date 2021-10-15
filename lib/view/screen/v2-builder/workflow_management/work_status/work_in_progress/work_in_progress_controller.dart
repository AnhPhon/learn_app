import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2WorkInProgressController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();

  //khai báo isLoading
  bool isLoading = true;

  final rateBuilder = TextEditingController();

  String job = "Thợ ốp lát";
  String title = "Công trình khách hàng 4 sao tại Đà Nẵng";
  String city = "Đà Nẵng";
  String address = "Ngũ Hành Sơn";
  String status = "Còn 35 ngày";
  bool isStatus = true;
  String result = "Chưa nghiệm thu";
  String rate =
      "Delight your users with Flutter's built-in beautiful Material Design & Cupertino widgets. Quickly ship features with a focus on native end-user experiences. Install Flutter today. Null Safe Code. Native Performance. Flexible UI. Fast Development. Open Source.";

  @override
  void onInit() {
    super.onInit();

    // get data don dich vu
    getDonDichVu();

    // trang thai khach hang
    getKhachHangDanhGia();
  }

  ///
  /// get data don dich vu
  ///
  void getDonDichVu() {
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      donDichVuProvider.find(
        id: workFlowId!,
        onSuccess: (model) {
          // set adress
          address = "";
          if (model.idQuanHuyen != null) {
            address += model.idQuanHuyen!.ten!;
          }

          if (model.idQuanHuyen != null) {
            address += model.idQuanHuyen!.ten!;
          }

          // set title
          title = model.tieuDe!;

          // set city
          city = model.idTinhTp!.ten!;

          // set deadline
          status = _getDeadline(model.ngayKetThuc!);

          // set icon and color
          isStatus =
              model.idTrangThaiDonHang!.tieuDe!.toLowerCase() == "dang tuyen";

          // set status
          result = model.idTrangThaiDonHang!.tieuDe!;

          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// get khach hang danh gia
  ///
  void getKhachHangDanhGia() {
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      phanHoiDonDichVuProvider.paginate(
        page: 1,
        limit: 20,
        filter: "&idDonDichVu=$workFlowId",
        onSuccess: (models) {
          if (models.isNotEmpty) {
            rate = models[0].khachHangDanhGia!;
          }
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  ///Click to Detail Work In progress page
  ///
  void onClickToDetialWorkInProgressPage() {
    Get.toNamed(AppRoutes.V2_DETAIL_WORK_IN_PROGRESS);
  }

  ///
  /// submit
  ///
  void submit() {
    if (_validate()) {
      Get.back(result: true);
    }
  }

  ///
  /// format date
  ///
  String _getDeadline(String end) {
    final DateTime current = DateTime.now();
    final DateTime dateEnd = DateTime.parse(end);

    return "${current.difference(dateEnd).inDays} ngày";
  }

  bool _validate() {
    if (rateBuilder.text == '') {
      Get.snackbar("Báo lỗi", "Mục ý kiến thầu không được rỗng");
      return false;
    }
    return true;
  }
}
