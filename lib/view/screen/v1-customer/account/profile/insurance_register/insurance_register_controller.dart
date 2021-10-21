import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/request/dang_ky_bao_hiem_request.dart';
import 'package:template/data/model/response/bao_hiem_response.dart';
import 'package:template/data/model/response/dang_ky_bao_hiem_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/bao_hiem_provider.dart';
import 'package:template/provider/dang_ky_bao_hiem_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1InsuranceRegisterController extends GetxController {
  //DangKyBaoHiem
  DangKyBaoHiemProvider dangKyBaoHiemProvider = DangKyBaoHiemProvider();
  List<DangKyBaoHiemResponse> dangKyBaoHiemResponse = [];
  DangKyBaoHiemRequest dangKyBaoHiemRequest = DangKyBaoHiemRequest();

  //BaoHiem
  BaoHiemProvider baoHiemProvider = BaoHiemProvider();
  List<BaoHiemResponse> baoHiemResponse =
      Get.arguments as List<BaoHiemResponse>;

  //
  String title0 = "Bảo hiểm của bạn";
  String title1 = "Đăng ký mua bảo hiểm";

  //tab 
  List titleTabBar = [
    "Bảo hiểm của bạn",
    "Đăng ký mua",
  ];

  //user id
  String userId = "";

  //CircularProgressIndicator
  bool isLoading = true;

  //index tab
  int currentIndex = 0;

  //fee
  int indexFee = 0;

  @override
  void onInit() {
    super.onInit();
    //get parameters
    currentIndex = int.parse(Get.parameters['currentIndex']!);

    //get load data
    getYourInsurance();
  }

  ///
  ///get your insurance
  ///
  Future<void> getYourInsurance() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //get your insurance 
    dangKyBaoHiemProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is not empty
        if (value.isNotEmpty) {
          dangKyBaoHiemResponse = value;
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V1InsuranceRegisterController getYourInsurance onError $error");
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
  ///set selected index fee
  ///
  void setSelectedIndexFee(int? index) {
    indexFee = index!;
    update();
  }

  ///
  ///on checkout click
  ///
  void onCheckoutClick(BuildContext context) {

    //set data
    dangKyBaoHiemRequest.idTaiKhoan = userId;
    dangKyBaoHiemRequest.idBaoHiem = baoHiemResponse[indexFee].id;
    dangKyBaoHiemRequest.trangThai = "0";

    //insert
    dangKyBaoHiemProvider.add(
      data: dangKyBaoHiemRequest,
      onSuccess: (value) {
        Get.toNamed(
            "${AppRoutes.V1_PAYMENT_ACCOUNT}?idInsurance=true&amountOfMoney=${baoHiemResponse[indexFee].phi}");
      },
      onError: (error) {
        print("V1InsuranceRegisterController onCheckoutClick onError $error");
      },
    );
  }
}
