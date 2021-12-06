import 'package:get/get.dart';
import 'package:template/data/model/response/bao_hiem_response.dart';
import 'package:template/provider/bao_hiem_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';

class V1AccidentInsuranceController extends GetxController {
  // baoHiem
  BaoHiemProvider baoHiemProvider = BaoHiemProvider();
  BaoHiemResponse baoHiemResponse = BaoHiemResponse();

  //title appbar
  String title = "Bảo hiểm tai nạn";

  //map tab
  Map<String, String> titleTabBar = {
    "GT": "Giới thiệu",
    "QL": "Quyền lợi",
    "BT": "Bồi thường",
  };
  //index tab
  int currentIndex = 0;

  //CircularProgressIndicator
  bool isLoading = true;

  bool? isFinishUpdate;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      isFinishUpdate = Get.arguments as bool;
    }

    //get load data
    getInsurance();
  }

  ///
  ///get insurance
  ///
  Future<void> getInsurance() async {
    baoHiemProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&loai=1&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is not empty
        if (value.isNotEmpty) {
          baoHiemResponse = value.first;
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1AccidentInsuranceController getInsurance onError $error");
      },
    );
  }

  ///
  /// changed tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }

  ///
  ///on btn click
  ///
  void onBtnClick({required int currentIndex}) {
    //check is not empty
    if (baoHiemResponse.id != null) {
      Get.toNamed(
          "${AppRoutes.V1_INURANCE_REGISTER}?currentIndex=$currentIndex${isFinishUpdate != null ? "&isFinishUpdate=$isFinishUpdate" : ""}",
          arguments: baoHiemResponse);
    }
  }
}
