import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/drawer/Benefits.dart';
import 'package:template/view/screen/v1-customer/drawer/about_page.dart';
import 'package:template/view/screen/v1-customer/drawer/rights_and_obligations.dart';
import 'package:template/view/screen/v1-customer/drawer/terms_and_policy.dart';
import 'package:template/view/screen/v1-customer/drawer/usage_procedure.dart';
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
    ),
  GetPage(
    name: AppRoutes.V1BENEFITS,
    page: () => Benefits(),
  ),
  GetPage(
    name: AppRoutes.V1TERMANDPOLICY,
    page: () => TermsAndPolicy(),
  ),
  GetPage(
    name: AppRoutes.V1USAGEPROCEDURE,
    page: () => UsageProcedure(),
  ),
  GetPage(
    name: AppRoutes.V1OBLIGATIONS,
    page: () => RightsAndObligations(),
  )

    // builder

    // agent

    // employee


    
  ];
}
