import 'package:get/get.dart';
import 'package:template/view/screen/account/account_information.dart/account_infomation_binding.dart';
import 'package:template/view/screen/account/account_information.dart/account_information_page.dart';

class AccountRoutes {
  static const String ACCOUNT_INFOMATION = '/account_information';

  static List<GetPage> list = [
    GetPage(
      name: ACCOUNT_INFOMATION,
      page: () => AccountInfomationPage(),
      binding: AccountInfomationBinding(),
    ),
  ];
}
