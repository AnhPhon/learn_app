import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_luu_tin_tuyen_dung_request.dart';
import 'package:template/data/model/request/danh_sach_ung_tuyen_request.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/repository/danh_sach_luu_tin_tuyen_dung_repository.dart';
import 'package:template/data/repository/danh_sach_ung_tuyen_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/danh_sach_luu_tin_tuyen_dung_provider.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart' as app_constants;
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/cadidate_recruitment_dialog_accept.dart';
import 'package:url_launcher/url_launcher.dart';

class V2PreviewController extends GetxController {
  //provider
  //Provider
  final dangKyViecMoiProvider = GetIt.I.get<DangKyViecMoiProvider>();
  //DanhSachUngTuyen
  final danhSachUngTuyenProvider = GetIt.I.get<DanhSachUngTuyenProvider>();
  DanhSachLuuTinTuyenDungProvider danhSachLuuTinTuyenDungProvider = GetIt.I.get<DanhSachLuuTinTuyenDungProvider>();
  final danhSachUngTuyenRepository = DanhSachUngTuyenRepository();
  DanhSachUngTuyenRequest danhSachUngTuyenRequest = DanhSachUngTuyenRequest();
  DanhSachLuuTinTuyenDungRepository danhSachLuuTinTuyenDungRepository =
      DanhSachLuuTinTuyenDungRepository();

  //Request
  DanhSachLuuTinTuyenDungRequest danhSachLuuTinTuyenDungRequest =
      DanhSachLuuTinTuyenDungRequest();
  

  //Response
  DangKyViecMoiResponse dangKyViecMoiResponse = DangKyViecMoiResponse();

  // Tiêu đề
  final titleController = TextEditingController();
  // địa chỉ
  final addressController = TextEditingController();

  //userId
  String? userId;
  //idTuyenDung
  String? idTuyenDung;

  //isLoading
  bool isLoading = true;

  //tenFile
  String? tenFile;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idTuyenDung = Get.parameters['idTuyenDung'];
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
      getDataUserViecMoi();
    });
  }

  ///
  ///getDataUserViecMoi
  ///
  void getDataUserViecMoi() {
    dangKyViecMoiProvider.paginate(
        page: 1,
        limit: 1,
        filter: '&idTaiKhoan=$userId&idNhomDichVu=${app_constants.NHOM_DICH_VU_7}',
        onSuccess: (value) {
          dangKyViecMoiResponse = value.first;
          //set tên file
          tenFile = dangKyViecMoiResponse.fileHoSoXinViec!.split('/').last;
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V2PreviewController getDataUserViecMoi $error'));
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
  ///onBtnSummit
  ///
  void onBtnSummit() {
    //show dialog
    Get.defaultDialog(
        title: "Xác nhận thông tin",
        content: CandidateRecruitmentDialogAccept(
          textContent: 'Bạn chắc chắn đồng ý nộp hồ sơ ứng tuyển',
        ),
        confirm: ElevatedButton(
            onPressed: () {
              EasyLoading.show(status: 'loading...');
              //check xem có lưu chưa
              danhSachUngTuyenProvider.paginate(
                  page: 1,
                  limit: 10,
                  filter:
                      '&idTuyenDung=$idTuyenDung&idTaiKhoanUngTuyen=$userId',
                  onSuccess: (value) {
                    if (value.isEmpty) {
                      //set data
                      danhSachUngTuyenRequest.idTuyenDung = idTuyenDung;
                      danhSachUngTuyenRequest.idTaiKhoanUngTuyen = userId;
                      danhSachUngTuyenRequest.daXem = '0';
                      //insert db
                      danhSachUngTuyenRepository
                          .add(danhSachUngTuyenRequest)
                          .then((value) => {
                                if (value.response.data != null)
                                  {
                                    EasyLoading.dismiss(),
                                    
                                    // Lưu tin tuyển dụng
                                    onBtnLuuTinTuyenDung(),

                                    IZIAlert.success(
                                        message:
                                            'Nộp hồ sơ ứng tuyển thành công'),
                                    Get.back(),
                                    Get.back(result: true),
                                  }
                                else
                                  {
                                    EasyLoading.dismiss(),
                                    IZIAlert.error(message: 'Vui lòng thử lại')
                                  }
                              });
                    } else {
                      EasyLoading.dismiss();
                      Get.back();
                      IZIAlert.info(
                          message: 'Bạn đã ứng tuyển tin tuyển dụng này rồi');
                    }
                  },
                  onError: (error) =>
                      print('V2CvController onBtnSummit $error'));
            },
            child: const Text("Đồng ý")),
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: ColorResources.GREY,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text("Hủy")));
  }


  /// Lưu tin tuyển dụng
  ///
  ///
  void onBtnLuuTinTuyenDung() {
    EasyLoading.show(status: 'loading...');
    danhSachLuuTinTuyenDungProvider.paginate(
        page: 1,
        limit: 10,
        filter: '&idTaiKhoan=$userId&idTuyenDung=$idTuyenDung',
        onSuccess: (value) {
          EasyLoading.dismiss();
          if (value.isNotEmpty) {
            IZIAlert.info(message: 'Bạn đã lưu tin tuyển dụng này');
          } else {
            //set value request lưu tuyển dụng
            danhSachLuuTinTuyenDungRequest.idTaiKhoan = userId;
            danhSachLuuTinTuyenDungRequest.idTuyenDung = idTuyenDung;

            //insert db
            danhSachLuuTinTuyenDungRepository
                .add(danhSachLuuTinTuyenDungRequest)
                .then((value) => {
                      if (value.response.data != null)
                        {IZIAlert.success(message: 'Lưu tin thành công')}
                      else
                        {IZIAlert.error(message: 'Vui lòng thử lại')}
                    });
          }
        },
        onError: (error) => print(
            'V2ViewRecruitmentNewsController onBtnLuuTinTuyenDung $error'));
  }

}
