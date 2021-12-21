import 'package:get/get.dart';
import 'package:template/view/screen/transfers/contact/contact_binding.dart';
import 'package:template/view/screen/transfers/contact/contact_page.dart';
import 'package:template/view/screen/transfers/transfers_confirm/transfers_confirm_binding.dart';
import 'package:template/view/screen/transfers/transfers_confirm/transfers_confirm_page.dart';
import 'package:template/view/screen/transfers/transfers_detail/transfers_detail_binding.dart';
import 'package:template/view/screen/transfers/transfers_detail/transfers_detail_page.dart';
import 'package:template/view/screen/transfers/transfers_status/fail/transfers_fail_binding.dart';
import 'package:template/view/screen/transfers/transfers_status/fail/transfers_fail_page.dart';
import 'package:template/view/screen/transfers/transfers_status/transfers_success_binding.dart';
import 'package:template/view/screen/transfers/transfers_status/transfers_success_page.dart';

class TransfersRouters {
  static const String CONTACT = "/contact";
  static const String TRANSFERS_DETAIL = "/transfers_detail";
  static const String TRANSFERS_CONFIRM = "/transfers_confirm";
  static const String TRANSFERS_SUCCESS = "/transfers_success";
  static const String TRANSFERS_FAIL = "/transfers_fail";

  static List<GetPage> transfersList = [
    GetPage(
      name: CONTACT,
      page: () => ContactPage(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: TRANSFERS_DETAIL,
      page: () => TransfersDetailPage(),
      binding: TransfersDetailBinding(),
    ),
    GetPage(
      name: TRANSFERS_CONFIRM,
      page: () => TransfersConfirmPage(),
      binding: TransfersConfirmBinding(),
    ),
    GetPage(
      name: TRANSFERS_SUCCESS,
      page: () => TransfersSuccessPage(),
      binding: TransfersSuccessBinding(),
    ),
    GetPage(
      name: TRANSFERS_FAIL,
      page: () => TransfersFailPage(),
      binding: TransfersFailBinding(),
    ),
   
  ];
}
