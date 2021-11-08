import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/lich_su_vi_tien_response.dart';
import 'package:template/data/model/response/vi_tien_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/lich_su_vi_tien_provider.dart';
import 'package:template/provider/vi_tien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V3WalletController extends GetxController {
  //refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  //ViTien
  ViTienProvider viTienProvider = GetIt.I.get<ViTienProvider>();
  ViTienResponse viTienResponse = ViTienResponse();

  //LichSuViTien
  LichSuViTienProvider lichSuViTienProvider =
      GetIt.I.get<LichSuViTienProvider>();
  List<LichSuViTienResponse> lichSuViTienResponse = [];

  //map date time
  Map<String, Map<String, List<LichSuViTienResponse>>> lichSuViTien = {};
  String? year;
  String? month;

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 6;

  //tile appbar
  String title = "Ví của bạn";

  //show or hide
  bool isShow = false;

  //CircularProgressIndicator
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    //get load data
    getWalletInformation();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  ///
  ///get wallet information
  ///
  void getWalletInformation() {
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      viTienProvider.paginate(
        page: 1,
        limit: 5,
        filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
        onSuccess: (value) {
          //check is not empty
          if (value.isNotEmpty) {
            viTienResponse = value.first;
          }

          //get wallet history
          getWalletHistory(isRefresh: true);
          update();
        },
        onError: (error) {
          print("V3WalletController getWalletInformation onError $error");
        },
      );
    });
  }

  ///
  ///get wallet history
  ///
  void getWalletHistory({required bool isRefresh}) {
    if (isRefresh) {
      pageMax = 1;
      lichSuViTienResponse.clear();
      lichSuViTien.clear();
    } else {
      pageMax++;
    }

    //get lichSuViTien
    lichSuViTienProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: "&idViTien=${viTienResponse.id}&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is not empty
        if (value.isEmpty) {
          refreshController.loadNoData();
        } else {
          //isRefresh
          if (isRefresh) {
            lichSuViTienResponse = value;
            refreshController.refreshCompleted();
          } else {
            //is load more
            lichSuViTienResponse = lichSuViTienResponse.toList() + value;
            refreshController.loadComplete();
          }

          //add to month
          for (final item in lichSuViTienResponse) {
            //get month & year
            final valueSplit = item.createdAt!.substring(0, 10).split("-");
            year = valueSplit[0];
            month = valueSplit[1];

            //if key is year have not yet then create
            if (lichSuViTien.containsKey(year) == false) {
              lichSuViTien[year!] = {};
            }
            //if key is month in year have not yet then create
            if (lichSuViTien[year]!.containsKey(month) == false) {
              lichSuViTien[year]![month!] = [];
            }
            //add to list
            lichSuViTien[year]![month]!.add(item);
          }
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3WalletController getWalletHistory onError $error");
      },
    );
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    //reset noData
    refreshController.resetNoData();

    //getWalletHistory
    getWalletHistory(isRefresh: true);
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    //getWalletHistory
    getWalletHistory(isRefresh: false);
  }

  ///
  ///set show/hide
  ///
  void setShow() {
    isShow = !isShow;
    update();
  }

  ///
  ///recharge
  ///
  void onRecharge() {
    Get.toNamed(
        "${AppRoutes.V1_BEFORE_RECHARGE}?balance=${viTienResponse.tongTien}");
  }

  ///
  ///get back
  ///
  void onBtnBackClick() {
    Get.back();
  }
}
