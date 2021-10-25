import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_xem_tuyen_dung_request.dart';
import 'package:template/data/model/request/vi_tien_request.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/vi_tien_response.dart';
import 'package:template/data/repository/danh_sach_xem_tuyen_dung_repository.dart';
import 'package:template/data/repository/vi_tien_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_xem_tuyen_dung_provider.dart';
import 'package:template/provider/vi_tien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/color_resources.dart';

import 'candidate_dialog_accept.dart';

class V1CandidateProfileController extends GetxController {
  //provider
  final danhSachXemTuyenDungProvider =
      GetIt.I.get<DanhSachXemTuyenDungProvider>();

  //Repository
  DanhSachXemTuyenDungRepository danhSachXemTuyenDungRepository =
      DanhSachXemTuyenDungRepository();

  //Request
  DanhSachXemTuyenDungRequest danhSachXemTuyenDungRequest =
      DanhSachXemTuyenDungRequest();

  //Provider
  ViTienProvider viTienProvider = GetIt.I.get<ViTienProvider>();
  //Reponse
  ViTienResponse viTienResponse = ViTienResponse();

  //update ví tiền
  ViTienRepository viTienRepository = ViTienRepository();

  //value ViTienRequest
  ViTienRequest viTienRequest = ViTienRequest();

  // Trạng thái hồ sơ data ảo
  bool statusProfile = false;

  //value model
  DangKyViecMoiResponse dangKyViecMoiResponse = DangKyViecMoiResponse();

  //userId
  String? userId;

  //isView
  bool isView = false;
  bool isShowSoDuError = false;

//isView
  bool isLoading = true;

  //ví tiền
  double soDuTaiKhoan = 0;
  double soDuConLai = 0;
  double tongTienThanhToan = 5000;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //set data đang ký việc mới
    dangKyViecMoiResponse = Get.arguments as DangKyViecMoiResponse;
    print('dangKyViecMoiResponse ${dangKyViecMoiResponse.toJson()}');

    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        //set userId
        userId = value;
        //check data is view tuyển dụng
        checkDataViewTuyenDung(
            idTaiKhoan: userId.toString(),
            idDangKyViecMoi: dangKyViecMoiResponse.id.toString());
      },
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///checkDataViewTuyenDung
  ///
  void checkDataViewTuyenDung(
      {required String idTaiKhoan, required String idDangKyViecMoi}) {
    danhSachXemTuyenDungProvider.paginate(
        page: 1,
        limit: 5,
        filter: '&idTaiKhoan=$idTaiKhoan&idDangKyViecMoi=idDangKyViecMoi',
        onSuccess: (value) {
          if (value.isNotEmpty) {
            isView = true;
          } else {
            isView = false;
          }
          //check ví tiền
          getBalance(userId: idTaiKhoan);
        },
        onError: (e) =>
            print('V1CandidateProfileController checkDataViewTuyenDung $e'));

    update();
  }

  ///
  ///get balance
  ///
  void getBalance({required String userId}) {
    viTienProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&idTaiKhoan=$userId",
      onSuccess: (value) {
        viTienResponse = value.first;
        soDuTaiKhoan = double.parse(viTienResponse.tongTien.toString());

        //check số dư tài khoản có đủ không
        if ((soDuTaiKhoan - tongTienThanhToan) < 0) {
          soDuConLai = 0;
          isShowSoDuError = true;
        } else {
          soDuConLai = soDuTaiKhoan - tongTienThanhToan;
          isShowSoDuError = false;
        }
        //set loading
        isLoading = false;
        update();
      },
      onError: (error) {
        print("PaymentAccountController getBalance onError $error");
      },
    );
  }

  ///
  ///  Hiển thị xác nhận
  ///
  void showDialogAccept() {
    Get.defaultDialog(
      title: "Xác nhận thông tin",
      content: CandidateDialogAccept(
        textContent:
            'Bạn chắc chắn đồng ý xem thông tin tuyển dụng với số tiền',
        price: tongTienThanhToan,
      ),
      confirm: ElevatedButton(
          onPressed: () {
            //set value viTienRequest
            viTienRequest.id = viTienResponse.id;
            viTienRequest.idTaiKhoan = viTienResponse.idTaiKhoan!.id.toString();
            viTienRequest.tongTien = soDuConLai.toString();
            EasyLoading.show(status: 'loading...');

            viTienRepository.update(viTienRequest).then((value) {
              //insert thành công
              if (value.response.data != null) {
                //set danh sách xem tuyển dụng
                danhSachXemTuyenDungRequest.idDangKyViecMoi =
                    dangKyViecMoiResponse.id;
                danhSachXemTuyenDungRequest.idTaiKhoan = userId;
                //insert danh sách xem tuyển dụng
                danhSachXemTuyenDungRepository
                    .add(danhSachXemTuyenDungRequest)
                    .then((value) {
                  if (value.response.data != null) {
                    EasyLoading.dismiss();
                    Get.back();
                    isView = true;
                    update();
                  } else {
                    Alert.error(message: 'Vui lòng thực hiện lại');
                  }
                });
              } else {
                Alert.error(message: 'Vui lòng thực hiện lại');
              }
            });
          },
          child: const Text("Đồng ý")),
      cancel: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ColorResources.GREY,
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text("Hủy")),
    );
  }

  ///
  ///  Hiển thị xác nhận lỗi số dư tài khoản
  ///
  void showDialogAcceptError() {
    Get.defaultDialog(
      title: "Tài khoản không đủ tiền",
      content: CandidateDialogAccept(
        textContent: 'Số dư tài khoản của bạn còn lại không đủ xem thông tin',
        price: soDuTaiKhoan,
      ),
      cancel: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ColorResources.GREY,
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text("Hủy")),
    );
  }
}
