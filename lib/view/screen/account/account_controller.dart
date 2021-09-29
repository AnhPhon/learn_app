import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/order_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/di_container.dart';
import 'package:get_it/get_it.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/screen/account/password/password_change_page.dart';

class AccountController extends GetxController
    with SingleGetTickerProviderMixin {
  UserProvider userProvider = GetIt.I.get<UserProvider>();
  OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  var counter = 1.obs;

  var orderPages = 0.obs;

  UserModel userModel = UserModel();
  List<OrderModel> orderStatusList = [];

  String? userId;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
      getUserById();
      getOrder();
    });
  }

  ///
  ///load info user
  ///
  void getUserById() {
    userProvider.find(
        id: userId.toString(),
        onSuccess: (value) {
          userModel = value;
          update();
        },
        onError: (error) {
          print(error);
        });
  }

  ///
  ///load order
  ///
  void getOrder() {
    orderProvider.paginate(
      filter: '&idUser=$userId',
      limit: 100,
      page: 1,
      onSuccess: (value) {
        orderStatusList = value;
        isLoading = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Thay đổi thông tin
  ///
  void onEditInfoClick() {
    Get.toNamed(AppRoutes.EDIT_INFO);
  }

  ///
  /// tới màn hình rules
  ///
  void onRulesClick() {
    Get.toNamed(AppRoutes.RULES);
  }
  

  ///
  ///đăng xuất
  ///
  void onLogoutClick() {
    sl.get<SharedPreferenceHelper>().removeUserId();
    sl.get<SharedPreferenceHelper>().removeIsLogin();
    Get.back();
  }

  ///
  /// đổi mật khẩu
  ///
  void onChangePasswordClick() {
    Get.toNamed(AppRoutes.PASSWORD_CHANGE);
  }

  ///
  ///tới màn hình order
  ///
  void onOrderClick(int index) {
    update();
    Get.toNamed("${AppRoutes.ORDER}?indexTab=$index");
  }
}
