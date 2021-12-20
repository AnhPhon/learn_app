import 'package:get/get.dart';
import 'package:template/view/screen/account/account_information.dart/account_infomation_binding.dart';
import 'package:template/view/screen/account/account_information.dart/account_information_page.dart';
import 'package:template/view/screen/account/capital_contribution/authorized_person/authorized_person_binding.dart';
import 'package:template/view/screen/account/capital_contribution/authorized_person/authorized_person_page.dart';
import 'package:template/view/screen/account/capital_contribution/capital_contribution_confirmation.dart/capital_contribution_confirmation_binding.dart';
import 'package:template/view/screen/account/capital_contribution/capital_contribution_confirmation.dart/capital_contribution_confirmation_page.dart';
import 'package:template/view/screen/account/capital_contribution/contract_information/contract_information_binding.dart';
import 'package:template/view/screen/account/capital_contribution/contract_information/contract_information_page.dart';
import 'package:template/view/screen/account/capital_contribution/contract_term/contract_term_binding.dart';
import 'package:template/view/screen/account/capital_contribution/contract_term/contract_term_page.dart';
import 'package:template/view/screen/account/capital_contribution/customer/capital_contribution_binding.dart';
import 'package:template/view/screen/account/capital_contribution/customer/capital_contribution_page.dart';
import 'package:template/view/screen/account/contract/contract_detail_confirmation_binding.dart';
import 'package:template/view/screen/account/contract/contract_detail_confirmation_page.dart';

class AccountRoutes {
    static const String ACCOUNT_INFOMATION = '/account_information';
    static const String CAPITAL_CONTRIBUTION = '/capital_contribution';
    static const String CAPITAL_CONTRIBUTION_AUTHORIZED_PERSON = '/capital_contribution_authorized_person';
    static const String CAPITAL_CONTRIBUTION_CONTRACT_INFORMATION = '/capital_contribution_contract_information';
    static const String CAPITAL_CONTRIBUTION_CONTRACT_TERM = '/capital_contribution_contract_term';
    static const String CAPITAL_CONTRIBUTION_CONFIRMATION = '/capital_contribution_confirmation';
    

  static List<GetPage> list = [
    GetPage(
      name: ACCOUNT_INFOMATION,
      page: () => AccountInfomationPage(),
      binding: AccountInfomationBinding(),
    ),
    GetPage(
      name: CAPITAL_CONTRIBUTION,
      page: () => CapitalContributionPage(),
      binding: CapitalContributionBinding(),
    ),
    GetPage(
      name: CAPITAL_CONTRIBUTION_AUTHORIZED_PERSON,
      page: () => AuthorizedPersonPage(),
      binding: AuthorizedPersonBinding(),
    ),
    GetPage(
      name: CAPITAL_CONTRIBUTION_CONTRACT_INFORMATION,
      page: () => ContractInformationPage(),
      binding: ContractInformationBinding(),
    ),
    GetPage(
      name: CAPITAL_CONTRIBUTION_CONTRACT_TERM,
      page: () => ContractTermPage(),
      binding: ContractTermBinding(),
    ),
    GetPage(
      name: CAPITAL_CONTRIBUTION_CONFIRMATION,
      page: () => CapitalContributionConfirmationPage(),
      binding: CapitalContributionConfirmationBinding(),
    ),
    
    
  ];
}
