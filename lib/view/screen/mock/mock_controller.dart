import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/routes/route_path/account_management_routers.dart';
import 'package:template/routes/route_path/demo_base_card_routers.dart';
import 'package:template/routes/route_path/my_order_routes.dart';
import 'package:template/routes/route_path/refer_friends_routers.dart';
import 'package:template/routes/route_path/voucher_routers.dart';

class MockController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///
  ///Go to My Order
  ///
  void goToMyOrder() {
    Get.toNamed(MyOrderRouter.MY_ORDER);
  }

  ///
  ///Go to Demo Card
  ///
  void goToDemoBaseCard() {
    Get.toNamed(DemoBaseCardRouter.DEMO_BASE_CARD);
  }

  ///
  ///Go to Account Managements
  ///
  void goToAccountManagements() {
    Get.toNamed(AccountManagementRouter.ACCOUNT_MANAGEMENT);
  }

  ///
  ///Go to Voucher
  ///
  void goToVoucher() {
    Get.toNamed(VoucherRouters.VOUCHER);
  }

  ///
  ///Go to Refer Friends
  ///
  void goToRefeFriend() {
    Get.toNamed(ReferFriendsRouters.REFER_FRIENDS);
  }
}
