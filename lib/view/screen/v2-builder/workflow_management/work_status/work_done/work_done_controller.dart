import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';

import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/snack_bar.dart';

class V2WorkDoneController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();

  //Khai báo isLoading
  bool isLoading = true;

  TextEditingController? paymentRequest;
  TextEditingController? customerReviews;
  TextEditingController? warrantyContents;

  bool isKhachHangDisable = true;
  bool isBaoHanhDisable = true;

  String title = "Công trình khách hàng 4 sao tại Đà Nẵng";
  String city = "Đà Nẵng";
  String address = "Ngũ Hành Sơn";
  String deadline = "Còn 35 ngày";
  String appTitle = "Việc đã làm";

  String? baoHanh;

  bool isStatus = true;

  int radioIndex = 1;

  List<String> noiDungYeuCauBaoHanhList = [];
  List<String> yeuCauImages = [];

  List<File> images = [];

  @override
  void onInit() {
    super.onInit();

    paymentRequest = TextEditingController(text: "");
    customerReviews = TextEditingController(text: "");
    warrantyContents = TextEditingController(text: "");

    // load thông tin viec da lam
    loadThongTinViecDaLam();

    // lấy nội dung tinh trạng khách hàng
    getNoiDungTinhTrangCuaKhachHang();

    // load ý kiến khách hàng
    getYKienKhachHang();

    // lấy bảo hành
    getBaoHanh();
  }

  ///
  /// load thong tin viec da lam
  ///
  void loadThongTinViecDaLam() {
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      donDichVuProvider.find(
        id: workFlowId!,
        onSuccess: (model) {
          // set adress
          address = "";
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
            if (value.noiDungYeuCauBaoHanh.toString() != "null") {
              noiDungYeuCauBaoHanhList.add(value.noiDungYeuCauBaoHanh!);
            }
          }

          if (noiDungYeuCauBaoHanhList.isEmpty) {
            noiDungYeuCauBaoHanhList.add("Không có");
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
  /// load y kien khach hang
  ///
  void getYKienKhachHang() {
    sl
        .get<SharedPreferenceHelper>()
        .phanHoiDonDichVuId
        .then((phanHoiDonDichVuId) {
      phanHoiDonDichVuProvider.find(
        id: phanHoiDonDichVuId!,
        onSuccess: (data) {
          for (final url in data.hinhAnhHuHai!.split(",")) {
            if (url.toString().trim().isNotEmpty) {
              yeuCauImages.add(url.toString().trim());
            }
          }

          if (data.khachHangDanhGia.toString() == "null" ||
              data.khachHangDanhGia!.isEmpty) {
            isKhachHangDisable = true;
            customerReviews = TextEditingController(text: "");
          } else {
            customerReviews =
                TextEditingController(text: data.khachHangDanhGia);
          }
          print(yeuCauImages);
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// load bao hanh
  ///
  void getBaoHanh() {
    // get nội dung theo id đơn dịch vụ
    sl
        .get<SharedPreferenceHelper>()
        .phanHoiDonDichVuId
        .then((phanHoiDonDichVuId) {
      phanHoiDonDichVuProvider.find(
        id: phanHoiDonDichVuId!,
        onSuccess: (data) {
          if (data.kichHoatBaoHanh.toString() == '1') {
            if (data.danhGiaBaoHanh.toString() == 'null' ||
                data.danhGiaBaoHanh.toString().isNotEmpty) {
              // isKhachHangDisable = true;
              warrantyContents = TextEditingController(text: "");
            } else {
              warrantyContents =
                  TextEditingController(text: data.danhGiaBaoHanh);
            }
            isBaoHanhDisable = false;
          } else {
            isBaoHanhDisable = true;
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
  void onKhachHangThanhToanChange(int index) {
    radioIndex = index;
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
      sl.get<SharedPreferenceHelper>().userId.then((userId) {
        sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
          phanHoiDonDichVuProvider.add(
            data: PhanHoiDonDichVuRequest(
              idTaiKhoan: userId,
              idDonDichVu: workFlowId,
              yKienThoThau: paymentRequest!.text,
            ),
            onSuccess: (data) {
              sl.get<SharedPreferenceHelper>().savePhanHoiDonDichVuId(data.id!);
              getYKienKhachHang();
            },
            onError: (error) {
              print(
                "TermsAndPolicyController getTermsAndPolicy onError $error",
              );
            },
          );
        });
      });

      EasyLoading.showSuccess("Gửi yêu cầu thanh toán thành công");
    }
  }

  ///
  /// customer review submit
  ///
  void onCustomerReviewSubmit() {
    if (_customerReviewValidate()) {
      sl.get<SharedPreferenceHelper>().userId.then((userId) {
        sl
            .get<SharedPreferenceHelper>()
            .phanHoiDonDichVuId
            .then((phanHoiDonDichVuId) {
          phanHoiDonDichVuProvider.update(
            data: PhanHoiDonDichVuRequest(
              idTaiKhoan: userId,
              khachHangDanhGia: customerReviews!.text,
              id: phanHoiDonDichVuId,
            ),
            onSuccess: (data) {
              sl.get<SharedPreferenceHelper>().savePhanHoiDonDichVuId(data.id!);
            },
            onError: (error) {
              print(
                "TermsAndPolicyController getTermsAndPolicy onError $error",
              );
            },
          );
        });
      });
      Get.snackbar("Thông báo", "Gửi ý kiến khách hành thành công");
    }
  }

  ///
  /// warranty content submit
  ///
  void onWarrantyContentSubmit() {
    if (_warrantyContentValidate()) {
      sl
          .get<SharedPreferenceHelper>()
          .phanHoiDonDichVuId
          .then((phanHoiDonDichVuId) {
        phanHoiDonDichVuProvider.update(
          data: PhanHoiDonDichVuRequest(
            id: phanHoiDonDichVuId,
            danhGiaBaoHanh: warrantyContents!.text,
          ),
          onSuccess: (data) {
            Get.snackbar("Thông báo", "Gửi yêu cầu bảo hành thành công");
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      });
    }
  }

  ///
  /// Chọn nhiều file (Image)
  ///
  Future<void> pickerMuilFile({required List<File> files}) async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      files.addAll(result.paths.map((path) => File(path!)).toList());
      update();
    } else {
      SnackBarUtils.showSnackBar(
          title: "Vui lòng kiểm tra lại!", message: "Thêm file thất bại");
    }
  }

  ///
  /// Xoá hình ảnh
  ///
  void onDeleteImage({required File file, required List<File> files}) {
    files.removeWhere((element) => element.hashCode == file.hashCode);
    Get.snackbar("Xoá", "Xoá ảnh thành công");
    update();
  }

  ///
  /// format date
  ///
  String _getDeadline(String end) {
    final DateTime current = DateTime.now();
    final DateTime dateEnd = DateTime.parse(end);
    return "${dateEnd.difference(current).inDays} ngày";
  }

  ///
  /// payment request validate
  ///
  bool _paymentRequestValidate() {
    // payment request validate
    if (paymentRequest!.text.isEmpty) {
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
    if (customerReviews!.text.isEmpty) {
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
    if (warrantyContents!.text.isEmpty) {
      Get.snackbar("Thông báo", "Nội dung bảo hành đang rỗng");
      return false;
    }
    return true;
  }
}
