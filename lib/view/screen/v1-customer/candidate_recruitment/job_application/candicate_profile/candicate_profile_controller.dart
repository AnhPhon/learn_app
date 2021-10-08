
import 'package:get/get.dart';

class V1CandicateProfileController extends GetxController{
    // Trạng thái hồ sơ data ảo
    bool statusProfile = false;


    void onViewProfile(){
      statusProfile = true;
      update();
    }

}