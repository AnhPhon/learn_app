import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/danh_sach_ung_tuyen_request.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/repository/danh_sach_ung_tuyen_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/cadidate_recruitment_dialog_accept.dart';
import 'package:url_launcher/url_launcher.dart';

class V2PreviewController extends GetxController {
  //DanhSachUngTuyen
  final danhSachUngTuyenProvider = GetIt.I.get<DanhSachUngTuyenProvider>();
  final danhSachUngTuyenRepository = DanhSachUngTuyenRepository();
  DanhSachUngTuyenRequest danhSachUngTuyenRequest = DanhSachUngTuyenRequest();

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idTuyenDung = Get.parameters['idTuyenDung'];
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
      dangKyViecMoiResponse = Get.arguments as DangKyViecMoiResponse;
      isLoading = false;
      update();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
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
                  limit: 5,
                  filter:
                      '&idTuyenDung=$idTuyenDung&idTaiKhoanUngTuyen=$userId',
                  onSuccess: (value) {
                    if (value.isNotEmpty) {
                      //set data
                      danhSachUngTuyenRequest.idTuyenDung = idTuyenDung;
                      danhSachUngTuyenRequest.idTaiKhoanUngTuyen = userId;
                      //insert db
                      danhSachUngTuyenRepository
                          .add(danhSachUngTuyenRequest)
                          .then((value) => {
                                if (value.response.data != null)
                                  {
                                    Alert.success(
                                        message:
                                            'Nộp hồ sơ ứng tuyển thành công'),
                                    Get.back(),
                                    Get.back(result: true),
                                  }
                                else
                                  {
                                    EasyLoading.dismiss(),
                                    Alert.error(message: 'Vui lòng thử lại')
                                  }
                              });
                    } else {
                      EasyLoading.dismiss();
                      Get.back();
                      Alert.info(
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
}
