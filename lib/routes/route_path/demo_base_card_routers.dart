import 'package:get/get.dart';
import 'package:template/view/screen/mock/demo_base_card/demo_base_card_page.dart';

class DemoBaseCardRouter {
  static const String DEMO_BASE_CARD = "/demo_base_card";
  static List<GetPage> demoBaseCardList = [
    GetPage(
      name: DEMO_BASE_CARD,
      page: () => DemoBaseCardPage(),
    ),
  ];
}
