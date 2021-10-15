import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';

import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2WorkDoneController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();

  //Khai báo isLoading
  bool isLoading = true;

  final paymentRequest = TextEditingController();
  final customerReviews = TextEditingController();
  final warrantyContents = TextEditingController();

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
    // TODO: implement onInit
    super.onInit();

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
  ///Click to Detail Work Done Page
  ///
  void onClickToDetailWorkDonePage() {
    Get.toNamed(AppRoutes.V2_DETAIL_WORK_DONE);
  }

  ///
  /// submit
  ///
  void submit() {
    if (_validate()) {
      Get.snackbar("Thông báo", "Gửi thành công");
      Get.back();
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
    return true;
  }
}
