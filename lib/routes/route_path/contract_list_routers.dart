import 'package:get/get.dart';
import 'package:template/view/screen/contract_list/contract_list_binding.dart';
import 'package:template/view/screen/contract_list/contract_list_page.dart';
import 'package:template/view/screen/contract_list/list_of_interest_payments/list_of_interest_payments_binding.dart';
import 'package:template/view/screen/contract_list/list_of_interest_payments/list_of_interest_payments_page.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/add_reciprocal.dart/add_reciprocal_binding.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/add_reciprocal.dart/add_reciprocal_page.dart';

import 'package:template/view/screen/contract_list/reciprocal_list/reciprocal_details/reciprocal_details_binding.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/reciprocal_details/reciprocal_details_page.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/reciprocal_list_binding.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/reciprocal_list_page.dart';

class ContractListRouters {
  static const String CONTRACT_LIST = "/contract_list";
  static const String LIST_OF_INTEREST_PAYMENTS = "/list_of_interest_payments";
  static const String RECIPROCAL_LIST = "/reciprocal_list";
  static const String RECIPROCAL_DETAILS = "/reciprocal_details";
  static const String ADD_RECIPROCAL = "/add_reciprocal";

  static List<GetPage> contractList = [
    GetPage(
      name: CONTRACT_LIST,
      page: () => ContractListPage(),
      binding: ContractListBinding(),
    ),
    GetPage(
      name: LIST_OF_INTEREST_PAYMENTS,
      page: () => ListOfInterestPaymentsPage(),
      binding: ListOfInterestPaymentsBinding(),
    ),
    GetPage(
      name: RECIPROCAL_LIST,
      page: () => ReciprocalListPage(),
      binding: ReciprocalListBinding(),
    ),
    GetPage(
      name: RECIPROCAL_DETAILS,
      page: () => ReciprocalDetailsPage(),
      binding: ReciprocalDetailsBinding(),
    ),
    GetPage(
      name: ADD_RECIPROCAL,
      page: () => AddReciprocalPage(),
      binding: AddReciprocalBinding(),
    ),
  ];
}
