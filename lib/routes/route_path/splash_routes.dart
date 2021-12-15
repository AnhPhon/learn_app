


import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/view/screen/onboarding/onboarding_binding.dart';
import 'package:template/view/screen/onboarding/onboarding_page.dart';
import 'package:template/view/screen/splash/splash_binding.dart';
import 'package:template/view/screen/splash/splash_page.dart';

class SplashRoutes {
  static const String SPLASH = '/splash';
  static const String ON_BOARDING = '/onboarding';

  static List<GetPage> list = [
     GetPage(
      name: SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: ON_BOARDING,
      page: () => OnBoardingPage(),
      binding: OnBoardingBinding(),
    ),
  ];


}
