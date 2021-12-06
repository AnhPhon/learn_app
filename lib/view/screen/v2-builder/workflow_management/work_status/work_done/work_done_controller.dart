import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/request/yeu_cau_bao_hanh_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/data/model/response/yeu_cau_bao_hanh_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/yeu_cau_bao_hanh_provider.dart';

import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class V2WorkInDoneController extends GetxController {
  //Provider
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  YeuCauBaoHanhProvider yeuCauBaoHanhProvider =
      GetIt.I.get<YeuCauBaoHanhProvider>();

  //Khai báo isLoading
  bool isLoading = true;

  //TextEditingController
  final paymentRequest = TextEditingController();
  final customerReviews = TextEditingController();
  final warrantyContents = TextEditingController();

  bool isKhachHangDisable = true;
  bool isBaoHanhDisable = true;

  String title = "Công trình khách hàng 4 sao tại Đà Nẵng";
  String city = "Đà Nẵng";
  String address = "Ngũ Hành Sơn";
  String deadline = "Còn 35 ngày";
  String appTitle = "Việc đã làm";

  DonDichVuResponse? donDichVu;

  String? baoHanh;

  //user id
  String userId = "";

  bool isStatus = true;

  //index rad
  int? radioIndex;

  List<String> noiDungYeuCauBaoHanhList = [];
  List<String> yeuCauImages = [];

  List<YeuCauBaoHanhResponse> yeuCauBaoHanhList = [];
  List<YeuCauBaoHanhResponse> thucHienBaoHanhList = [];

  List<File> images = [];
  List<String> hinhAnhBaoHanhs = [];

  List<TextEditingController> noiDungThucHien = [];
  List<List<String>> hinhAnhThucHien = [];

  PhanHoiDonDichVuRequest phanHoiDonDichVuRequest = PhanHoiDonDichVuRequest();
  PhanHoiDonDichVuResponse phanHoiDonDichVuResponse =
      PhanHoiDonDichVuResponse();

  //isClicked
  bool isClickedRequest = false;
  bool isClickedDone = false;

  @override
  void onInit() {
    super.onInit();

    donDichVu = Get.arguments as DonDichVuResponse;

    getUserId();

    getViecDaLam();
  }

  ///
  ///get userId
  ///
  Future<void> getUserId() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
  }

  ///
  /// load thong tin viec da lam
  ///
  void loadThongTinViecDaLam(DonDichVuResponse donDichVu) {
    // set adress
    address = "Không xác định";
    if (donDichVu.idQuanHuyen != null) {
      address = donDichVu.idQuanHuyen!.ten!;
    }
    // set title
    title = donDichVu.tieuDe.toString();

    // set city
    if (donDichVu.idTinhTp != null) {
      city = donDichVu.idTinhTp!.ten!;
    }

    // set deadline
    deadline = donDichVu.ngayKetThuc!;

    isLoading = false;
    update();
  }

  void getViecDaLam() {
    phanHoiDonDichVuProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&idDonDichVu=${donDichVu!.id}",
      onSuccess: (data) {
        if (data.isNotEmpty) {
          phanHoiDonDichVuResponse = data.first;
          //mapping yKienThoThauViecDaLam
          if (data.first.yKienThoThauViecDaLam != "null") {
            paymentRequest.text = data.first.yKienThoThauViecDaLam!;
          }

          // tình trạng khách hàng thanh toán
          if (data.first.tinhTrangThanhToan != "null") {
            radioIndex =
                int.parse(data.first.tinhTrangThanhToan.toString()) - 1;
          }
          //
          if (data.first.idYeuCauBaoHanhs!.isNotEmpty) {
            phanHoiDonDichVuRequest.idYeuCauBaoHanhs = data
                .first.idYeuCauBaoHanhs!
                .map((e) => e.id.toString())
                .toList();

            yeuCauBaoHanhList.clear();
            thucHienBaoHanhList.clear();
            final List<YeuCauBaoHanhResponse> thucHienList = [];

            for (final item in data.first.idYeuCauBaoHanhs!) {
              yeuCauBaoHanhList.addIf(item.loai == "1", item);
              thucHienList.addIf(item.loai == "2", item);

              if (item.id == data.first.idYeuCauBaoHanhs!.last.id) {
                noiDungThucHien = List.generate(
                    yeuCauBaoHanhList.length, (_) => TextEditingController());
                hinhAnhThucHien =
                    List.generate(yeuCauBaoHanhList.length, (_) => []);
                thucHienBaoHanhList = List.generate(
                    yeuCauBaoHanhList.length, (_) => YeuCauBaoHanhResponse());
                if (thucHienList.isNotEmpty) {
                  for (var i = 0; i < thucHienList.length; i++) {
                    thucHienBaoHanhList[i] = thucHienList[i];
                    noiDungThucHien[i].text = thucHienList[i].noiDung!;
                    if (i == thucHienList.length - 1) {
                      isLoading = false;
                      update();
                    }
                  }
                } else {
                  isLoading = false;
                  update();
                }
              }
            }
          } else {
            isLoading = false;
            update();
          }
        } else {
          isLoading = false;
          update();
        }
      },
      onError: (error) {
        print("TermsAndPolicyController getViecDaLam onError $error");
      },
    );
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
    if (isClickedRequest) {
      return;
    } else {
      if (paymentRequest.text.isEmpty) {
        IZIAlert.error(message: "Vui lòng nhập số tiền yêu cầu thanh toán");
      } else {
        isClickedRequest = true;
        phanHoiDonDichVuProvider.update(
          data: PhanHoiDonDichVuRequest(
            id: phanHoiDonDichVuResponse.id,
            idTaiKhoan: userId,
            idDonDichVu: donDichVu!.id,
            yKienThoThauViecDaLam: paymentRequest.text,
          ),
          onSuccess: (data) {
            IZIAlert.success(message: "Gửi yêu cầu thanh toán thành công");
            getViecDaLam();
          },
          onError: (error) {
            print(
              "TermsAndPolicyController getTermsAndPolicy onError $error",
            );
          },
        );
      }
    }
  }

  ///
  /// customer review submit
  ///
  void onCustomerReviewSubmit() {
    // number connect
    taiKhoanProvider.find(
      id: userId,
      onSuccess: (user) {
        btnContact(url: "tel:${user.soDienThoai!}");
      },
      onError: (error) {
        print(
          "TermsAndPolicyController getTermsAndPolicy onError $error",
        );
      },
    );
  }

  ///
  ///thuc hien bao hanh
  ///
  void onThucHienBaoHanhClick({required int index}) {
    if (isClickedDone) {
      return;
    } else {
      if (noiDungThucHien[index].text.isEmpty) {
        IZIAlert.error(
            message: "Vui lòng nhập nội dung báo cáo thực hiện bảo hành");
      } else {
        isClickedDone = true;
        yeuCauBaoHanhProvider.add(
          data: YeuCauBaoHanhRequest(
            noiDung: noiDungThucHien[index].text,
            hinhAnhs: thucHienBaoHanhList[index].hinhAnhs,
            loai: "2",
          ),
          onSuccess: (data) {
            phanHoiDonDichVuRequest.id = phanHoiDonDichVuResponse.id;
            phanHoiDonDichVuRequest.idYeuCauBaoHanhs!.add(data.id!);
            print(phanHoiDonDichVuRequest.toJson());
            phanHoiDonDichVuProvider.update(
              data: phanHoiDonDichVuRequest,
              onSuccess: (value) {
                IZIAlert.success(message: "Báo cáo thực hiện bảo hành thành công");
                getViecDaLam();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController onThucHienBaoHanhClick onError $error");
              },
            );
          },
          onError: (error) {
            print(
                "TermsAndPolicyController onThucHienBaoHanhClick onError $error");
          },
        );
      }
    }
  }

  ///
  ///pick image
  ///
  Future pickImages({required int index}) async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      print('Count images select ${files.length}');
      //convert file to url
      uploadImage(imageFile: files, index: index);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///upload image
  ///
  void uploadImage({required List<File> imageFile, required int index}) {
    imageUpdateProvider.addImages(
      files: imageFile,
      onSuccess: (value) {
        EasyLoading.dismiss();
        if (value.files != null && value.files!.isNotEmpty) {
          thucHienBaoHanhList[index].hinhAnhs = value.files;
        }
        update();
      },
      onError: (error) {
        EasyLoading.dismiss();
        print("V1TaxController uploadImage onError $error");
      },
    );
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
  /// btn contact
  ///
  Future<void> btnContact({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'btnContact Could not launch $url';
    }
  }
}
