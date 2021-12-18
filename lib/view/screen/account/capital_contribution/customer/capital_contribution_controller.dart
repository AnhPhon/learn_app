

import 'package:get/get.dart';
import 'package:template/routes/route_path/account_routes.dart';

class CapitalContributionController extends GetxController {

  List<String> genders = [
    "Nam",
    'Nữ',
    'Khác',
  ];
  String gender = 'Khác';

  void onChangedGender(String val){
    gender = val;
    update();
  }

  void onBack(){
    Get.back();
  }


  void onToCapitalContributionCustomer(){
    Get.toNamed(AccountRoutes.CAPITAL_CONTRIBUTION_AUTHORIZED_PERSON);
  }

  
}
