import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/data/model/request/auth_request.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class LoginController extends GetxController {
  AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  UserProvider userProvider = GetIt.I.get<UserProvider>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  AuthModel? auth;
  bool isLoading = true;

  @override
  void onInit() {
    usernameController.text = 'ytp3001';
    passwordController.text = 'password';

    super.onInit();
  }

  ///
  /// on login click
  ///
  void onLoginBtnClick() {
    // validate infomation username password
    if (usernameController.text == '' || passwordController.text == '') {
      Get.snackbar(
        "Thông báo!", // title
        'Vui lòng nhập đầy đủ thông tin', // message
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 3),
      );
    } else {
      // login with info user input
      final AuthRequest request = AuthRequest();
      request.username = usernameController.text.toString();
      request.password = passwordController.text.toString();

      // Get.snackbar(
      //   "Thành công!", // title
      //   'Đăng nhập thành công', // message
      //   icon: const Icon(Icons.error_outline),
      //   shouldIconPulse: true,
      //   isDismissible: true,
      //   duration: const Duration(seconds: 2),
      // );

      // isLoading = false;
      // auth = auth;
      // if(auth != null) {
      //   sl.get<SharedPreferenceHelper>().saveUserId(auth!.idUser!);
      // }
      // update();

      // // go to dashboard
      // Get.offAndToNamed(AppRoutes.DASHBOARD);

      authProvider.login(
          request: request,
          onSuccess: (auth) {
            Get.snackbar(
              "Thành công!", // title
              'Đăng nhập thành công', // message
              icon: const Icon(Icons.error_outline),
              shouldIconPulse: true,
              isDismissible: true,
              duration: const Duration(seconds: 2),
            );

            isLoading = false;
            auth = auth;

            userProvider.all(onSuccess: (data) {
              for (final UserModel element in data) {
                if (element.username == auth.username) {
                  sl.get<SharedPreferenceHelper>().saveUserId(element.id!);
                  break;
                }
              }
            }, onError: (error) {
              print(error);
              update();
            });

            update();

            // go to dashboard
            Get.offAndToNamed(AppRoutes.DASHBOARD);
          },
          onError: (error) {
            isLoading = false;
            Get.snackbar(
              "Hey i'm a Get SnackBar!", // title
              error.toString(), // message
              icon: const Icon(Icons.error_outline),
              shouldIconPulse: true,
              isDismissible: true,
              duration: const Duration(seconds: 3),
            );
            print(error);
            update();
          });
    }
  }
}
