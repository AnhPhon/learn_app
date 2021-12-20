

import 'package:get/get.dart';
import 'package:template/routes/route_path/account_routes.dart';

class ContractInformationController extends GetxController {

  final List<String> contractTypes = [
    'Trải nghiệm 303',
    'Trải nghiệm 312',
    'Trải nghiệm 401',
  ];
  // Variable
  String? contractType;


  void onChangedContractType(String val){
    contractType = val;
    update();
  }

  void onBack(){
    Get.back();
  }

  void onToContractTerm(){
    Get.toNamed(AccountRoutes.CAPITAL_CONTRIBUTION_CONTRACT_TERM);
  }


  
}
