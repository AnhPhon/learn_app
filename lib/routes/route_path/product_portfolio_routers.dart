import 'package:get/get.dart';
import 'package:template/view/screen/product_portfolio/product_portfolio_binding.dart';
import 'package:template/view/screen/product_portfolio/product_portfolio_page.dart';

class ProductPortfolioRouters {
  static const String PRODUCT_PORTFOLIO = "/product_portfolio";
  static List<GetPage> productPortfolioList = [
    GetPage(
      name: PRODUCT_PORTFOLIO,
      page: () => ProductPortfolioPage(),
      binding: ProductPortfolioBinding(),
    ),
  ];
}
