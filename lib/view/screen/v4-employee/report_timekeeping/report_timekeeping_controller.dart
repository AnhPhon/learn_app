import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import 'package:template/data/model/request/cham_cong_request.dart';
import 'package:template/helper/date_converter.dart';

import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/color_resources.dart';

class V4ReportTimekeepingControllter extends GetxController {
  GetIt sl = GetIt.instance;
  ChamCongProvider chamCongProvider = GetIt.I.get<ChamCongProvider>();

  final reportTimekeeping = TextEditingController(
      text: DateConverter.formatDateTimeHHmm(DateTime.now()));

  final reportContent = TextEditingController();

  //Khai báo location
  String location = "";

  //Khai báo id Chấm công
  String idChamCong = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getidChamCong();
  }

  void getidChamCong() {
    sl.get<SharedPreferenceHelper>().chamcong.then((value) {
      idChamCong = value!;
      print(value);
    });
  }

  ///
  ///Check rỗng
  ///
  bool validate() {
    if (reportContent.text.toString().isEmpty) {
      Alert.error(message: 'Vui lòng nhập nội dung báo cáo!');
      return false;
    }
    return true;
  }

  ///
  ///Get Current Location
  ///
  Future<void> getLocator() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();

    print(position.latitude);
    print(position.longitude);
    print(lastPosition);
    location = "$lastPosition";
    print(location);
    update();
  }

  ///
  /// Button báo cáo
  ///
  Future<void> report() async {
    if (validate()) {
      if (idChamCong.isNotEmpty) {
        final DateTime reportTime =
            DateConverter.convertStringToDatetimeddMMyyyy(
                reportTimekeeping.text);
        chamCongProvider.update(
          data: ChamCongRequest(
            viTri: location,
            idDuAnNhanVien: await sl.get<SharedPreferenceHelper>().duAnNhanVien,
            idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
            id: idChamCong,
            thoiGianKetThuc: reportTime.toString(),
            noiDungBaoCao: reportContent.text,
          ),
          onSuccess: (value) {
            print(reportTime.toString());
            Get.back(result: true);
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
            update();
          },
        );
      } else {
        final DateTime reportTime =
            DateConverter.convertStringToDatetimeddMMyyyy(
                reportTimekeeping.text);
        chamCongProvider.add(
          data: ChamCongRequest(
            viTri: location,
            idDuAnNhanVien: await sl.get<SharedPreferenceHelper>().duAnNhanVien,
            idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
            thoiGianKetThuc: reportTime.toString(),
            noiDungBaoCao: reportContent.text,
          ),
          onSuccess: (value) {
            Get.back(result: true);
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
            update();
          },
        );
      }
    }
  }
}
