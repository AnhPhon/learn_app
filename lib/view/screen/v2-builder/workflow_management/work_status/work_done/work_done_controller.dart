import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';

import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V2WorkDoneController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();

  //Khai báo isLoading
  bool isLoading = true;

  final paymentRequest = TextEditingController();
  final customerReviews = TextEditingController();
  final warrantyContents = TextEditingController();

  String title = "Công trình khách hàng 4 sao tại Đà Nẵng";
  String city = "Đà Nẵng";
  String address = "Ngũ Hành Sơn";
  String deadline = "Còn 35 ngày";
  bool isStatus = true;

  bool checkBox1 = false;
  bool checkBox2 = false;
  bool checkBox3 = false;

  List<String> noiDungYeuCauBaoHanhList = [];

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
          deadline = _getDeadline(model.ngayKetThuc!);

          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });

    // lấy nội dung tinh trạng khách hàng
    getNoiDungTinhTrangCuaKhachHang();
  }

  ///
  /// lấy nội dung tình trạng của khách hàng
  ///
  void getNoiDungTinhTrangCuaKhachHang() {
    // get nội dung theo id đơn dịch vụ
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      phanHoiDonDichVuProvider.paginate(
        page: 1,
        limit: 10,
        filter: "&idDonDichVu=$workFlowId&sortBy=created_at:desc",
        onSuccess: (values) {
          for (final value in values) {
            noiDungYeuCauBaoHanhList.add(value.noiDungYeuCauBaoHanh!);
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
  /// on khach hanh thanh toan change
  ///
  void onKhachHangThanhToanChange(int index, {required bool value}) {
    // set check box 1
    if (index == 1) {
      checkBox1 = value;
    }

    // set check box 2
    if (index == 2) {
      checkBox2 = value;
    }

    // set check box 3
    if (index == 3) {
      checkBox3 = value;
    }

    update();
  }

  ///
  ///Click to Detail Work Done Page
  ///
  void onClickToDetailWorkDonePage() {
    Get.toNamed(AppRoutes.V2_DETAIL_WORK_DONE);
  }

  ///
  /// payment submit
  ///
  void onPaymentSubmit() {
    if (_paymentRequestValidate()) {
      Get.snackbar("Thông báo", "Gửi yêu cầu thanh toán thành công");
    }
  }

  ///
  /// customer review submit
  ///
  void onCustomerReviewSubmit() {
    if (_customerReviewValidate()) {
      Get.snackbar("Thông báo", "Gửi ý kiến khách hành thành công");
    }
  }

  ///
  /// warranty content submit
  ///
  void onWarrantyContentSubmit() {
    if (_warrantyContentValidate()) {
      Get.snackbar("Thông báo", "Gửi yêu cầu bảo hành thành công");
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

  ///
  /// payment request validate
  ///
  bool _paymentRequestValidate() {
    // payment request validate
    if (paymentRequest.text.isEmpty) {
      Get.snackbar("Thông báo", "Yêu cầu thanh toán đang rỗng");
      return false;
    }

    return true;
  }

  ///
  /// customer review validate
  ///
  bool _customerReviewValidate() {
    // customer review validate
    if (customerReviews.text.isEmpty) {
      Get.snackbar("Thông báo", "Ý kiến khách hàng đang rỗng");
      return false;
    }

    return true;
  }

  ///
  /// warranty content validate
  ///
  bool _warrantyContentValidate() {
    // warranty content validate
    if (warrantyContents.text.isEmpty) {
      Get.snackbar("Thông báo", "Nội dung bảo hành đang rỗng");
      return false;
    }
    return true;
  }
}
