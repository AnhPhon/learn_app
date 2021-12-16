

import 'package:get/get.dart';

class AccountInfomationController extends GetxController {

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

  
}
