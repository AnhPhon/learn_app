import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/screen/v2-builder/account/account_rating_dialog.dart';

class V2AccountController extends GetxController {
  TaiKhoanProvider taiKhoanProvider = TaiKhoanProvider();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();

  String title = "Tài khoản";

  double rating = 0;

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
      taiKhoanProvider.find(
        id: userId.toString(),
        onSuccess: (value) {
          taiKhoanResponse = value;
          isLoading = false;
          update();
        },
        onError: (error) {
          print("V2AccountController getAccounInfomation onError $error");
        },
      );
    });
  }

  ///
  ///go to profile page
  ///
  void onProfileClick() {
    Get.toNamed(AppRoutes.V2_PROFILE);
  }

  ///
  ///go to profile page
  ///
  void onPersonalInfoClick() {
    Get.toNamed(AppRoutes.V2_PERSONAL_INFORMATION)!.then((value) {
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
    Get.toNamed(AppRoutes.V2_REVENUE);
  }

  ///
  ///go to wallet page
  ///
  void onWalletPageClick() {
    Get.toNamed(AppRoutes.V2_WALLET);
  }

  ///
  ///go to rules page
  ///
  void onRulesPageClick() {
    Get.toNamed(AppRoutes.V2_RULES);
  }

  ///
  ///go to help page
  ///
  void onHelpPageClick() {
    Get.toNamed(AppRoutes.V2_HELP);
  }

  ///
  ///go to safety page
  ///
  void onSafetyPageClick() {
    Get.toNamed(AppRoutes.V2_SAFETY);
  }

  ///
  ///go to product update page
  ///
  void onProductUpdatePageClick() {
    Get.toNamed(AppRoutes.V2_PRODUCT_UPDATE);
  }

  ///
  ///go to service update page
  ///
  void onServiceUpdatePageClick() {
    Get.toNamed(AppRoutes.V2_SERVICE_UPDATE);
  }

  ///
  ///go to mail page
  ///
  void onMailClick() {
    Get.toNamed(AppRoutes.V2_MAIL);
  }

  ///
  ///show dialog rating
  ///
  void showDialogRating(BuildContext context) {
    Get.dialog(const V2RatingPage());
  }
}
