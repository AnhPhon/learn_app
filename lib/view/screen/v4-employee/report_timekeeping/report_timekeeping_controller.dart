import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ntp/ntp.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/data/model/request/bao_cao_nhan_vien_request.dart';

import 'package:template/data/model/request/cham_cong_request.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';

import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/provider/du_an_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';

class V4ReportTimekeepingControllter extends GetxController {
  GetIt sl = GetIt.instance;
  ChamCongProvider chamCongProvider = GetIt.I.get<ChamCongProvider>();
  BaoCaoNhanVienProvider baoCaoNhanVienProvider =
      GetIt.I.get<BaoCaoNhanVienProvider>();

  TextEditingController reportTimekeeping = TextEditingController();

  final reportContent = TextEditingController();

  // Dự án của nhân viên
  DuAnNhanVienProvider duAnNhanVienProvider =
      GetIt.I.get<DuAnNhanVienProvider>();
  List<DuAnNhanVienResponse> duAnNhanVienListDaily = [];
  DuAnNhanVienResponse? duAnNhanVienDaily;

  //khai báo biến isLoading
  bool isLoading = true;

  //Khai báo location
  String location = "";

  //Khai báo id Chấm công
  String idChamCong = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTime();
    getidChamCong();
    getDuAnNhanVien();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    //check permission
    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      getLocator();
    } else if (status == PermissionStatus.denied) {
      await openAppSettings();
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
  }

  ///
  ///Get time Server
  ///
  Future<void> getTime() async {
    final DateTime timeReal = await NTP.now();
    reportTimekeeping =
        TextEditingController(text: DateConverter.formatDateTimeHHmm(timeReal));
    update();
  }

  void getidChamCong() {
    if (idChamCong != "" && idChamCong.isNotEmpty) {
      sl.get<SharedPreferenceHelper>().chamcong.then((value) {
        idChamCong = value!;
        update();
      });
    }
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
          duAnNhanVienDaily = value.first;
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
  ///Check rỗng
  ///
  bool validate() {
    if (reportContent.text.toString().isEmpty) {
      IZIAlert.error(message: 'Vui lòng nhập nội dung báo cáo!');
      return false;
    }
    if (duAnNhanVienDaily == null) {
      IZIAlert.error(message: 'Vui lòng chọn địa điểm làm việc/văn phòng');
      return false;
    }

    return true;
  }

  ///
  ///Get Current Location
  ///
  Future<void> getLocator() async {
    // Nếu getLastKnownPosition trả về null thì sẽ lấy vị trí getCurrentPosition
    final lastPosition = await Geolocator.getLastKnownPosition();
    if (lastPosition != null) {
      location = "$lastPosition";
      update();
    } else {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      location =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      update();
    }

    isLoading = false;
    update();
  }

  ///
  /// Button báo cáo
  ///
  Future<void> report() async {
    if (validate()) {
      //Kiểm tra thêm 1 lần nữa
      //check permission
      final status = await Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        EasyLoading.show(status: "Loading....");

        //Lấy location
        // Nếu getLastKnownPosition trả về null thì sẽ lấy vị trí getCurrentPosition
        final lastPosition = await Geolocator.getLastKnownPosition();
        if (lastPosition != null) {
          location = "$lastPosition";
          update();
        } else {
          final position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          location =
              "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
          update();
        }
        if (idChamCong.isNotEmpty) {
          final DateTime reportTime =
              DateConverter.convertStringToDatetimeddMMyyyy(
                  reportTimekeeping.text);
          chamCongProvider.update(
            data: ChamCongRequest(
              viTri: location.toString(),
              idDuAnNhanVien: duAnNhanVienDaily!.id,
              idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
              id: idChamCong,
              thoiGianKetThuc: reportTime.toString(),
              noiDungBaoCao: reportContent.text,
            ),
            onSuccess: (value) async {
              baoCaoNhanVienProvider.add(
                data: BaoCaoNhanVienRequest(
                  idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
                  idDuAnNhanVien: duAnNhanVienDaily!.id,
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
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );
        } else {
          final DateTime reportTime =
              DateConverter.convertStringToDatetimeddMMyyyy(
                  reportTimekeeping.text);
          chamCongProvider.add(
            data: ChamCongRequest(
              viTri: location,
              idDuAnNhanVien: duAnNhanVienDaily!.id,
              idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
              thoiGianKetThuc: reportTime.toString(),
              noiDungBaoCao: reportContent.text,
            ),
            onSuccess: (value) async {
              baoCaoNhanVienProvider.add(
                data: BaoCaoNhanVienRequest(
                  idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
                  idDuAnNhanVien: duAnNhanVienDaily!.id,
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
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );
        }
        EasyLoading.dismiss();
        update();
      } else if (status == PermissionStatus.denied) {
        await openAppSettings();
      } else if (status == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }
    }
  }
}
