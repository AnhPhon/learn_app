import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/request/dang_ky_bao_hiem_request.dart';
import 'package:template/data/model/response/bao_hiem_response.dart';
import 'package:template/data/model/response/dang_ky_bao_hiem_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/bao_hiem_provider.dart';
import 'package:template/provider/dang_ky_bao_hiem_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V3InsuranceRegisterController extends GetxController {
  //refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  //DangKyBaoHiem
  DangKyBaoHiemProvider dangKyBaoHiemProvider = DangKyBaoHiemProvider();
  List<DangKyBaoHiemResponse> dangKyBaoHiemResponse = [];
  DangKyBaoHiemRequest dangKyBaoHiemRequest = DangKyBaoHiemRequest();

  //BaoHiem
  BaoHiemProvider baoHiemProvider = BaoHiemProvider();
  BaoHiemResponse? baoHiemResponse;

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

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 6;

  //index tab
  int currentIndex = 0;

  //fee
  int indexFee = 0;

  @override
  void onInit() {
    super.onInit();
    //get parameters
    currentIndex = int.parse(Get.parameters['currentIndex']!);

    //get arguments
    if (Get.arguments != null) {
      baoHiemResponse = Get.arguments as BaoHiemResponse;
    }

    //get load data
    getYourInsurance(isRefresh: true);
  }

  ///
  ///get your insurance
  ///
  Future<void> getYourInsurance({required bool isRefresh}) async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //
    if (isRefresh) {
      pageMax = 1;
      dangKyBaoHiemResponse.clear();
    } else {
      pageMax++;
    }

    //get your insurance
    dangKyBaoHiemProvider.paginate(
      page: pageMax,
      limit: limitMax,
      filter: "&idTaiKhoan=$userId&trangThai=1&sortBy=created_at:desc",
      onSuccess: (value) {
        //check is empty
        if (value.isEmpty) {
          refreshController.loadNoData();
        } else {
          if (isRefresh) {
            dangKyBaoHiemResponse = value;
            refreshController.refreshCompleted();
          } else {
            dangKyBaoHiemResponse = dangKyBaoHiemResponse.toList() + value;
            refreshController.loadComplete();
          }
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3InsuranceRegisterController getYourInsurance onError $error");
      },
    );
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    //reset noData
    refreshController.resetNoData();

    //getYourInsurance
    getYourInsurance(isRefresh: true);
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    //getYourInsurance
    getYourInsurance(isRefresh: false);
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
    Get.toNamed(
            "${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${baoHiemResponse!.phis![indexFee]}&tienCoc=0")!
        .then(
      (value) {
        if (value !=null) {
          //set data
        dangKyBaoHiemRequest.idTaiKhoan = userId;
        dangKyBaoHiemRequest.idBaoHiem = baoHiemResponse!.id;
        dangKyBaoHiemRequest.trangThai = "0";
        dangKyBaoHiemRequest.phi = baoHiemResponse!.phis![indexFee];
        //insert
        dangKyBaoHiemProvider.add(
          data: dangKyBaoHiemRequest,
          onSuccess: (data) {
            Get.offAllNamed(
              AppRoutes.V3_PROFILE,
              predicate: ModalRoute.withName(AppRoutes.V3_PROFILE),
            );
          },
          onError: (error) {
            print(
                "V3InsuranceRegisterController onCheckoutClick onError $error");
          },
        );
        }
        
      },
    );
  }
}
