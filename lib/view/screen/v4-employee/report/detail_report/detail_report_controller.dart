
import 'package:flutter/material.dart';
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
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';


class V4DetailReportController  extends GetxController {
  GetIt sl = GetIt.instance;
  BaoCaoNhanVienProvider baoCaoNhanVienProvider = GetIt.I.get<BaoCaoNhanVienProvider>();
  List<BaoCaoNhanVienResponse> detailReportModel = [];


  BaoCaoNhanVienRequest detailReportRequest = BaoCaoNhanVienRequest();
  BaoCaoNhanVienResponse? detailReportResponse;

  DuAnNhanVienProvider duAnNhanVienProvider = GetIt.I.get<DuAnNhanVienProvider>();
  // Dự án của nhân viên
  List<DuAnNhanVienResponse> duAnNhanVienList = [];
  DuAnNhanVienResponse? duAnNhanVien;

  String hintTextDuAnNhanVien = '';

  // page for for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  // khai báo is loading
  bool isLoading = true;

  String idUser= '';

  //khai báo TextEditingController
  TextEditingController contentDetailReport = TextEditingController();
  TextEditingController timeDetailReport = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    detailReportResponse =
    (Get.arguments != null) ? Get.arguments as BaoCaoNhanVienResponse : null;
    mappingAddress();
    // getThongTinBaoCao();
  }
  @override
  void onClose() {
    contentDetailReport.dispose();
    super.onClose();
  }

  ///
  ///mapping address
  ///
  Future<void> mappingAddress() async {
    //get user id
    idUser = (await sl.get<SharedPreferenceHelper>().userId)!;
    print("chi tiết dự án$detailReportResponse");

    if (detailReportResponse != null) {
      timeDetailReport = TextEditingController(
        text: DateConverter.formatDateTime(
          detailReportResponse!.createdAt.toString(),
        ),
      );
      getBaoCaoNhanVien(isFisrt: true);
      contentDetailReport.text = detailReportResponse!.noiDung!;
    } else {
      getBaoCaoNhanVien();
    }
  }
  ///
  ///Thay đổi dự án nhân viên
  ///
  void onChangedDuAnNhanVien(DuAnNhanVienResponse? value) {
    this.duAnNhanVien = value;
    update();
  }

  ///
  ///Lấy dự án của nhân viên
  ///
  ///
  void getBaoCaoNhanVien({bool? isFisrt = false}) {
    //get DuAnNhanVien
    duAnNhanVienProvider.all(
      onSuccess: (data) {
        duAnNhanVienList = data;

        if (detailReportResponse != null && isFisrt == true) {
          duAnNhanVien = duAnNhanVienList[duAnNhanVienList.indexWhere(
                  (element) => element.id == detailReportResponse!.idDuAnNhanVien!.id)];
        }
        update();
        print("dự án nhân viên: $duAnNhanVien");
      },
      onError: (error) {
        print("V4DetailReportController getDuAnNhanVien onError $error");
      },
    );
  }
  // void getDuAnNhanVien({bool? isFisrt = false}) {
  //   duAnNhanVienProvider.all(
  //     onSuccess: (value) {
  //       duAnNhanVienList.clear();
  //       if (value.isNotEmpty) {
  //         duAnNhanVienList.addAll(value);
  //       }
  //       isLoading = false;
  //       update();
  //     },
  //     onError: (error) {
  //       print("TermsAndPolicyController getTermsAndPolicy onError $error");
  //       update();
  //     },
  //   );
  // }

  ///
  ///Get thông tin báo cáo
  ///
  void getThongTinBaoCao() {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      //get  Id
      idUser = id!;
      baoCaoNhanVienProvider.find(
        id: idUser,
        onSuccess: (value) {
          detailReportResponse = value;
          //ngày
          timeDetailReport = TextEditingController(
            text: DateConverter.formatDateTime(
              value.createdAt.toString(),
            ),
          );
          //  tên dự án
          // hintTextDuAnNhanVien  = value.idDuAnNhanVien!.tieuDe.toString();
          // duAnNhanVien = value.idDuAnNhanVien;

          // print(duAnNhanVien);
          // print(duAnNhanVienList);
          // nội dung
          contentDetailReport = TextEditingController(text: value.noiDung);
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// Check null value báo cáo
  ///
  bool validate() {
    if (contentDetailReport.text.isEmpty) {
      Get.snackbar(
        "Nội dung báo cáo không hợp lệ!",
        "Vui lòng nhập nội dung báo cáo hợp lệ!",
        duration: const Duration(seconds: 2),
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(
          Icons.error_outline,
        ),
      );
      return false;
    }
    if (duAnNhanVien == null) {
      Get.snackbar(
        "Dự án không hơp lệ!", // title
        "Vui lòng chọn dự án cần cập nhật!", // message
        backgroundColor: ColorResources.ERROR_NOTICE_SNACKBAR,
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 2),
      );
      return false;
    }
    return true;
  }
  ///
  ///Update button
  ///
  void onUpdate(BuildContext context) {
    // print(detailReportResponse.idDuAnNhanVien!.id);
    // print(detailReportResponse.id);
    // print(contentDetailReport.text);
    if(validate()) {
      // set data
      detailReportResponse!.idDuAnNhanVien!.createdAt = DateConverter.formatDate(
        DateConverter.convertStringddMMyyyyToDate(
          timeDetailReport.text.toString(),
        ),
      );
      // duAnNhanVien =detailReportResponse.idDuAnNhanVien;
      // detailReportRequest.idDuAnNhanVien = duAnNhanVien!.id;
      // detailReportResponse.noiDung = contentDetailReport.text;
//     sl.get<SharedPreferenceHelper>().userId.then((userId) {
//       print(duAnNhanVien!.id);
//       print();
      baoCaoNhanVienProvider.update(
        data: BaoCaoNhanVienRequest(

          id: detailReportResponse!.id,
          // idDuAnNhanVien: detailReportResponse.idDuAnNhanVien!.id,
          idDuAnNhanVien: duAnNhanVien!.id,
          noiDung: contentDetailReport.text,
        ),
        onSuccess: (value) {
          print(duAnNhanVien!.id);
          print(contentDetailReport);
          Get.back(result: true);
          //show dialog
          showAnimatedDialog(
            context,
            const MyDialog(
              icon: Icons.check,
              title: "Hoàn tất",
              description: "Cập nhật thông tin thành công",
            ),
            dismissible: false,
            isFlip: true,
          );
          // Get.back();
          // Get.back(result: true);
          // isLoading = true;
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
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
