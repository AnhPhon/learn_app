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

class V4AddDailyReportController extends GetxController {
  GetIt sl = GetIt.instance;

  //Báo cáo nhân viên Provider
  BaoCaoNhanVienProvider baoCaoNhanVienProvider =
      GetIt.I.get<BaoCaoNhanVienProvider>();
  List<BaoCaoNhanVienResponse> baoCaoNhanVienList = [];

  // Dự án của nhân viên
  DuAnNhanVienProvider duAnNhanVienProvider =
      GetIt.I.get<DuAnNhanVienProvider>();
  List<DuAnNhanVienResponse> duAnNhanVienListDaily = [];
  DuAnNhanVienResponse? duAnNhanVienDaily;

  // Future<DateTime> timeReal = NTP.now();
  // DateTime startDate = await NTP.now();

  late TextEditingController timeDailyReport = TextEditingController();
  final projectDailyReport = TextEditingController();
  final contentDailyReport = TextEditingController();
  //khai báo biến isLoading
  bool isLoading = true;

  String idUser = '';

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    final DateTime timeDB = await NTP.now();
    timeDailyReport = TextEditingController(
        text: DateConverter.isoStringToLocalDateHMS(timeDB.toString()));

    //getidUser
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
    contentDailyReport.dispose();
    projectDailyReport.dispose();
    timeDailyReport.dispose();
  }

  ///
  /// get id user
  ///
  void getidUser() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      idUser = value!;
      print(value);
    });
  }

  ///
  ///Thay đổi dự án nhân viên
  ///
  void onChangedDuAnNhanVien(DuAnNhanVienResponse duAnNhanVien) {
    duAnNhanVienDaily = duAnNhanVien;
    update();
  }

  ///
  ///Load dự án của nhân viên
  ///
  void getDuAnNhanVien() {
    duAnNhanVienProvider.all(
      onSuccess: (value) {
        duAnNhanVienListDaily.clear();
        if (value.isNotEmpty) {
          duAnNhanVienListDaily.addAll(value);
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V4AddDailyReportController getDuAnNhanVien onError $error");
        update();
      },
    );
  }

  ///
  /// Check null value báo cáo
  ///
  bool validate() {
    if (contentDailyReport.text.toString().isEmpty) {
      IZIAlert.error(message: 'Vui lòng nhập nội dung báo cáo hợp lệ!');
      return false;
    }
    if (duAnNhanVienDaily == null) {
      IZIAlert.error(message: 'Vui lòng chọn dự án hợp lệ!');
      return false;
    }
    return true;
  }

  ///
  /// Button báo cáo
  ///
  void dailyReport() {
    if (validate()) {
      EasyLoading.show(status: 'loading...');
      baoCaoNhanVienProvider.add(
        data: BaoCaoNhanVienRequest(
          idNhanVien: idUser,
          idDuAnNhanVien: duAnNhanVienDaily!.id,
          loai: "2",
          noiDung: contentDailyReport.text,
        ),
        onSuccess: (value) {
          IZIAlert.success(message: 'Báo cáo thành công');
          EasyLoading.dismiss();
          Get.back(result: true);
        },
        onError: (error) {
          print("V4AddDailyReportController onBaoCao onError $error");
          EasyLoading.dismiss();
        },
      );
    }
  }
}
