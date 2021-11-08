import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/bao_cao_nhan_vien_request.dart';

import 'package:template/data/model/request/cham_cong_request.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';

import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V4ReportTimekeepingControllter extends GetxController {
  GetIt sl = GetIt.instance;
  ChamCongProvider chamCongProvider = GetIt.I.get<ChamCongProvider>();
  BaoCaoNhanVienProvider baoCaoNhanVienProvider =
      GetIt.I.get<BaoCaoNhanVienProvider>();

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
    getLocator();
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
      EasyLoading.show(status: "Loading....");
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
          onSuccess: (value) async {
            baoCaoNhanVienProvider.add(
              data: BaoCaoNhanVienRequest(
                idNhanVien: await sl.get<SharedPreferenceHelper>().duAnNhanVien,
                idDuAnNhanVien: await sl.get<SharedPreferenceHelper>().userId,
                loai: "2",
                noiDung: reportContent.text,
              ),
              onSuccess: (value) {
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );
            sl.get<SharedPreferenceHelper>().saveIsReport(isReport: true);
            Get.back(result: true);
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
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
          onSuccess: (value) async {
            baoCaoNhanVienProvider.add(
              data: BaoCaoNhanVienRequest(
                idNhanVien: await sl.get<SharedPreferenceHelper>().duAnNhanVien,
                idDuAnNhanVien: await sl.get<SharedPreferenceHelper>().userId,
                loai: "2",
                noiDung: reportContent.text,
              ),
              onSuccess: (value) {
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );
            sl.get<SharedPreferenceHelper>().saveIsReport(isReport: true);
            EasyLoading.dismiss();
            Get.back(result: true);
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      }
    }
  }
}
