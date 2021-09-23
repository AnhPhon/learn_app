import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/login_model.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/routes/app_routes.dart';

class LoginController extends GetxController {
  // AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  // void login() {
  //   authProvider.login(
  //       onSuccess: (value) {
  //         print("Login success");
  //         Get.toNamed(AppRoutes.DASHBOARD);
  //         update();
  //       },
  //       onError: (error) {
  //         print(error);
  //         update();
  //       },
  //       loginBody: LoginModel(
  //           username: userNameController.text,
  //           password: passwordController.text));
  // }
}
