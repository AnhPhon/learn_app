import 'package:get/get.dart';
import 'package:template/view/screen/shopping_cart/choose_voucher/choose_voucher_binding.dart';
import 'package:template/view/screen/shopping_cart/choose_voucher/choose_voucher_page.dart';
import 'package:template/view/screen/shopping_cart/shopping_cart_binding.dart';
import 'package:template/view/screen/shopping_cart/shopping_cart_page.dart';

class ShoppingCartRouters {
  static const SHOPPING_CART = "/shoppping_cart";
  static const CHOOSE_VOUCHER = "/choose_voucher";

  static List<GetPage> shopppingCartList = [
    GetPage(
      name: SHOPPING_CART,
      page: () => ShoppingCartPage(),
      binding: ShoppingCartBinding(),
    ),
    GetPage(
      name: CHOOSE_VOUCHER,
      page: () => ChooseVoucherPage(),
      binding: ChooseVoucherBinding(),
    ),
  ];
}
