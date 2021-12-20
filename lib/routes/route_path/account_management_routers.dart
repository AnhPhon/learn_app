import 'package:get/get.dart';
import 'package:template/view/screen/account_management/account_management_binding.dart';
import 'package:template/view/screen/account_management/account_management_page.dart';
import 'package:template/view/screen/account_management/bank_transfer/bank_transfer_binding.dart';
import 'package:template/view/screen/account_management/bank_transfer/bank_transfer_page.dart';
import 'package:template/view/screen/account_management/recharge/recharge_binding.dart';
import 'package:template/view/screen/account_management/recharge/recharge_management_page.dart';
import 'package:template/view/screen/account_management/transaction_confirmation/transaction_confirmation_binding.dart';
import 'package:template/view/screen/account_management/transaction_confirmation/transaction_confirmation_page.dart';
import 'package:template/view/screen/account_management/withdrawal/withdrawal_binding.dart';
import 'package:template/view/screen/account_management/withdrawal/withdrawal_page.dart';

class AccountManagementRouter {
  static const String ACCOUNT_MANAGEMENT = "/account_management";
  static const String WITHDRAWAL = "/withdrawal";
  static const String RECHARGE = "/recharge";
  static const String BANK_TRANSFER = "/bank_transger";
  static const String TRANSACTION_CONFIRMATION = "/transaction_confirmation";

  static List<GetPage> accountManagementList = [
    GetPage(
      name: ACCOUNT_MANAGEMENT,
      page: () => AccountManagementPage(),
      binding: AccountManagementBinding(),
    ),
    GetPage(
      name: WITHDRAWAL,
      page: () => WithdrawalPage(),
      binding: WithdrawalBinding(),
    ),
    GetPage(
      name: RECHARGE,
      page: () => RechargePage(),
      binding: RechargeBinding(),
    ),
    GetPage(
      name: BANK_TRANSFER,
      page: () => BankStansferPage(),
      binding: BankTransferBinding(),
    ),
    GetPage(
      name: TRANSACTION_CONFIRMATION,
      page: () => TransactionConfirmationPage(),
      binding: TransactionConfirmationBinding(),
    ),
  ];
}
