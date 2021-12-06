import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/request/bao_cao_nhan_vien_request.dart';
import 'package:template/data/model/response/bao_cao_nhan_vien_response.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/provider/du_an_nhan_vien_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';

class V4DetailReportController extends GetxController {
  GetIt sl = GetIt.instance;

  //Báo cáo nhân viên Provider
  BaoCaoNhanVienProvider baoCaoNhanVienProvider =
      GetIt.I.get<BaoCaoNhanVienProvider>();
  List<BaoCaoNhanVienResponse> detailReportModel = [];
  BaoCaoNhanVienRequest detailReportRequest = BaoCaoNhanVienRequest();
  BaoCaoNhanVienResponse detailReportResponse = BaoCaoNhanVienResponse();
  BaoCaoNhanVienResponse baoCaoNhanVienResponse = BaoCaoNhanVienResponse();

  // Dự án của nhân viên Provider
  DuAnNhanVienProvider duAnNhanVienProvider =
      GetIt.I.get<DuAnNhanVienProvider>();
  List<DuAnNhanVienResponse> duAnNhanVienList = [];
  DuAnNhanVienResponse? duAnNhanVien;

  // hintText
  String hintTextDuAnNhanVien = '';

  // page for for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  //value request
  dynamic request;

  // khai báo is loading
  bool isLoading = true;

  // idUser
  String idUser = '';

  // idReport
  String? idReports;

  //khai báo TextEditingController
  TextEditingController contentDetailReport = TextEditingController();
  TextEditingController timeDetailReport = TextEditingController();

  //get agument
  final BaoCaoNhanVienResponse arguments =
      Get.arguments as BaoCaoNhanVienResponse;

  ///
  /// Load thông tin ban đầu
  ///
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getidUser();
    getDetailReport(isFisrt: true);
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
  ///đóng TextEditingController
  ///
  @override
  void onClose() {
    timeDetailReport.dispose();
    contentDetailReport.dispose();
    super.onClose();
  }

  ///
  ///Thay đổi dự án nhân viên
  ///
  void onChangedDuAnNhanVien(DuAnNhanVienResponse? value) {
    duAnNhanVien = value;
    update();
  }

  ///
  ///Get chi tiết từng báo cáo
  ///
  ///
  void getDetailReport({bool? isFisrt = false}) {
    //ngày
    timeDetailReport = TextEditingController(
      text: getFormattedDate(
        arguments.createdAt.toString(),
      ),
    );
    // nội dung
    contentDetailReport = TextEditingController(text: arguments.noiDung);
    duAnNhanVienProvider.all(
      onSuccess: (data) {
        duAnNhanVienList = data;
        if (isFisrt == true) {
          duAnNhanVien = duAnNhanVienList[duAnNhanVienList.indexWhere(
              (element) => element.id == arguments.idDuAnNhanVien!.id)];
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V4DetailReportController getDuAnNhanVien onError $error");
      },
    );
  }

  ///
  /// Check null value báo cáo
  ///
  bool validate() {
    if (contentDetailReport.text.isEmpty) {
      IZIAlert.error(message: 'Vui lòng nhập nội dung báo cáo hợp lệ!');
      return false;
    }
    if (duAnNhanVien == null) {
      IZIAlert.error(message: 'Vui lòng chọn dự án hợp lệ!');
      return false;
    }
    return true;
  }

  ///
  ///Update button
  ///
  void onUpdate(BuildContext context) {
    if (validate()) {
      EasyLoading.show(status: 'loading...');
      baoCaoNhanVienProvider.update(
        data: BaoCaoNhanVienRequest(
          id: arguments.id,
          idNhanVien: arguments.idNhanVien!.id,
          idDuAnNhanVien: duAnNhanVien!.id,
          noiDung: contentDetailReport.text,
        ),
        onSuccess: (value) {
          IZIAlert.success(message: 'Cập nhật thành công');
          EasyLoading.dismiss();
          Get.back(result: true);
          update();
        },
        onError: (error) {
          print("V4DetailReportController onUpdate onError $error");
          EasyLoading.dismiss();
        },
      );
    }
  }

  ///
  ///format date time
  ///
  String getFormattedDate(String date) {
    final localDate = DateTime.parse(date).toLocal();
    final inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    final inputDate = inputFormat.parse(localDate.toString());
    final outputFormat = DateFormat('HH:mm dd/MM/yyyy');
    final outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }
}
