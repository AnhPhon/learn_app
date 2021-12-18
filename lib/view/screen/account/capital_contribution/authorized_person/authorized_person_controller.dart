

import 'package:get/get.dart';
import 'package:template/routes/route_path/account_routes.dart';

class AuthorizedPersonController extends GetxController {

  List<String> genders = [
    "Nam",
    'Nữ',
    'Khác',
  ];
    final List<String> authorizedPersons = [
    'Nguyễn Văn A',
    'Nguyễn Văn B',
    'Nguyễn Văn C',
  ];
  // Variable
  String? authorizedPerson;
  String gender = 'Khác';


  void onChangedGender(String val){
    gender = val;
    update();
  }


  void onChangedAuthorizedPerson(String val){
    authorizedPerson = val;
    update();
  }

  void onBack(){
    Get.back();
  }

  void onToContactInfomation(){
    Get.toNamed(AccountRoutes.CAPITAL_CONTRIBUTION_CONTRACT_INFORMATION);
  }


  
}
