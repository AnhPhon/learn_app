import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V4NotificationController extends GetxController
    with SingleGetTickerProviderMixin {
  ThongBaoResponse? thongBaoList;

  //Thông báo Provider
  ThongBaoProvider thongBaoProvider = GetIt.I.get<ThongBaoProvider>();

  //Khai báo model thông báo
  List<ThongBaoResponse> thongbaoModelList = [];

  // khai báo is loading
  bool isLoading = true;

  // refresh controller for load more refresh
  RefreshController refreshController = RefreshController(initialRefresh: true);

  // page for for load more refresh
  int pageMax = 1;
  int limitMax = 5;

  String userId = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotification(isRefresh: true);
    sl.get<SharedPreferenceHelper>().userId.then((val) {
      userId = val.toString();
    });
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  ///
  /// Load danh sách thông báo
  ///
  void getNotification({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      thongbaoModelList.clear();
    } else {
      //is load more
      pageMax++;
    }
    thongBaoProvider.paginate(
        page: pageMax,
        limit: limitMax,
        filter: '&doiTuong=3&sortBy=created_at:desc',
        onSuccess: (value) {
          //check isEmpty
          if (value.isEmpty) {
            refreshController.loadNoData();
          } else {
            //is Refresh
            if (isRefresh) {
              thongbaoModelList = value;
              refreshController.refreshCompleted();
            } else {
              //is load more
              thongbaoModelList = thongbaoModelList.toList() + value;
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
  ///on refresh
  ///
  Future onRefresh() async {
    refreshController.resetNoData();
    getNotification(isRefresh: true);
  }

  ///
  ///on loading
  ///
  Future onLoading() async {
    getNotification(isRefresh: false);
  }

  ///
  ///format date time
  ///
  String getFormattedDate(String date) {
    final localDate = DateTime.parse(date).toLocal();
    final inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    final inputDate = inputFormat.parse(localDate.toString());
    final outputFormat = DateFormat('HH:mm dd/MM/yyyy');
    final outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  ///
  ///go to  detail notifications page
  ///
  void onClickDetailNotification({required int index}) {
    Get.toNamed(
        "${AppRoutes.V4_DETAIL_NOTIFICATION}?id=${thongbaoModelList[index].id}");
  }
}
