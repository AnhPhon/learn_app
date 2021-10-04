import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/drawer/about_page.dart';
import 'package:template/view/screen/v1-customer/home/home_page.dart';

import 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  
  static List<GetPage> list = [
    // custommer
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
    ),

    /// About
    GetPage(
      name: AppRoutes.V1ABOUT,
      page: () => AboutPage(),
    )

    // builder

    // agent

    // employee


    
  ];
}
