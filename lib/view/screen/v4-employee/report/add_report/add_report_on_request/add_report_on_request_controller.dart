import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ntp/ntp.dart';
import 'package:template/data/model/request/bao_cao_nhan_vien_request.dart';
import 'package:template/data/model/response/bao_cao_nhan_vien_response.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/provider/du_an_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';

class V4AddReportOnRequestController extends GetxController {
  GetIt sl = GetIt.instance;

  // Báo cáo nhân viên Provider
  BaoCaoNhanVienProvider baoCaoNhanVienProvider =
      GetIt.I.get<BaoCaoNhanVienProvider>();

  BaoCaoNhanVienResponse baoCaoNhanVienResponse = BaoCaoNhanVienResponse();
  List<BaoCaoNhanVienResponse> baoCaoNhanVienList = [];

  // Dự án của nhân viên Provider
  DuAnNhanVienProvider duAnNhanVienProvider =
      GetIt.I.get<DuAnNhanVienProvider>();
  List<DuAnNhanVienResponse> duAnNhanVienListAdd = [];
  DuAnNhanVienResponse? duAnNhanVienAdd;

  //khai báo biến isLoading
  bool isLoading = true;

  //Khai báo Thời gian báo cáo phải trùng với thời gian hiện tại
  late TextEditingController timeReportOnRequest = TextEditingController();
  final projectReportOnRequest = TextEditingController();
  final contentReportOnRequest = TextEditingController();

  String idUser = '';

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    final DateTime timeDB = await NTP.now();
    timeReportOnRequest = TextEditingController(
        text: DateConverter.isoStringToLocalDateHMS(timeDB.toString()));

    //GetIdUser
    getidUser();

    //getDuAnNhanVien
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
  ///Load dự án của nhân viên
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
      IZIAlert.error(message: 'Vui lòng nhập nội dung báo cáo hợp lệ!');
      return false;
    }
    if (duAnNhanVienAdd == null) {
      IZIAlert.error(message: 'Vui lòng chọn dự án hợp lệ!');
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
          IZIAlert.success(message: 'Báo cáo thành công');
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
