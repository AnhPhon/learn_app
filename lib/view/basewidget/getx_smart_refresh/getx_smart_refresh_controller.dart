import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GetXSmartRefreshController extends GetxController with SingleGetTickerProviderMixin {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  VoidFutureCallBack? onLoading;
  VoidFutureCallBack? onRefresh;

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
    if (onRefresh != null) {
      await onRefresh!();
      refreshController.refreshCompleted();
    }
  }

  Future<void> runLoading() async {
    if (onLoading != null) {
      await onLoading!();
      refreshController.loadComplete();
    }
  }
}
