import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/routes/route_path/notification_routers.dart';

class NotificationController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;

  //Khai báo số thông báo
  int soThongBao = 15;

  //Khai báo Smart Refresher controller
  RefreshController refreshController = RefreshController(
    initialLoadStatus: LoadStatus.loading,
  );

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///On Refresher
  ///
  Future<void> onRefresh() async {
    //resetNoData
    refreshController.resetNoData();
    Future.delayed(const Duration(milliseconds: 1000), () {
      refreshController.refreshCompleted();
    });
  }

  ///
  ///onLoading
  ///
  Future<void> onLoading() async {
    //get order isLoading
  }

  ///
  ///Go to Notification Details
  ///
  void goToNotificationDetails() {
    Get.toNamed(NotificationRouters.NOTIFICATION_DETAIL);
  }
}
