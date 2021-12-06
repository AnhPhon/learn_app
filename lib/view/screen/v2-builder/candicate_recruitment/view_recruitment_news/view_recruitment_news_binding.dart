

import 'package:get/get.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/view_recruitment_news/view_recruitment_news_controller.dart';

class V2ViewRecruitmentNewsBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<V2ViewRecruitmentNewsController>(() => V2ViewRecruitmentNewsController());
  }
}