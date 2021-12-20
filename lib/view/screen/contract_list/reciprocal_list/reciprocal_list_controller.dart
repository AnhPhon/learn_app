import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/routes/route_path/contract_list_routers.dart';

class ReciprocalListController extends GetxController {
//Khai báo isLoading
  bool isLoading = true;

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
  ///Go to Reciprocal Details
  ///
  void goToReciprocalDetails() {
    Get.toNamed(ContractListRouters.RECIPROCAL_DETAILS);
  }

  ///
  ///Go to Reciprocal Details
  ///
  void goToAddReciprocal() {
    Get.toNamed(ContractListRouters.ADD_RECIPROCAL);
  }
}
