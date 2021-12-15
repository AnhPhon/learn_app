import 'package:get/get.dart';
import 'package:template/view/screen/voucher/voucher_details/voucher_details_page.dart';
import 'package:template/view/screen/voucher/voucher_page.dart';

class VoucherRouters {
  static const String VOUCHER = "/voucher";
  static const String DETAIL_VOUCHER = "/detail_voucher";

  static List<GetPage> voucherList = [
    GetPage(
      name: VOUCHER,
      page: () => VoucherPage(),
    ),
    GetPage(
      name: DETAIL_VOUCHER,
      page: () => DetailVoucherPage(),
    ),
  ];
}
