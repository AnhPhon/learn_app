import 'package:flutter/material.dart';
import 'package:template/routes/route_path/Home_routes.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/notification_routers.dart';
import 'package:template/routes/route_path/product_portfolio_routers.dart';

class HomeController extends GetxController {
  bool isVisibleWallet = false;

  final data = [
    'https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg',
    'https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg',
    'https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg',
    'https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg',
    'https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg',
    'https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg',
    'https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg',
    'https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg',
  ];
  final dataMenu = [
    {'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg", 'lable': 'Nạp tiền', 'icon': Icons.exit_to_app},
    {'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg", 'lable': 'Rút tiền', 'icon': Icons.monetization_on},
    {'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg", 'lable': 'Voucher', 'icon': Icons.card_giftcard_outlined},
    {'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg", 'lable': 'Giới thiệu bạn bè', 'icon': Icons.supervised_user_circle_rounded},
    {'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg", 'lable': 'Chuyển tiền qua SĐT', 'icon': Icons.mobile_screen_share},
  ];

  @override
  void onInit() {}

  ///
  /// On show visible wallet
  ///
  void onVisibleWallet() {
    isVisibleWallet = !isVisibleWallet;
    update();
  }

  ///
  ///Go to notificaions
  ///
  void gotToNotification() {
    Get.toNamed(NotificationRouters.NOTIFICATION);
  }

  ///
  ///Go to Product Portfolio
  ///
  void goToProductPortfolio() {
    Get.toNamed(ProductPortfolioRouters.PRODUCT_PORTFOLIO);
  }
}
