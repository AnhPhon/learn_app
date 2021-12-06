import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';
import 'package:template/data/model/body/menu.dart';
import 'package:template/data/model/response/cai_dat_chung_response.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/cai_dat_chung_provider.dart';
import 'package:template/provider/lien_he_cong_ty_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/view/screen/account_rating_dialog.dart';

import '../../../di_container.dart';

class DrawerController extends GetxController {
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final LienHeCongTyProvider contactProvider =
      GetIt.I.get<LienHeCongTyProvider>();

  //caiDatChung
  CaiDatChungProvider caiDatChungProvider = GetIt.I.get<CaiDatChungProvider>();
  CaiDatChungResponse caiDatChungResponse = CaiDatChungResponse();

  List<Menu> menu = [];
  List<String> contact = [];

  @override
  void onInit() {
    super.onInit();

    menu = [
      Menu(
          title: 'Giới thiệu tóm tắt cơ chế hoạt động',
          onPress: () => onPushName(AppRoutes.V1_ABOUT)),
      Menu(
          title: 'Quyền và nghĩa vụ của FSS',
          onPress: () => onPushName(AppRoutes.V1_OBLIGATIONS)),
      Menu(
          title: 'Quy trình sử dụng vào giao dịch',
          onPress: () => onPushName(AppRoutes.V1_USAGE_PROCEDURE)),
      Menu(
          title: 'Điều khoản và chính sách',
          onPress: () => onPushName(AppRoutes.V1_TERM_AND_POLICY)),
      Menu(
          title: 'Lợi ích khi tham gia FSS',
          onPress: () => onPushName(AppRoutes.V1_BENEFITS)),
      Menu(title: 'Đánh giá', onPress: rating),
      Menu(title: 'Đăng xuất', onPress: () => logout()),
    ];

    getContact();
    getCaiDatChung();
  }

  ///
  /// Logout
  ///
  void logout() {
    EasyLoading.show(status: "Đăng xuất ...");
    sl.get<SharedPreferenceHelper>().refreshToken.then((value) {
      authProvider.logoutAccount(
          request: {'refreshToken': value!},
          onSuccess: (status) {
            if (status) {
              sl.get<SharedPreferenceHelper>().removeIsLogin();
              sl.get<SharedPreferenceHelper>().removeJwtToken();
              sl.get<SharedPreferenceHelper>().removePassword();
              sl.get<SharedPreferenceHelper>().removeUserId();
              sl.get<SharedPreferenceHelper>().removeTypeAccount();
              sl.get<SharedPreferenceHelper>().removeRefreshToken();
              sl.get<SharedPreferenceHelper>().removeRememberAccount();
              sl.get<SharedPreferenceHelper>().removeResetPasswordToken();

              EasyLoading.dismiss();
              Alert.success(message: "Đăng xuất tài khoản thành công!");

              Get.offAllNamed(AppRoutes.LOGIN,
                  predicate: ModalRoute.withName(AppRoutes.LOGIN));
            } else {
              EasyLoading.dismiss();
              Alert.error(
                  message:
                      "Không thể đăng xuất tài khoản vui lòng thử lại sau !");
            }
          },
          onError: (onError) {
            EasyLoading.dismiss();
            Alert.error(
                message: "Không thể đăng xuất tài khoản vui lòng thử lại!");
            print("Lỗi đăng xuất tài khoản $onError");
          });
    });
  }

  Future<void> getContact() async {
    final version = await PackageInfo.fromPlatform();
    contactProvider.all(onSuccess: (data) {
      contact = [
        'Hotline: ${data.first.soDienThoai}',
        'Email: ${data.first.email}',
        'VP: ${data.first.diaChi}',
        "Version: ${version.version}"
      ];
      update();
    }, onError: (onError) {
      update();
      print("DrawerController getContact onError $onError");
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

  Future<void> rating() async {
    Get.dialog(RatingPage(
      linkAndroid: caiDatChungResponse.linkAndroid.toString(),
      linkIos: caiDatChungResponse.linkIos.toString(),
    ));
  }

  void onPushName(String name) {
    Get.toNamed(name);
  }
}
