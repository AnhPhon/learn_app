import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1JobManagementController extends GetxController {
  //refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  //DonDichVu
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  List<DonDichVuResponse> donDichVuList = [];

  //title appbar
  String title = "Quản lý công việc";

  //tab
  List titleTabBar = [
    "Việc đang làm",
    "Việc đã làm",
  ];

  //page & limit for load more refresh
  int pageMax = 1;
  int limitMax = 6;

  //user id
  String userId = "";

  //current index
  int currentIndex = 0;

  //CircularProgressIndicator
  bool isLoading = true;
  bool isLoadingList = false;

  @override
  void onInit() {
    super.onInit();
    getUserId().then((value) {
      getDonDichVu(isRefresh: true);
    });
  }

  ///
  ///get user id
  ///
  Future<void> getUserId() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
  }

  ///
  ///get DonDichVu
  ///
  void getDonDichVu({required bool isRefresh}) {
    //isRefresh
    if (isRefresh == true) {
      pageMax = 1;
      donDichVuList.clear();
    } else {
      //is load more
      pageMax++;
    }

    // get don dich vu
    if (currentIndex == 0) {
      getViecDangLam(isRefresh: isRefresh);
    } else {
      getViecDaLam(isRefresh: isRefresh);
    }
  }

  ///
  ///get viecDangLam
  ///
  void getViecDangLam({required bool isRefresh}) {
    donDichVuProvider.paginateViecDangLam(
      page: pageMax,
      limit: limitMax,
      filter: "&idTaiKhoan=$userId&sortBy=updated_at:desc",
      onSuccess: (data) {
        //check is empty
        if (data.isEmpty) {
          //isRefresh
          if (isRefresh == true) {
            refreshController.refreshCompleted();
          } else {
            //is loadMore
            refreshController.loadNoData();
          }
        } else {
          //isRefresh
          if (isRefresh == true) {
            donDichVuList = data;
            refreshController.refreshCompleted();
          } else {
            //is loadMore
            donDichVuList = donDichVuList.toList() + data;
            refreshController.loadComplete();
          }
        }

        isLoading = false;
        isLoadingList = false;
        update();
      },
      onError: (error) {
        print("V1JobManagementController getViecDangLam onError $error");
      },
    );
  }

  ///
  ///get viecDaLam
  ///
  void getViecDaLam({required bool isRefresh}) {
    donDichVuProvider.paginateViecDaLam(
      page: pageMax,
      limit: limitMax,
      filter: "&idTaiKhoan=$userId&sortBy=updated_at:desc",
      onSuccess: (data) {
        //check is empty
        if (data.isEmpty) {
          //isRefresh
          if (isRefresh == true) {
            refreshController.refreshCompleted();
          } else {
            //is loadMore
            refreshController.loadNoData();
          }
        } else {
          //isRefresh
          if (isRefresh == true) {
            donDichVuList = data;
            refreshController.refreshCompleted();
          } else {
            //is loadMore
            donDichVuList = donDichVuList.toList() + data;
            refreshController.loadComplete();
          }
        }

        isLoading = false;
        isLoadingList = false;
        update();
      },
      onError: (error) {
        print("V1JobManagementController getViecDangLam onError $error");
      },
    );
  }

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    if (currentIndex != index) {
      //reset no data
      refreshController.resetNoData();

      //loading
      isLoadingList = true;

      //set index
      currentIndex = index;

      //reload data
      getDonDichVu(isRefresh: true);
      update();
    }
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    //reset noData
    refreshController.resetNoData();

    //getDonDichVu
    getDonDichVu(isRefresh: true);
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    //getDonDichVu
    getDonDichVu(isRefresh: false);
  }

  ///
  /// go to work page
  ///
  void onWorkPageClick({required DonDichVuResponse donDichVuResponse}) {
    //check index tab
    if (currentIndex == 0) {
      Get.toNamed(AppRoutes.V1_WORK_IN_PROGRESS, arguments: donDichVuResponse)!.then((value) {
        //reload data
        if (value == true) {
          getDonDichVu(isRefresh: true);
        }
      });
    } else {
      Get.toNamed(AppRoutes.V1_WORK_DONE, arguments: donDichVuResponse);
    }
  }

  ///
  /// format date
  ///
  String getDeadline({required String start, required String end}) {
    final DateTime dateStart = DateConverter.stringToLocalDate(start);

    final DateTime dateEnd = DateConverter.stringToLocalDate(end);

    final diff = dateEnd.difference(dateStart).inDays;

    return "${diff >= 0 ? (diff + 1) : (diff - 1)} ngày";
  }
}
