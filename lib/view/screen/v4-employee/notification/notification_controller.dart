import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/thong_bao_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/thong_bao_provider.dart';
import 'package:template/routes/app_routes.dart';

class V4NotificationController extends GetxController
    with SingleGetTickerProviderMixin {
  ThongBaoResponse? thongBaoList;

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNotification(isRefresh: true);
  }

  ///
  /// lấy danh sách thông báo
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
        filter: '&doiTuong=4&sortBy=created_at:desc',
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
