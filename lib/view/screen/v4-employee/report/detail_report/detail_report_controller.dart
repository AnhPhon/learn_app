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

class V4DetailReportController extends GetxController {
  GetIt sl = GetIt.instance;

  BaoCaoNhanVienProvider baoCaoNhanVienProvider =
      GetIt.I.get<BaoCaoNhanVienProvider>();
  List<BaoCaoNhanVienResponse> detailReportModel = [];
  BaoCaoNhanVienRequest detailReportRequest = BaoCaoNhanVienRequest();
  BaoCaoNhanVienResponse? detailReportResponse;

  // Dự án của nhân viên
  DuAnNhanVienProvider duAnNhanVienProvider =
      GetIt.I.get<DuAnNhanVienProvider>();
  List<DuAnNhanVienResponse> duAnNhanVienList = [];
  DuAnNhanVienResponse? duAnNhanVien;
  // hintText
  String hintTextDuAnNhanVien = '';

  // page for for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  // khai báo is loading
  bool isLoading = true;
  // idUser
  String idUser = '';
  // idReport
  String? idReport;

  //khai báo TextEditingController
  TextEditingController contentDetailReport = TextEditingController();
  TextEditingController timeDetailReport = TextEditingController();

  ///
  /// lấy thông tin ban đầu
  ///
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //get agument
    // if (Get.arguments != null) {
    //   detailReportResponse = Get.arguments as BaoCaoNhanVienResponse;
    // }
    final dynamic arguments = Get.arguments;
    if (arguments != null && arguments['idReport'] != null) {
      idReport = arguments!['idReport'].toString();
      print('V4DetailReportController onInit $idReport');

      // baoCaoNhanVienProvider.find(
      //   id: idReport.toString(),
      //   onSuccess: (data) {
      //     detailReportResponse = data;
      //     update();
      //   },
      //   onError: (error) {
      //     print('V4DetailReportController onInit onError $error');
      //   },
      // );
    }
    getidUser();
    getThongTinBaoCao();
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
  ///mapping address
  ///
  Future<void> mappingAddress() async {
    //get user id
    idUser = (await sl.get<SharedPreferenceHelper>().userId)!;
    if (detailReportResponse != null) {
      getBaoCaoNhanVien(isFisrt: true);
    } else {
      getBaoCaoNhanVien();
    }
  }

  ///
  ///Thay đổi dự án nhân viên
  ///
  void onChangedDuAnNhanVien(DuAnNhanVienResponse? value) {
    duAnNhanVien = value;
    update();
  }

  ///
  ///Lấy dự án của nhân viên
  ///
  ///
  void getBaoCaoNhanVien({bool? isFisrt = false}) {
    duAnNhanVienProvider.all(
      onSuccess: (data) {
        duAnNhanVienList = data;
        if (detailReportResponse != null && isFisrt == true) {
          duAnNhanVien = duAnNhanVienList[duAnNhanVienList.indexWhere(
              (element) =>
                  element.id == detailReportResponse!.idDuAnNhanVien!.id)];
        }
        update();
      },
      onError: (error) {
        print("V4DetailReportController getDuAnNhanVien onError $error");
      },
    );
  }

  ///
  ///Get thông tin báo cáo
  ///
  void getThongTinBaoCao() {
    baoCaoNhanVienProvider.find(
      id: idReport.toString(),
      onSuccess: (value) {
        detailReportResponse = value;
        //ngày
        timeDetailReport = TextEditingController(
          text: DateConverter.formatDateTime(
            value.createdAt.toString(),
          ),
        );
        // nội dung
        contentDetailReport = TextEditingController(text: value.noiDung);
        mappingAddress();
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V4DetailReportController getThongTinBaoCao onError $error");
      },
    );
  }

  ///
  /// Check null value báo cáo
  ///
  bool validate() {
    if (contentDetailReport.text.isEmpty) {
      Alert.error(message: 'Vui lòng nhập nội dung báo cáo hợp lệ!');
      return false;
    }
    if (duAnNhanVien == null) {
      Alert.error(message: 'Vui lòng chọn dự án hợp lệ!');
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
      // set data
      detailReportResponse!.idDuAnNhanVien!.createdAt =
          DateConverter.formatDate(
        DateConverter.convertStringddMMyyyyToDate(
          timeDetailReport.text.toString(),
        ),
      );
      baoCaoNhanVienProvider.update(
        data: BaoCaoNhanVienRequest(
          id: detailReportResponse!.id,
          idNhanVien: idUser,
          idDuAnNhanVien: duAnNhanVien!.id,
          noiDung: contentDetailReport.text,
        ),
        onSuccess: (value) {
          Alert.success(message: 'Cập nhật thành công');
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
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalFullDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }
}
