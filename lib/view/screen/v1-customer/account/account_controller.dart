import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/response/cai_dat_chung_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/cai_dat_chung_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/account_rating_dialog.dart';

class V1AccountController extends GetxController {
  TaiKhoanProvider taiKhoanProvider = TaiKhoanProvider();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();
  final TaiKhoanProvider accountProvider = GetIt.I.get<TaiKhoanProvider>();

  //caiDatChung
  CaiDatChungProvider caiDatChungProvider = GetIt.I.get<CaiDatChungProvider>();
  CaiDatChungResponse caiDatChungResponse = CaiDatChungResponse();

  String title = "Tài khoản";

  double rating = 0;

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
          getCaiDatChung();
          isLoading = false;
          update();
        },
        onError: (error) {
          print("V1AccountController getAccounInfomation onError $error");
        },
      );
    });
  }

  ///
  ///get caiDatChung
  ///
  void getCaiDatChung() {
    caiDatChungProvider.all(
      onSuccess: (data) {
        if (data.isNotEmpty) {
          caiDatChungResponse = data.first;
        }
      },
      onError: (error) {
        print("V1AccountController getCaiDatChung onError $error");
      },
    );
  }

  ///
  ///go to profile page
  ///
  void onProfileClick() {
    Get.toNamed(AppRoutes.V1_PROFILE);
  }

  ///
  ///go to profile page
  ///
  void onPersonalInfoClick() {
    Get.toNamed(AppRoutes.V1_PERSONAL_INFORMATION)!.then((value) {
      if (value == true) {
        isLoading = true;
        update();
        getAccounInfomation();
      }
    });
  }

  ///
  ///go to point-based page
  ///
  void onPointBasedPageClick() {
    Get.toNamed(AppRoutes.V1_POINT_BASED);
  }

  ///
  ///go to wallet page
  ///
  void onWalletPageClick() {
    Get.toNamed(AppRoutes.WALLET);
  }

  ///
  ///go to rules page
  ///
  void onRulesPageClick() {
    Get.toNamed(AppRoutes.V1_RULES);
  }

  ///
  ///go to introduce page
  ///
  void onIntroducePageClick() {
    Get.toNamed(AppRoutes.V1_INTRODUCE);
  }

  ///
  ///go to help page
  ///
  void onHelpPageClick() {
    Get.toNamed(AppRoutes.V1_HELP);
  }

  ///
  ///go to job management page
  ///
  void onJobManagementClick() {
    Get.toNamed(AppRoutes.V1_JOB_MANAGEMENT);
  }

  ///
  ///go to mail page
  ///
  void onMailClick() {
    Get.toNamed(AppRoutes.V1_MAIL);
  }

  ///
  ///go to my order page
  ///
  void onMyOrderClick() {
    Get.toNamed(AppRoutes.V1_MY_ORDER);
  }

  ///
  ///Switch role build
  ///
  void onSwitchBuild() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      final TaiKhoanRequest taiKhoanRequest = TaiKhoanRequest();
      taiKhoanRequest.id = value;
      taiKhoanRequest.idLoaiTaiKhoan = THO_THAU;
      taiKhoanProvider.update(
          data: taiKhoanRequest,
          onSuccess: (onSuccess) async {
            await sl.get<SharedPreferenceHelper>().saveTypeAccount(THO_THAU);
            Get.offAndToNamed(AppRoutes.V2_DASHBOARD);
          },
          onError: (onError) {
            Alert.error(message: "Chuyển vai trò thất bại");
          });
    });
  }

  ///
  ///Switch role agent
  ///
  void onSwitchAgent() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      final TaiKhoanRequest taiKhoanRequest = TaiKhoanRequest();
      taiKhoanRequest.id = value;
      taiKhoanRequest.idLoaiTaiKhoan = DAI_LY;
      taiKhoanProvider.update(
          data: taiKhoanRequest,
          onSuccess: (onSuccess) async {
            await sl.get<SharedPreferenceHelper>().saveTypeAccount(DAI_LY);
            Get.offAndToNamed(AppRoutes.V3_DASHBOARD);
          },
          onError: (onError) {
            Alert.error(message: "Chuyển vai trò thất bại");
          });
    });
  }

  ///
  ///show dialog rating
  ///
  void showDialogRating(BuildContext context) {
    Get.dialog(RatingPage(
      linkAndroid: caiDatChungResponse.linkAndroid.toString(),
      linkIos: caiDatChungResponse.linkIos.toString(),
    ));
  }
}
