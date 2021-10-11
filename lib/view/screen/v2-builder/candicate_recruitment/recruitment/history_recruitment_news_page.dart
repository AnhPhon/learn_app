import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_controller.dart';
import 'package:template/view/basewidget/appbar/search_app_bar.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/recruiment_news_card.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/history_recruitment_news_controller.dart';

class V2HistoryRectuitmentNewsPage extends GetView<V2HistoryRecruitmentNewsController>{


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AppBarController(),
      builder: (AppBarController appbar) {
        return GetBuilder(
          init: V2HistoryRecruitmentNewsController(),
          builder: (V2HistoryRecruitmentNewsController controller) {
            return Scaffold(
              appBar: SearchAppBarWidget(title: "Tin đã lưu", searchController: controller.searchController),
              body: recruitment(context, controller: controller)
            );
          },
        );
      },
    );
  }


  Widget recruitment(BuildContext context,{required V2HistoryRecruitmentNewsController controller}){
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            controller.onClickRecruitmentNews();
          },
          child: V2RecruimentNewsCard(index: index,)
        );
      },
    );
  }

}