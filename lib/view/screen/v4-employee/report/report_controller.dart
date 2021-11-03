import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/request/loai_bao_cao_nhan_vien.dart';
import 'package:template/data/model/response/bao_cao_nhan_vien_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V4ReportController extends GetxController
    with SingleGetTickerProviderMixin {
  GetIt sl = GetIt.instance;
  BaoCaoNhanVienResponse? baoCaoNhanVienList;

  BaoCaoNhanVienProvider baoCaoNhanVienProvider =
      GetIt.I.get<BaoCaoNhanVienProvider>();

  //Khai báo model báo cáo
  List<BaoCaoNhanVienResponse> baoCaoNhanVienModelList = [];

  // Khai báo Danh sách lọc
  List<BaoCaoNhanVienModel> baoCaoNhanVienModel = [
    BaoCaoNhanVienModel(id: "0", tieuDe: "Tất cả"),
    BaoCaoNhanVienModel(id: "1", tieuDe: "Báo cáo yêu cầu"),
    BaoCaoNhanVienModel(id: "2", tieuDe: "Báo cáo tuần"),
  ];

  BaoCaoNhanVienModel? nhanVienModel;

  // khai báo isUser
  String idUser = '';
  //khai báo isLoading
  bool isLoading = true;

  // refresh controller for load more refresh
  RefreshController refreshController = RefreshController(initialRefresh: true);

  // page for for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  String? filterindex;
  //khai báo thời gian bắt đầu báo cáo
  TimeOfDay timeStartReport = const TimeOfDay(hour: 16, minute: 0);

  //khai báo thời gian hết báo cáo
  TimeOfDay timeEndReport = const TimeOfDay(hour: 7, minute: 0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getIdUser();
    getReport(isRefresh: true, value: "1");
  }

  ///
  /// đóng TextEditingController
  ///
  @override
  void onClose() {
    // TODO: implement onClose
    refreshController.dispose();
    super.onClose();
  }

  ///
  /// get id user
  ///
  void getIdUser() {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      idUser = id!;
    });
  }

  ///
  /// lấy danh sách báo báo theo loai
  ///
  void getReport({required bool isRefresh, required String value}) {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      //isRefresh
      if (isRefresh) {
        pageMax = 1;
        baoCaoNhanVienModelList.clear();
      } else {
        //is load more
        pageMax++;
      }
      String filter = "";
      if (value == "0") {
        filter = '&sortBy=created_at:desc';
      } else {
        filter = '&loai=$value&idNhanVien=$id&sortBy=created_at:desc';
      }
      baoCaoNhanVienProvider.paginate(
          page: pageMax,
          limit: limitMax,
          filter: filter,
          onSuccess: (value) {
            //check isEmpty
            if (value.isEmpty) {
              refreshController.loadNoData();
            } else {
              //is Refresh
              if (isRefresh) {
                baoCaoNhanVienModelList = value;
                refreshController.refreshCompleted();
              } else {
                //is load more
                baoCaoNhanVienModelList =
                    baoCaoNhanVienModelList.toList() + value;
                refreshController.loadComplete();
              }
            }
            isLoading = false;
            update();
          },
          onError: (error) {
            print("V4ReportController getReport onError $error");
          });
    });
  }

  // ///
  // ///Click to onchanged filter
  // ///
  // void onChanged ({required  BaoCaoNhanVienModel newValue}) {
  //   nhanVienModel = newValue;
  //   getReport(isRefresh: true, value: "1");
  //   update();
  //
  // }
  ///
  /// Set reload List
  ///
  Future<void> onRefresh() async {
    refreshController.resetNoData();
    getReport(isRefresh: true, value: "1");
  }

  ///
  /// Set load more List
  ///
  Future<void> onLoading() async {
    getReport(isRefresh: false, value: "1");
  }

  // ///
  // ///Click to daily report
  // ///
  // void onClickToDailyReport(BuildContext context) {
  //   Get.toNamed(AppRoutes.V4_ADD_DAILY_REPORT)!.then((value) {
  //     if (value == true) {
  //       Alert.success(
  //           message:
  //           'Thành công');
  //       update();
  //     }
  //   });
  // }
  ///
  ///Click to report on request
  ///
  void onClickToReportOnRequest(BuildContext context) {
    Get.toNamed(AppRoutes.V4_ADD_REPORT_ON_REQUEST)!.then((value) {
      if (value == true) {
        Alert.success(message: 'Thành công');
        update();
        getReport(isRefresh: true, value: "1");
      }
    });
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalFullDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  ///
  ///go to  detail report page
  ///
  void onClickDetailReport(String idUser) {
    sl.get<SharedPreferenceHelper>().saveUserId(idUser);
    Get.arguments(AppRoutes.V4_DETAIL_REPORT)!.then((value) {
      if (value == true) {
        update();
        getReport(isRefresh: true, value: "1");
      }
    });
  }
}
