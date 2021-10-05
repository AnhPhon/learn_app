import 'package:get/get.dart'; 
import 'package:template/view/screen/auth/auth_page.dart';
import 'package:template/view/screen/introduction/introduction_page.dart';
import 'package:template/view/screen/login/login_page.dart';
import 'package:template/view/screen/splash/splash_page.dart';

import 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  
  static List<GetPage> list = [
    // custommer
    

    // builder

    // agent

    // employee


    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
    ),
    GetPage(
      name: AppRoutes.AUTH,
      page: () => AuthPage(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
    ),
    
    GetPage(
      name: AppRoutes.INTRO,
      page: () => IntroductionPage(),
    ), 
  ];
}
