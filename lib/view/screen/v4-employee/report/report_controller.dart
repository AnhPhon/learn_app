// import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/bao_cao_nhan_vien_response.dart';
import 'package:template/provider/bao_cao_nhan_vien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';

import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

class V4ReportController extends GetxController
    with SingleGetTickerProviderMixin {
  BaoCaoNhanVienResponse? baoCaoNhanVienList;

  BaoCaoNhanVienProvider baoCaoNhanVienProvider = GetIt.I.get<BaoCaoNhanVienProvider>();

  //Khai báo model thông báo
  RxList<BaoCaoNhanVienResponse> baocaonhanvienModelList = <BaoCaoNhanVienResponse>[].obs;


  //khai báo isLoading
  bool isLoading = true;

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  int pageMax = 1;
  int currentMax = 5;

//khai báo thời gian bắt đầu báo cáo
  TimeOfDay timeStartReport = const TimeOfDay(hour: 16, minute: 0);

  //khai báo thời gian hết báo cáo
  TimeOfDay timeEndReport = const TimeOfDay(hour: 7, minute: 0);

  // //set model để thiết kế UI danh sách báo cáo
  // List<Map<String, dynamic>>? uiReport;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration.zero, () {
      getReport();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    refreshController.dispose();
  }
  ///
  /// lấy danh sách báo báo
  ///
  void getReport() {
    pageMax = 1;
    currentMax = 5;
    baocaonhanvienModelList.clear();
    update();
    baoCaoNhanVienProvider.paginate(
        page: 1,
        limit: 30,
        filter: '&sortBy=created_at:desc', // cần sửa lại?
        onSuccess: (value) {
          baocaonhanvienModelList.value = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        });
  }
  ///
  /// Set reload List
  ///

  Future<void> onRefresh() async {
    reloadReport();
  }

  ///
  /// Set load more List
  ///
  Future<void> onLoading() async {
    loadMoreReport();
  }
  ///
  ///reload
  ///
  void reloadReport() {
    print('reloadNotifications');
    pageMax = 1;
    currentMax = 5;
    update();
    baoCaoNhanVienProvider.paginate(
        page: pageMax,
        limit: currentMax,
        filter: '&sortBy=created_at:desc',
        onSuccess: (value) {
          baocaonhanvienModelList.value = value;
          refreshController.refreshCompleted();
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        });
  }
  ///
  ///load more
  ///
  void loadMoreReport() {
    pageMax += 1;
    print(pageMax);
    currentMax = currentMax;
    baoCaoNhanVienProvider.paginate(
        page: pageMax,
        limit: currentMax,
        filter: '&loai=1&sortBy=created_at:desc',
        onSuccess: (value) {
          if (value.isNotEmpty) {
            baocaonhanvienModelList.value = value.toList() + value;
            refreshController.loadComplete();
          } else {
            refreshController.loadNoData();
          }

          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        });
  }

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   uiReport = [
  //     {
  //       "title": "Báo cáo công việc theo yêu cầu",
  //       "subtitle": "Phòng A trục A",
  //       "description": "Phòng D,E,F của công trình A",
  //       "address": "Ngũ Hành Sơn",
  //       "daysReport": "06/10/2021",
  //     },
  //     {
  //       "title": "Báo cáo công việc theo yêu cầu",
  //       "subtitle": "Phòng B trục B",
  //       "description": "Phòng D,E,F của công trình B",
  //       "address": "Ngũ Hành Sơn",
  //       "daysReport": "06/10/2021",
  //     },
  //     {
  //       "title": "Báo cáo công việc theo yêu cầu",
  //       "subtitle": "Phòng C trục C",
  //       "description": "Phòng D,E,F của công trình B",
  //       "address": "Ngũ Hành Sơn",
  //       "daysReport": "06/10/2021",
  //     },
  //     {
  //       "title": "Báo cáo công việc theo yêu cầu",
  //       "subtitle": "Phòng C trục C",
  //       "description": "Phòng D,E,F của công trình B",
  //       "address": "Ngũ Hành Sơn",
  //       "daysReport": "06/10/2021",
  //     },
  //   ];
  // }

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
  /// Từ 16h - 7h sáng hôm say sẽ mở báo cáo ngày. Còn lại sẽ hiện Dialog thông báo hết hiệu lực để báo.
  ///
  void managerReportTimer(BuildContext context) {
    // ignore: prefer_final_locals
    double _timeStartReport = timeStartReport.hour.toDouble() +
        (timeStartReport.minute.toDouble() / 60);
    // ignore: prefer_final_locals
    double _timeEndReport =
        timeEndReport.hour.toDouble() + (timeEndReport.minute.toDouble() / 60);

    // ignore: prefer_final_locals
    double _timeNow = TimeOfDay.now().hour.toDouble() +
        (TimeOfDay.now().minute.toDouble() / 60);

    // Từ 16h hôm nay cho đến 7h sáng hôm sau thì mới cho báo cáo hằng ngày
    if (_timeStartReport <= _timeNow) {
      //đi tới báo cáo hằng ngày
      return onClickToDailyReport(context);
    } else if (_timeNow <= _timeEndReport) {
      //đi tới trang báo cáo hằng ngày
      return onClickToDailyReport(context);
    } else {
      //show dialog thông báo hết time báo cáo
      Get.defaultDialog(
        titlePadding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_LARGE,
          horizontal: Dimensions.PADDING_SIZE_LARGE,
        ),
        radius: Dimensions.BORDER_RADIUS_DEFAULT,
        title: "Đã qua thời gian báo cáo có hiệu lực!",
        middleText: "Vui lòng quay lại và thực hiện báo cáo cho ngày hôm nay!",
        cancel:
        // Button back
        _btnBack(),
      );
    }
  }

  ///
  ///Button quay lại khi hiển thị Dialog thông báo hết thời gian báo cáo
  ///
  Widget _btnBack() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: Dimensions.PADDING_SIZE_LARGE * 2,
        width: Dimensions.PADDING_SIZE_LARGE * 6,
        decoration: BoxDecoration(
          color: ColorResources.PRIMARY,
          borderRadius: BorderRadius.circular(
            Dimensions.BORDER_RADIUS_DEFAULT,
          ),
        ),
        child: const Center(
          child: Text(
            "Quay lại",
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              color: ColorResources.WHITE,
            ),
          ),
        ),
      ),
    );
  }
}
