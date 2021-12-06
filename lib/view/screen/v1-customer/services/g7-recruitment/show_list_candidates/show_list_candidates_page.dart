import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/components/candicate_card.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/show_list_candidates/show_list_candicate_controller.dart';

class ShowListCandicatePage extends GetView<ShowListCandicateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Hồ sơ ứng tuyển"),
      body: GetBuilder(
        init: ShowListCandicateController(),
        builder: (ShowListCandicateController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SmartRefresher(
            controller: controller.refreshController,
            enablePullUp: true,
            onLoading: controller.onLoadMore,
            onRefresh: controller.onRefresh,
            footer: const ClassicFooter(
              loadingText: "Đang tải...",
              noDataText: "Không có dữ liệu",
              canLoadingText: 'Đang tải...',
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.danhSachUngTuyenList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            controller.onClickProfile(
                                dangKyViecMoiModel: controller
                                    .danhSachUngTuyenList[index]
                                    .idDangKyViecMoi!);
                          },
                          child: CandidateCard(
                            dangKyViecMoiResponse: controller
                                .danhSachUngTuyenList[index].idDangKyViecMoi,
                            showEmailAndPass: false,
                          ));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
