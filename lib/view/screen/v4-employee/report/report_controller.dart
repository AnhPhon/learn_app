// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/bao_cao_nhan_vien_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class V4ReportController extends GetxController
    with SingleGetTickerProviderMixin {
  BaoCaoNhanVienResponse? baoCaoNhanVienList;

  BaoCaoNhanVienProvider baoCaoNhanVienProvider = GetIt.I.get<BaoCaoNhanVienProvider>();

  //Khai báo model báo cáo
  List<BaoCaoNhanVienResponse> baocaonhanvienModelList = [];
  // Khai báo danh sách báo cáo
  List<String> baoCao = ['Báo cáo tuần',
    'Báo cáo theo yêu cầu',];

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
    getReport(isRefresh: true);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    refreshController.dispose();
  }
  ///
  /// lấy danh sách báo báo all
  ///
  void getReport({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      baocaonhanvienModelList.clear();
    } else {
      //is load more
      pageMax++;
    }
    baoCaoNhanVienProvider.paginate(
        page: pageMax,
        limit: limitMax,
        filter: '&sortBy=created_at:desc',
        onSuccess: (value) {
          //check isEmpty
          if (value.isEmpty) {
            refreshController.loadNoData();
          } else {
            //is Refresh
            if (isRefresh) {
              baocaonhanvienModelList = value;
              refreshController.refreshCompleted();
            } else {
              //is load more
              baocaonhanvienModelList = baocaonhanvienModelList.toList() + value;
              refreshController.loadComplete();
            }
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        });
  }
  ///
  /// lấy danh sách báo báo theo yêu cầu loai 1
  ///
  void getReportOnRequest({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      baocaonhanvienModelList.clear();
    } else {
      //is load more
      pageMax++;
    }
    baocaonhanvienModelList.clear();
    update();
    baoCaoNhanVienProvider.paginate(
        page: pageMax,
        limit: limitMax,
        filter: '&loai=1&sortBy=created_at:desc',
        onSuccess: (value) {
          //check isEmpty
          if (value.isEmpty) {
            refreshController.loadNoData();
          } else {
            //is Refresh
            if (isRefresh) {
              baocaonhanvienModelList = value;
              refreshController.refreshCompleted();
            } else {
              //is load more
              baocaonhanvienModelList = baocaonhanvienModelList.toList() + value;
              refreshController.loadComplete();
            }
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        });
  }
  ///
  /// lấy danh sách báo báo theo ngày loai 2
  ///
  void getDailyReport({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      baocaonhanvienModelList.clear();
    } else {
      //is load more
      pageMax++;
    }
    baocaonhanvienModelList.clear();
    update();
    baoCaoNhanVienProvider.paginate(
        page: pageMax,
        limit: limitMax,
        filter: '&loai=2&sortBy=created_at:desc',
        onSuccess: (value) {
          //check isEmpty
          if (value.isEmpty) {
            refreshController.loadNoData();
          } else {
            //is Refresh
            if (isRefresh) {
              baocaonhanvienModelList = value;
              refreshController.refreshCompleted();
            } else {
              //is load more
              baocaonhanvienModelList = baocaonhanvienModelList.toList() + value;
              refreshController.loadComplete();
            }
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        });
  }
  ///
  ///Click to onchanged lọc
  ///
  void onChanged(String? i) {
    filterindex = i;
    getDailyReport(isRefresh: true);
    update();
  }

  ///
  /// Set reload List
  ///
  Future<void> onRefresh() async {
    refreshController.resetNoData();
    getReport(isRefresh: true);
  }
  ///
  /// Set load more List
  ///
  Future<void> onLoading() async {
    getReport(isRefresh: false);
  }
  ///
  ///Click to daily report
  ///
  void onClickToDailyReport(BuildContext context) {
    Get.toNamed(AppRoutes.V4_ADD_DAILY_REPORT)!.then((value) {
      if (value == true) {
        showAnimatedDialog(
          context,
          const MyDialog(
            icon: Icons.check,
            title: "Thành công",
            description: "Báo cáo thành công!",
          ),
          dismissible: false,
          isFlip: true,
        );
        update();
      }
    });
  }

  ///
  ///Click to report on request
  ///
  void onClickToReportOnRequest(BuildContext context) {
    Get.toNamed(AppRoutes.V4_ADD_REPORT_ON_REQUEST)!.then((value) {
      if (value == true) {
        showAnimatedDialog(
          context,
          const MyDialog(
            icon: Icons.check,
            title: "Thành công",
            description: "Báo cáo thành công!",
          ),
          dismissible: false,
          isFlip: true,
        );
        update();
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
}
