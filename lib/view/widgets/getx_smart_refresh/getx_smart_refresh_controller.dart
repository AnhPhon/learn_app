import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/di_container.dart';

class GetXSmartRefreshController extends GetxController with SingleGetTickerProviderMixin {
  RefreshController refreshController = RefreshController();
  String keyRefresh = '';
  VoidFutureCallBack? onLoading;
  VoidFutureCallBack? onRefresh;
  bool isRefresh = true;

  @override
  void onInit() {
    super.onInit();

    
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> runRefresh() async {
    isRefresh = true;
    if (onRefresh != null) {
      await onRefresh!();
      refreshController.refreshCompleted();
    }
  }

  Future<void> runLoading() async {
    isRefresh = false;
    if (onLoading != null) {
      await onLoading!();
    }
  }
}
