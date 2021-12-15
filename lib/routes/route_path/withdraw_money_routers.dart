import 'package:get/get.dart';
import 'package:template/view/screen/withdraw_money/withdraw_money_page.dart';

class WithdrawMoneyRouters {
  static const String WITHDRAW_MONEY = "/withdraw_money";
  static List<GetPage> withdrawMoneyList = [
    GetPage(
      name: WITHDRAW_MONEY,
      page: () => WithdrawMoneyPage(),
    ),
  ];
}
