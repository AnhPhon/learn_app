import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/routes/app_routes.dart';

class V4NotificationController extends GetxController {
  ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();

  //Khai báo model thông báo
  RxList<ThongBaoResponse> thongbaoModelList = <ThongBaoResponse>[].obs;

  // khai báo is loading
  bool isLoading = true;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  int pageMax = 1;
  int currentMax = 5;
  int indexRefresh = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration.zero, () {
      getNotification();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  /// lấy danh sách thông báo
  ///
  void getNotification() {
    thongBaoProvider.paginate(
        page: 1,
        limit: 5,
        filter: '&doiTuong=1&sortBy=create_at:desc',
        onSuccess: (value) {
          thongbaoModelList.value = value;

          isLoading = false;

          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        });
  }

  ///
  /// Set refresh List
  ///

  Future<void> onRefresh() async {
    reloadNotifications();
  }

  ///
  /// Set loading List
  ///
  Future<void> onLoading() async {
    loadMoreNotification();
  }

  ///
  ///reload
  ///
  void reloadNotifications() {
    pageMax = 1;
    currentMax = 5;
    update();
    thongBaoProvider.paginate(
        page: 1,
        limit: 5,
        filter: '&doiTuong=1&sortBy=create_at:desc',
        onSuccess: (value) {
          thongbaoModelList.value = value;

          isLoading = false;

          refreshController.refreshCompleted();

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
  void loadMoreNotification() {
    pageMax += 1;
    currentMax = currentMax;
    thongBaoProvider.paginate(
        page: pageMax,
        limit: currentMax,
        filter: '&doiTuong=1&sortBy=create_at:desc',
        onSuccess: (value) {
          thongbaoModelList.value = value.toList() + value;

          isLoading = false;

          refreshController.loadComplete();

          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        });
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalDateHMS(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  ///
  ///go to  detail notifications page
  ///
  void onClickDetailNotification({required int index}) {
    Get.toNamed(
        "${AppRoutes.V4_DETAIL_NOTIFICATION}?id=${thongbaoModelList[index].id}");
  }
}
