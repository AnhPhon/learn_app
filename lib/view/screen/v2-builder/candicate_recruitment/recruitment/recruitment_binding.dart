

import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_controller.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/history_recruitment_news_controller.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/recruitment_controller.dart';

class V2RecruitmentBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<V2RecruitmentController>(() => V2RecruitmentController());
    Get.lazyPut<V2HistoryRecruitmentNewsController>(() => V2HistoryRecruitmentNewsController());
    Get.lazyPut<AppBarController>(() => AppBarController());
  }
}