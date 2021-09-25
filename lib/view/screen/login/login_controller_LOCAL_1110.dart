import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/categories/categories_controller.dart';

class LoginController extends GetxController {
  // AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final categoriesController = Get.put(CategoriesController());

  @override
  void onInit() {
    super.onInit();
    categoriesController.getAllCategories();
  }

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
