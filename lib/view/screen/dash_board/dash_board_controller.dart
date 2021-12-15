import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/view/screen/%1Daccount/account_page.dart';
import 'package:template/view/screen/home/home_page.dart';

class DashBoardController extends GetxController {


  final List<Map<String, dynamic>> pages = [
    {
      'label':"Trang chủ",
      'icon': Icons.home,
      'page': HomePage(),
    },
    {
      'label':"Góp vốn",
      'icon':Icons.monetization_on,
      'page': HomePage(),
    },
    {
      'label':"Giỏ hàng",
      'icon':Icons.shopping_cart,
      'page': HomePage(),
    },
    {
      'label':"Tin tức",
      'icon':CupertinoIcons.news_solid,
      'page': HomePage(),
    },
    {
      'label':"Tài khoản",
      'icon':Icons.account_circle,
      'page': AccountPage(),
    },
  ];

  DateTime? currentBackPressTime;


  RxInt currentIndex = 0.obs;
  double sizeIcon = 24.0;
  // late AnimationController controller;
  // late Animation<double> animationZoom;



  ///
  ///Thay đổi page
  ///
  void onChangedPage(int index){    
    // controller.forward();
    currentIndex.value = index;
    update();
  }


  Future<bool> onDoubleBack() { 
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null || 
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      print(currentBackPressTime);
      IZIAlert.info(message: "Bạn muốn thoát ứng dụng");
      return Future.value(false);
    }
    return Future.value(true);
  }

  
}
