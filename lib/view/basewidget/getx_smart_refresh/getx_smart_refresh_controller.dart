import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/di_container.dart';
import 'package:template/utils/value_global_notifier.dart';

class GetXSmartRefreshController extends GetxController with SingleGetTickerProviderMixin {
  RefreshController refreshController = RefreshController();
  String keyRefresh = '';
  VoidFutureCallBack? onLoading;
  VoidFutureCallBack? onRefresh;
  final valueGlobalNotifier = sl.get<ValueGlobalNotifier>();
  bool isRefresh = true;

  @override
  void onInit() {
    super.onInit();

    // refreshController.loadNoData();
    valueGlobalNotifier.smartRefreshNoData.listen((p0) {
      print('GetXSmartRefreshController smartRefreshNoData listen $keyRefresh $p0');
      print('GetXSmartRefreshController smartRefreshNoData p0[keyRefresh] ${p0[keyRefresh]} ${p0[keyRefresh] == true}');
      print('GetXSmartRefreshController smartRefreshNoData ${refreshController.isLoading}');
      if (p0[keyRefresh] == true) {
        print('NO data ${p0[keyRefresh]} ${p0[keyRefresh] == true}, set no data loadmore');
        refreshController.loadNoData();
        if (isRefresh == true) {
          print('NO data refresh');
          // refreshController.resetNoData();
        }
        update();
      } else {
        print('HAS data ${p0[keyRefresh]} ${p0[keyRefresh] == false}, set has data loadmore');
        refreshController.loadComplete();
        if (isRefresh == true) {
          refreshController.refreshCompleted();
        }
        update();
      }
    });
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<void> runRefresh() async {
    isRefresh = true;
    valueGlobalNotifier.changeSmartRefreshNoDataStatus(keyRefresh, false);
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
