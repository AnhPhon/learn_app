import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/view/basewidget/appbar/app_bar_controller.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/recruiment_news_card.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/history_recruitment_news_controller.dart';

import 'app_bar_search_cadidate.dart';

class V2HistoryRectuitmentNewsPage
    extends GetView<V2HistoryRecruitmentNewsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: V2HistoryRecruitmentNewsController(),
        builder: (V2HistoryRecruitmentNewsController controller) {
          return GetBuilder(
            init: AppBarController(),
            builder: (AppBarController appbar) {
              return Scaffold(
                  appBar: SearchAppBarCardidate(),
                  body: recruitment(context, controller: controller));
            },
          );
        });
  }

  Widget recruitment(BuildContext context,
      {required V2HistoryRecruitmentNewsController controller}) {
    if (controller.isLoading) {
      const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SmartRefresher(
      controller: controller.refreshController,
      scrollController: controller.scrollController,
      enablePullUp: true,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      footer: const ClassicFooter(
        loadingText: "Đang tải...",
        noDataText: "Không có dữ liệu",
        canLoadingText: 'Đang tải...',
      ),
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.tuyenDungListSearch.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                controller.onClickRecruitmentNews(
                    tuyendung: controller.tuyenDungListSearch[index]);
              },
              child: V2RecruimentNewsCard(
                tuyenDungResponse: controller.tuyenDungListSearch[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
