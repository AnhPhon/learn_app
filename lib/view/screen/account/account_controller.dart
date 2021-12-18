import 'package:get/get.dart';
import 'package:template/routes/route_path/account_routes.dart';

class AccountController extends GetxController {




  void onToAccountInformation(){
    Get.toNamed(AccountRoutes.ACCOUNT_INFOMATION);
  }

  void onToCapitalContribution(){
    Get.toNamed(AccountRoutes.CAPITAL_CONTRIBUTION);
  }

  void onToCapitalWithdDrawal(){
    Get.toNamed(AccountRoutes.CONTRACT_DETAIL);
  }

  
}
