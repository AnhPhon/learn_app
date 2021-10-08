
import 'package:get/get.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/create/g7_recruitment_controller.dart';

class V1G7RecruitmentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<V1G7RecruitmentController>(() => V1G7RecruitmentController());
  }

}