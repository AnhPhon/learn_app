import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/menu.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/lien_he_cong_ty_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/view/screen/v1-customer/account/account_rating_dialog.dart';

import '../../../di_container.dart';

class DrawerController extends GetxController {
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final LienHeCongTyProvider contactProvider = GetIt.I.get<LienHeCongTyProvider>();

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
  }

  ///
  /// Logout
  ///
  void logout() {
    sl.get<SharedPreferenceHelper>().refreshToken.then((value){
      authProvider.logoutAccount(request: {
        'refreshToken':value!
      }, onSuccess: (status){
        if(status){
          sl.get<SharedPreferenceHelper>().removeIsLogin();
          sl.get<SharedPreferenceHelper>().removeJwtToken();
          sl.get<SharedPreferenceHelper>().removePassword();
          sl.get<SharedPreferenceHelper>().removeUserId();
          sl.get<SharedPreferenceHelper>().removeTypeAccount();
          sl.get<SharedPreferenceHelper>().removeRefreshToken();
          sl.get<SharedPreferenceHelper>().removeRememberAccount();
          sl.get<SharedPreferenceHelper>().removeResetPasswordToken();


          Alert.success(message: "Đăng xuất tài khoản thành công!");
          Get.offAllNamed(AppRoutes.LOGIN,predicate: ModalRoute.withName(AppRoutes.LOGIN));
          
        }else{
          Alert.error(message: "Không thể đăng xuất tài khoản vui lòng thử lại sau !");
        }
      }, onError: (onError){
        Alert.error(message: "Không thể đăng xuất tài khoản vui lòng thử lại!");
        print("Lỗi đăng xuất tài khoản $onError");
      });
    });
  }

  void getContact() {
    contactProvider.all(onSuccess: (data) {
      contact = [
        'Hotline: ${data.first.soDienThoai}',
        'Email: ${data.first.email}',
        'VP: ${data.first.diaChi}'
      ];
      update();
    }, onError: (onError) {
      update();
      print("DrawerController getContact onError $onError");
    });
  }

  void rating() async {
    Get.dialog(const V1RatingPage());
  }

  void onPushName(String name) {
    Get.toNamed(name);
  }
}
