import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/home_routes.dart';

class HomeController extends GetxController {
  bool isVisibleWallet = false;
  final RefreshController refreshController = RefreshController();

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
  List<Map<String, dynamic>> dataMenu = [];

  @override
  void onInit() {
    dataMenu = [
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'lable': 'Nạp tiền',
      'icon': Icons.exit_to_app,
      'function': onToTransfersPage,
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'lable': 'Rút tiền',
      'icon': Icons.monetization_on,
      'function': onToTransfersPage,
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'lable': 'Voucher',
      'icon': Icons.card_giftcard_outlined,
      'function': onToTransfersPage,
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'lable': 'Giới thiệu bạn bè',
      'icon': Icons.supervised_user_circle_rounded,
      'function': onToTransfersPage,
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'lable': 'Chuyển tiền qua SĐT',
      'icon': Icons.mobile_screen_share,
      'function': onToTransfersPage
    },
  ];
  }

  ///
  /// go to transfers
  ///
  void onToTransfersPage() {
    Get.toNamed(
      HomeRoutes.TRANSFERS,
    );
  }

  ///
  /// On show visible wallet
  ///
  void onVisibleWallet() {
    isVisibleWallet = !isVisibleWallet;
    update();
  }

  void onToProduct(){
    Get.toNamed(
      HomeRoutes.PRODUCT,
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    refreshController.dispose();
    super.onClose();
  }
}
