import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2ShorthandedGroup1Controller extends GetxController {
  String title = "Công việc đang cần người";

  String urlImage =
      "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg";

  List imageListWeight = [
    "https://www.gettyimages.pt/gi-resources/images/Homepage/Hero/PT/PT_hero_42_153645159.jpg",
  ];

  List imageListDraw = [];

  ///
  ///go to quotation g1 page
  ///
  void onQuotationG1PageClick() {
    Get.toNamed(AppRoutes.V2_QUOTATION_GROUP1);
  }
}
