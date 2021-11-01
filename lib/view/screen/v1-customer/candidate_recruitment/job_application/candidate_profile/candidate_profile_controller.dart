import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_xem_tuyen_dung_request.dart';
import 'package:template/data/model/request/lich_su_vi_tien_request.dart';
import 'package:template/data/model/request/vi_tien_request.dart';
import 'package:template/data/model/response/chuyen_mon_response.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/loai_tot_nghiep_response.dart';
import 'package:template/data/model/response/trinh_do_response.dart';
import 'package:template/data/model/response/vi_tien_response.dart';
import 'package:template/data/repository/danh_sach_xem_tuyen_dung_repository.dart';
import 'package:template/data/repository/lich_su_vi_tien_repository.dart';
import 'package:template/data/repository/vi_tien_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chuyen_mon_provider.dart';
import 'package:template/provider/danh_sach_xem_tuyen_dung_provider.dart';
import 'package:template/provider/loai_tot_nghiep_provider.dart';
import 'package:template/provider/trinh_do_provider.dart';
import 'package:template/provider/vi_tien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:url_launcher/url_launcher.dart';

import 'candidate_dialog_accept.dart';

class V1CandidateProfileController extends GetxController {
  //provider
  final danhSachXemTuyenDungProvider =
      GetIt.I.get<DanhSachXemTuyenDungProvider>();
  final trinhDoProvider = GetIt.I.get<TrinhDoProvider>();
  final chuyenMonProvider = GetIt.I.get<ChuyenMonProvider>();
  final loaiTotNghiepProvider = GetIt.I.get<LoaiTotNghiepProvider>();
  final viTienProvider = GetIt.I.get<ViTienProvider>();

  //Repository
  DanhSachXemTuyenDungRepository danhSachXemTuyenDungRepository =
      DanhSachXemTuyenDungRepository();

  //Request
  DanhSachXemTuyenDungRequest danhSachXemTuyenDungRequest =
      DanhSachXemTuyenDungRequest();

  //Reponse
  ViTienResponse viTienResponse = ViTienResponse();

  //value list model
  List<ChuyenMonResponse> chuyenMonListModel = [];
  List<TrinhDoResponse> trinhDoListModel = [];
  List<LoaiTotNghiepResponse> loaiTotNghiepListModel = [];

  //update ví tiền
  ViTienRepository viTienRepository = ViTienRepository();

  //value ViTienRequest
  ViTienRequest viTienRequest = ViTienRequest();

  //lichSuViTien
  LichSuViTienRequest lichSuViTienRequest = LichSuViTienRequest();
  LichSuViTienRepository lichSuViTienRepository = LichSuViTienRepository();

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

  //tenNganhNgheMongMuon
  String tenNganhNgheMongMuon = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //get data frist
    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        //set userId
        userId = value;
        //get data trình độ
        getDataTrinhDo();
      },
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///getDataTrinhDo
  ///
  void getDataTrinhDo() {
    //get data trình độ
    trinhDoProvider.all(
        onSuccess: (value) {
          trinhDoListModel = value;
          //getDataChuyenMon
          getDataChuyenMon();
        },
        onError: (error) =>
            print('V1CandidateProfileController getDataFristModel $error'));
  }

  ///
  ///getDataChuyenMoc
  ///
  void getDataChuyenMon() {
    //get data chuyên môn
    chuyenMonProvider.all(
        onSuccess: (value) {
          chuyenMonListModel = value;
          print('chuyenMonListModel ${chuyenMonListModel.length}');
          //get data loại tốt nghiệp
          getDataLoaiTotNghiep();
        },
        onError: (error) =>
            print('V1CandidateProfileController getDataFristModel $error'));
  }

  ///
  ///getDataLoaiTotNghiep
  ///
  void getDataLoaiTotNghiep() {
    //get data loại tốt nghiệp
    loaiTotNghiepProvider.all(
        onSuccess: (value) {
          loaiTotNghiepListModel = value;

          //set data đang ký việc mới
          dangKyViecMoiResponse = Get.arguments as DangKyViecMoiResponse;

          for (int i = 0;
              i < dangKyViecMoiResponse.idNganhNgheMongMuons!.length;
              i++) {
            if (i == 0) {
              tenNganhNgheMongMuon = dangKyViecMoiResponse
                  .idNganhNgheMongMuons![i].tieuDe
                  .toString();
            } else {
              tenNganhNgheMongMuon +=
                  ', ${dangKyViecMoiResponse.idNganhNgheMongMuons![i].tieuDe}';
            }
          }

          //check data is view tuyển dụng
          checkDataViewTuyenDung(
              idTaiKhoan: userId.toString(),
              idDangKyViecMoi: dangKyViecMoiResponse.id.toString());
        },
        onError: (error) =>
            print('V1CandidateProfileController getDataFristModel $error'));
  }

  ///
  ///onChangeNameTrinhDo
  ///
  String? onChangeNameTrinhDo(String id) {
    return trinhDoListModel.firstWhere((element) => element.id == id).tieuDe;
  }

  ///
  ///onChangeNameChuyenMon
  ///
  String? onChangeNameChuyenMon(String id) {
    return chuyenMonListModel.firstWhere((element) => element.id == id).tieuDe;
  }

  ///
  ///onChangeNameLoaiTotNghiep
  ///
  String? onChangeNameLoaiTotNghiep(String id) {
    return loaiTotNghiepListModel
        .firstWhere((element) => element.id == id)
        .tieuDe;
  }

  ///
  ///checkDataViewTuyenDung
  ///
  void checkDataViewTuyenDung(
      {required String idTaiKhoan, required String idDangKyViecMoi}) {
    danhSachXemTuyenDungProvider.paginate(
        page: 1,
        limit: 5,
        filter: '&idTaiKhoan=$idTaiKhoan&idDangKyViecMoi=$idDangKyViecMoi',
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
                    //set data lịch sử ví tiền
                    lichSuViTienRequest.idTaiKhoan = userId;
                    lichSuViTienRequest.idViTien = viTienResponse.id;
                    lichSuViTienRequest.noiDung =
                        "Thanh toán xem tin tuyển dụng";
                    lichSuViTienRequest.loaiGiaoDich = "2";
                    lichSuViTienRequest.trangThai = "2";
                    lichSuViTienRequest.soTien = tongTienThanhToan.toString();
                    //insert db lịch sử ví tiền
                    lichSuViTienRepository
                        .add(lichSuViTienRequest)
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
  ///onBtnDownCv
  ///
  Future<void> onBtnDownloadCv({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
