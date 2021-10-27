import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:template/di_container.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController? _animationController;

  @override
  void onInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animationController!.forward().whenComplete(() async {
      final bool? isFirst = await sl.get<SharedPreferenceHelper>().isFirst;
      final bool? isLogin = await sl.get<SharedPreferenceHelper>().isLogin;
      final String? idLoaiTaiKhoan = await sl.get<SharedPreferenceHelper>().typeAccount;

      // is first time
      if (isFirst == null) {
        Get.offAllNamed(AppRoutes.INTRO);
      } else {
        // check if is login
        if (isLogin != null && isLogin) {
          if(idLoaiTaiKhoan != null){
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
            }else{
              // Logout
              update();
            }
          }else{
            // logout
            update();
          }
          //Get.offNamed(AppRoutes.DASHBOARD);
        } else {
          // is not login
          Get.offAllNamed(AppRoutes.LOGIN);
        }
      }
    });

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    print('on onClose');
    _animationController!.dispose();
  }
}
