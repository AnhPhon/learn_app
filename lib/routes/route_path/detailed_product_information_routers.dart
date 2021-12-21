import 'package:get/get.dart';
import 'package:template/view/screen/product_portfolio/detailed_product_information/detailed_product_information_binding.dart';
import 'package:template/view/screen/product_portfolio/detailed_product_information/detailed_product_information_page.dart';

class DetailedProductInformationRouters {
  static const String DETAILED_PRODUCT_INFORMATION = "/detailed_product_information";
  static List<GetPage> detailedProductInformationList = [
    GetPage(
      name: DETAILED_PRODUCT_INFORMATION,
      page: () => DetailedProductInformationPage(),
      binding: DetailedProductInformationBinding(),
    ),
  ];
}
