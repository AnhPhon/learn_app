import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/auth_model.dart';
import 'package:template/data/model/request/auth_request.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/auth_provider.dart';
// import 'package:template/provider/auth_provider.dart';
// import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class LoginController extends GetxController {
  AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  // UserProvider userProvider = GetIt.I.get<UserProvider>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  AuthModel? auth;
  bool isLoading = true;

  @override
  void onInit() {
    usernameController.text = 'admin1@gmail.com';
    passwordController.text = 'admin@123';
    login();
    super.onInit();
  }

  void login() {
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
      request.email = usernameController.text.toString();
      request.password = passwordController.text.toString();

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

            // save info token and info user
            sl.get<SharedPreferenceHelper>().saveUserId(auth.id!);
            sl.get<SharedPreferenceHelper>().saveJwtToken(auth.access!);
            sl.get<SharedPreferenceHelper>().saveRefreshToken(auth.refresh!);
            //sl.get<SharedPreferenceHelper>().saveIsLogin(true);

            update();

            // go to dashboard
            Get.toNamed(AppRoutes.DASHBOARD);
          },
          onError: (error) {
            isLoading = false;
            Get.snackbar(
              "Lỗi", // title
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

  // @override
  // void onInit() {
  //   // usernameController.text = 'ytp3001';
  //   // passwordController.text = 'password';
  //   super.onInit();
  // }

  ///
  /// on login click
  ///
  void onLoginBtnClick() {
    sl.get<SharedPreferenceHelper>().saveUserId("616a51bc000118120619c3a2");
    sl.get<SharedPreferenceHelper>().saveUserId("616a970406a577482e029c19");
    if (usernameController.text == '1') {
      Get.toNamed(AppRoutes.V1_DASHBOARD);
    } else if (usernameController.text == '2') {
      Get.toNamed(AppRoutes.V2_DASHBOARD);
    } else if (usernameController.text == '3') {
      Get.toNamed(AppRoutes.V3_DASHBOARD);
    } else if (usernameController.text == '4') {
      Get.toNamed(AppRoutes.V4_DASHBOARD);
    } else {}

    // // validate infomation username password
    // if (usernameController.text == '' || passwordController.text == '') {
    //   Get.snackbar(
    //     "Thông báo!", // title
    //     'Vui lòng nhập đầy đủ thông tin', // message
    //     icon: const Icon(Icons.error_outline),
    //     shouldIconPulse: true,
    //     isDismissible: true,
    //     duration: const Duration(seconds: 3),
    //   );
    // } else {
    //   // login with info user input
    //   final AuthRequest request = AuthRequest();
    //   request.username = usernameController.text.toString();
    //   request.password = passwordController.text.toString();

    //   authProvider.login(
    //       request: request,
    //       onSuccess: (auth) {
    //         Get.snackbar(
    //           "Thành công!", // title
    //           'Đăng nhập thành công', // message
    //           icon: const Icon(Icons.error_outline),
    //           shouldIconPulse: true,
    //           isDismissible: true,
    //           duration: const Duration(seconds: 2),
    //         );

    //         isLoading = false;
    //         auth = auth;

    //         // save info token and info user
    //         sl.get<SharedPreferenceHelper>().saveUserId(auth.id!);
    //         sl.get<SharedPreferenceHelper>().saveJwtToken(auth.access!);
    //         sl.get<SharedPreferenceHelper>().saveRefreshToken(auth.refresh!);
    //         sl.get<SharedPreferenceHelper>().saveIsLogin(true);

    //         update();

    //         // go to dashboard
    //         Get.toNamed(AppRoutes.DASHBOARD);
    //       },
    //       onError: (error) {
    //         isLoading = false;
    //         Get.snackbar(
    //           "Hey i'm a Get SnackBar!", // title
    //           error.toString(), // message
    //           icon: const Icon(Icons.error_outline),
    //           shouldIconPulse: true,
    //           isDismissible: true,
    //           duration: const Duration(seconds: 3),
    //         );
    //         print(error);
    //         update();
    //       });
    // }
    // validate infomation username password

    //validate infomation username password
    // if (usernameController.text == '' || passwordController.text == '') {
    //   Get.snackbar(
    //     "Thông báo!", // title
    //     'Vui lòng nhập đầy đủ thông tin', // message
    //     icon: const Icon(Icons.error_outline),
    //     shouldIconPulse: true,
    //     isDismissible: true,
    //     duration: const Duration(seconds: 3),
    //   );
    // } else {
    //   // // login with info user input
    //   final AuthRequest request = AuthRequest();
    //   request.username = usernameController.text.toString();
    //   request.password = passwordController.text.toString();

    //   authProvider.login(
    //       request: request,
    //       onSuccess: (auth) {
    //         Get.snackbar(
    //           "Thành công!", // title
    //           'Đăng nhập thành công', // message
    //           icon: const Icon(Icons.error_outline),
    //           shouldIconPulse: true,
    //           isDismissible: true,
    //           duration: const Duration(seconds: 2),
    //         );

    //         isLoading = false;
    //         auth = auth;

    //         // save info token and info user
    //         sl.get<SharedPreferenceHelper>().saveUserId(auth.id!);
    //         sl.get<SharedPreferenceHelper>().saveJwtToken(auth.access!);
    //         sl.get<SharedPreferenceHelper>().saveRefreshToken(auth.refresh!);
    //         sl.get<SharedPreferenceHelper>().saveIsLogin(true);

    //         update();

    //         // go to dashboard
    //         Get.toNamed(AppRoutes.DASHBOARD);
    //       },
    //       onError: (error) {
    //         isLoading = false;
    //         Get.snackbar(
    //           "Hey i'm a Get SnackBar!", // title
    //           error.toString(), // message
    //           icon: const Icon(Icons.error_outline),
    //           shouldIconPulse: true,
    //           isDismissible: true,
    //           duration: const Duration(seconds: 3),
    //         );
    //         print(error);
    //         update();
    //       });
    // }
  }
}
