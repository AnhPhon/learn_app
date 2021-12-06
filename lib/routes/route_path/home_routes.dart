import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/view/screen/introduction/introduction_page.dart';
import 'package:template/view/screen/splash/splash_page.dart';

class HomeRoutes {

  
  //builder
  static const String V2_WORKFLOW_MANAGEMENT = '/v2_workflow_management';
  static const String V2_WORK_DONE = '/v2_work_done';

  static List<GetPage> list = [
    GetPage(
      name: V2_WORK_DONE,
      page: () => SplashPage(),
    ),

    GetPage(
      name: V2_WORKFLOW_MANAGEMENT,
      page: () => IntroductionPage(),
    ),
  ];

}
