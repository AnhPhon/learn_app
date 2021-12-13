import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/view/screen/home/home_binding.dart';
import 'package:template/view/screen/home/home_page.dart';

class HomeRoutes {
    static const String HOME = '/home';

  static List<GetPage> list = [
    GetPage(
      name: HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
