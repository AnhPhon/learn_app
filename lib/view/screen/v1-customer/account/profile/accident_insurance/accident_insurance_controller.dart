import 'package:get/get.dart';
import 'package:template/data/model/response/bao_hiem_response.dart';
import 'package:template/provider/bao_hiem_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1AccidentInsuranceController extends GetxController {
  // baoHiem
  BaoHiemProvider baoHiemProvider = BaoHiemProvider();
  List<BaoHiemResponse> baoHiemResponse = [];

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

  @override
  void onInit() {
    super.onInit();
    //get load data
    getInsurance();
  }

  ///
  ///get insurance
  ///
  Future<void> getInsurance() async {
    baoHiemProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&loai=1&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is not empty
        if (value.isNotEmpty) {
          baoHiemResponse = value;
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
  ///on register click
  ///
  void onRegisterClick() {
    //check is not empty
    if (baoHiemResponse.isNotEmpty) {
      Get.toNamed("${AppRoutes.V1_INURANCE_REGISTER}?currentIndex=1",
          arguments: baoHiemResponse);
    }
  }

  ///
  ///on your insurance click
  ///
  void onYourInsurancePageClick() {
    Get.toNamed("${AppRoutes.V1_INURANCE_REGISTER}?currentIndex=0",
        arguments: baoHiemResponse);
  }
}
