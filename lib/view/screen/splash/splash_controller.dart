import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController? _animationController;
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();

  @override
  void onInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animationController!.forward().whenComplete(() async {
      // remove token reset password
      sl.get<SharedPreferenceHelper>().removeResetPasswordToken();
      // Để testing đăng nhập nhân viên vì nhân viên không có đăng xuất
      sl.get<SharedPreferenceHelper>().removeRememberAccount();

      final bool? isFirst = await sl.get<SharedPreferenceHelper>().isFirst;
      final bool? isLogin = await sl.get<SharedPreferenceHelper>().isLogin;
      final String? idLoaiTaiKhoan =
          await sl.get<SharedPreferenceHelper>().typeAccount;

      // Nếu người dùng remember thì đăng nhập thằng vào app
      sl.get<SharedPreferenceHelper>().rememberAccount.then((value) {
        if (value == true && value != null) {
          // is first time
          if (isFirst == null) {
            Get.offAllNamed(AppRoutes.INTRO);
          } else {
            // check if is login
            if (isLogin != null && isLogin) {
              if (idLoaiTaiKhoan != null) {
                print(idLoaiTaiKhoan);
                if (idLoaiTaiKhoan == KHACH_HANG) {
                  Get.offAndToNamed(AppRoutes.V1_DASHBOARD);
                  return;
                } else if (idLoaiTaiKhoan == THO_THAU) {
                  Get.offAndToNamed(AppRoutes.V2_DASHBOARD);
                  return;
                } else if (idLoaiTaiKhoan == DAI_LY) {
                  Get.offAndToNamed(AppRoutes.V3_DASHBOARD);
                  return;
                } else if (idLoaiTaiKhoan == NHAN_VIEN) {
                  Get.offAndToNamed(AppRoutes.V4_DASHBOARD);
                  return;
                } else {
                  // Logout
                  // Khi không tự động nhập được thì logout clear() share để người dùng đăng nhập lại từ đầu
                  Get.offAllNamed(AppRoutes.LOGIN);
                  update();
                }
              } else {
                // logout
                Get.offAllNamed(AppRoutes.LOGIN);
                update();
              }
              //Get.offNamed(AppRoutes.DASHBOARD);
            } else {
              // Nếu người dùng chưa đăng nhập lần trước đó
              Get.offAllNamed(AppRoutes.LOGIN);
            }
          }
        } else {
          // Không remember thì không đăng nhập thằng vào home
          Get.offAllNamed(AppRoutes.LOGIN);
        }
      }); // end
    }); // end
    super.onInit();
  }

  ///
  /// Logout
  ///
  void logout() {
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

              IZIAlert.info(message: "Xin chào, ");
              Get.offAllNamed(AppRoutes.LOGIN);
            } else {
              IZIAlert.error(message: "Đã xảy ra lỗi vui lòng thử lại!");
            }
          },
          onError: (onError) {
            print("Lỗi đăng xuất $onError");
          });
    });
  }

  @override
  void onClose() {
    super.onClose();
    print('on onClose');
    _animationController!.dispose();
  }
}
