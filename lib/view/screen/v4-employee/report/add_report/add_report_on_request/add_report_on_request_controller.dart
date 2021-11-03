import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/bao_cao_nhan_vien_request.dart';
import 'package:template/data/model/response/bao_cao_nhan_vien_response.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/provider/du_an_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V4AddReportOnRequestController extends GetxController {
  GetIt sl = GetIt.instance;
  // Báo cáo nhân viên
  BaoCaoNhanVienProvider baoCaoNhanVienProvider =
      GetIt.I.get<BaoCaoNhanVienProvider>();
  List<BaoCaoNhanVienResponse> baoCaoNhanVienList = [];
  // Dự án của nhân viên
  DuAnNhanVienProvider duAnNhanVienProvider =
      GetIt.I.get<DuAnNhanVienProvider>();
  List<DuAnNhanVienResponse> duAnNhanVienListAdd = [];
  DuAnNhanVienResponse? duAnNhanVienAdd;

  //khai báo biến isLoading
  bool isLoading = true;

  //Khai báo Thời gian báo cáo phải trùng với thời gian hiện tại
  final timeReportOnRequest = TextEditingController(
      text: DateConverter.estimatedDateOnly(DateTime.now()));
  final projectReportOnRequest = TextEditingController();
  final contentReportOnRequest = TextEditingController();

  String idUser = '';
  String idReport = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getidUser();
    getidReport();
    getDuAnNhanVien();
  }

  ///
  /// đóng các textEditingController
  ///
  @override
  void onClose() {
    // TODO: implement onInit
    super.onClose();
    contentReportOnRequest.dispose();
    projectReportOnRequest.dispose();
    timeReportOnRequest.dispose();
  }

  ///
  /// get id report
  ///
  void getidReport() {
    sl.get<SharedPreferenceHelper>().idReport.then((value) {
      idReport = value!;
    });
  }

  ///
  /// get id user
  ///
  void getidUser() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      idUser = value!;
    });
  }

  ///
  ///Thay đổi dự án nhân viên
  ///
  void onChangedDuAnNhanVien(DuAnNhanVienResponse duAnNhanVien) {
    duAnNhanVienAdd = duAnNhanVien;
    update();
  }

  ///
  ///Lấy dự án của nhân viên
  ///
  void getDuAnNhanVien() {
    duAnNhanVienProvider.all(
      onSuccess: (value) {
        duAnNhanVienListAdd.clear();
        if (value.isNotEmpty) {
          duAnNhanVienListAdd.addAll(value);
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V4AddReportOnRequestController getDuAnNhanVien onError $error");
        update();
      },
    );
  }

  ///
  /// Check null value báo cáo
  ///
  bool validate() {
    if (contentReportOnRequest.text.toString().isEmpty) {
      Alert.error(message: 'Vui lòng nhập nội dung báo cáo hợp lệ!');
      return false;
    }
    if (duAnNhanVienAdd == null) {
      Alert.error(message: 'Vui lòng chọn dự án hợp lệ!');
      return false;
    }
    return true;
  }

  ///
  ///Báo cáo
  ///
  void onBaoCao() {
    if (validate()) {
      EasyLoading.show(status: 'loading...');
      baoCaoNhanVienProvider.add(
        data: BaoCaoNhanVienRequest(
          idNhanVien: idUser,
          idDuAnNhanVien: duAnNhanVienAdd!.id,
          loai: "1",
          noiDung: contentReportOnRequest.text,
        ),
        onSuccess: (value) {
          sl
              .get<SharedPreferenceHelper>()
              .saveIdReport(id: value.id.toString());
          sl
              .get<SharedPreferenceHelper>()
              .saveUserId(value.idNhanVien.toString());
          Alert.success(message: 'Báo cáo thành công');
          EasyLoading.dismiss();
          Get.back(result: true);
        },
        onError: (error) {
          print("V4AddReportOnRequestController onBaoCao onError $error");
          EasyLoading.dismiss();
        },
      );
    }
  }
}
