import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/v3-agent/account/account_rating_dialog.dart';

class V3AccountController extends GetxController {
  final TaiKhoanProvider accountProvider = GetIt.I.get<TaiKhoanProvider>();
  
  String title = "Tài khoản";

  double rating = 0;
  TaiKhoanResponse? taiKhoanResponse;

  String urlImage =
      "https://upload.wikimedia.org/wikipedia/commons/1/1e/Default-avatar.jpg";

  String name = "username";

  String email = "email@gmail.com";

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    getAccounInfomation();
  }

  ///
  ///get account infomation
  ///
  void getAccounInfomation() {
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      accountProvider.find(
        id: userId.toString(),
        onSuccess: (value) {
          taiKhoanResponse = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print("V3AccountController getAccounInfomation onError $error");
        },
      );
    });
  }

  ///
  ///go to profile page
  ///
  void onProfileClick() {
    Get.toNamed(AppRoutes.V3_PROFILE);
  }

  ///
  ///go to profile page
  ///
  void onPersonalInfoClick() {
    Get.toNamed(AppRoutes.V3_PERSONAL_INFORMATION)!.then((value) {
      if (value == true) {
        isLoading = true;
        update();
        getAccounInfomation();
      }
    });
  }

  ///
  ///go to revenue page
  ///
  void onRevenuePageClick() {
    Get.toNamed(AppRoutes.V3_REVENUE);
  }

  ///
  ///go to wallet page
  ///
  void onWalletPageClick() {
    Get.toNamed(AppRoutes.V3_WALLET);
  }

  ///
  ///go to rules page
  ///
  void onRulesPageClick() {
    Get.toNamed(AppRoutes.V3_RULES);
  }

  ///
  ///go to help page
  ///
  void onHelpPageClick() {
    Get.toNamed(AppRoutes.V3_HELP);
  }

  ///
  ///go to customer management page
  ///
  void onCustomerManagementPageClick() {
    Get.toNamed(AppRoutes.V3_CUSTOMER_MANAGEMENT);
  }

  ///
  ///go to mail page
  ///
  void onMailClick() {
    Get.toNamed(AppRoutes.V3_MAIL);
  }

  ///
  ///show dialog rating
  ///
  void showDialogRating(BuildContext context) {
    Get.dialog(const V3RatingPage());
  }

  ///
  ///Switch role customer
  ///
  void onSwitchCustomer() {
    sl.get<SharedPreferenceHelper>().userId.then((value){
      final TaiKhoanRequest taiKhoanRequest = TaiKhoanRequest();
       
        taiKhoanRequest.id = value;
        taiKhoanRequest.idLoaiTaiKhoan = KHACH_HANG;
        accountProvider.update(data: taiKhoanRequest, onSuccess: (onSuccess){
          sl.get<SharedPreferenceHelper>().saveTypeAccount(KHACH_HANG);
          Get.offAndToNamed(AppRoutes.V1_DASHBOARD);
        }, onError: (onError){
           Alert.error(message:"Chuyển vai trò thất bại");
        });
    });
  }

  ///
  ///Switch role build
  ///
  void onSwitchBuild() {
    sl.get<SharedPreferenceHelper>().userId.then((value){
      final TaiKhoanRequest taiKhoanRequest = TaiKhoanRequest();
        taiKhoanRequest.id = value;
        taiKhoanRequest.idLoaiTaiKhoan = THO_THAU;
        accountProvider.update(data: taiKhoanRequest, onSuccess: (onSuccess){
          sl.get<SharedPreferenceHelper>().saveTypeAccount(THO_THAU);
          Get.offAndToNamed(AppRoutes.V2_DASHBOARD);
        }, onError: (onError){
           Alert.error(message:"Chuyển vai trò thất bại");
        });
    });
  }
}
