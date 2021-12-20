import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/routes/route_path/my_order_routes.dart';

class MyOrderController extends GetxController {
  List<RefreshController>? refreshControllerList;
  //page & limit for load more refresh
  int pageMax = 1;
  int limitMax = 10;

  //is Loading
  bool isLoading = true;

  //Current Index
  int currentIndex = 0;

  List<String> tieuDe = [
    "Tất cả",
    "Xác nhận",
    "Đang giao",
    "Đã giao",
  ];
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> tatCa = [
    {"status": 1, "date": "22/07/2021"},
    {"status": 2, "date": "22/07/2021"},
    {"status": 3, "date": "22/07/2021"},
    {"status": 4, "date": "22/07/2021"},
    {"status": 1, "date": "22/07/2021"},
  ];
  List<Map<String, dynamic>> xacNhan = [
    {"status": 2, "date": "22/07/2021"},
    {"status": 2, "date": "22/07/2021"},
    {"status": 2, "date": "22/07/2021"},
    {"status": 2, "date": "22/07/2021"},
    {"status": 2, "date": "22/07/2021"},
  ];
  List<Map<String, dynamic>> dangGiao = [
    {"status": 3, "date": "22/07/2021"},
    {"status": 3, "date": "22/07/2021"},
    {"status": 3, "date": "22/07/2021"},
    {"status": 3, "date": "22/07/2021"},
    {"status": 3, "date": "22/07/2021"},
  ];
  List<Map<String, dynamic>> daGiao = [
    {"status": 4, "date": "22/07/2021"},
    {"status": 4, "date": "22/07/2021"},
    {"status": 4, "date": "22/07/2021"},
    {"status": 4, "date": "22/07/2021"},
    {"status": 4, "date": "22/07/2021"},
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //binding refresh controller
    refreshControllerList = List.generate(tieuDe.length, (_) => RefreshController());

    getData(currentIndex: 0, isRefresh: true);
  }

  Future<void> onRefresh() async {
    //resetNoData
    refreshControllerList![currentIndex].resetNoData();
    Future.delayed(const Duration(milliseconds: 1000), () {
      refreshControllerList![currentIndex].refreshCompleted();
    });
    getData(currentIndex: currentIndex, isRefresh: true);
  }

  //onLoading
  Future<void> onLoading() async {
    //get order isLoading
    getData(currentIndex: currentIndex, isRefresh: false);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void getData({required int currentIndex, required bool isRefresh}) {
    //isRefresh
    // if (isRefresh) {
    //   pageMax = 1;
    //   data.clear();
    // } else {
    //   //isLoading
    //   pageMax++;
    // }
    if (currentIndex == 0) {
      // if (isRefresh) {
      //   data = tatCa;
      //   refreshControllerList![currentIndex].refreshCompleted();
      // } else {
      //   data = tatCa;
      //   refreshControllerList![currentIndex].loadComplete();
      // }
      data = tatCa;
      isLoading = false;
    } else if (currentIndex == 1) {
      data = xacNhan;
      isLoading = false;
    } else if (currentIndex == 2) {
      data = dangGiao;
      isLoading = false;
    } else if (currentIndex == 3) {
      data = daGiao;
      isLoading = false;
    }
    update();
  }

  ///
  ///Thay đổi vị trí tab
  ///
  void onChangeTab({required int index}) {
    isLoading = true;
    currentIndex = index;
    getData(currentIndex: currentIndex, isRefresh: true);
    //resetNoData
    refreshControllerList![index].resetNoData();
    update();
  }

  ///
  ///Go to Detail My Order
  ///
  void goToDetailMyOrder() {
    Get.toNamed(MyOrderRouter.DETAIL_MY_ORDER);
  }
}
