import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/recruiment_news_card.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/recruitment_controller.dart';

class V2RecruitmentPage extends GetView<V2RecruitmentController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: V2RecruitmentController(),
      builder: (V2RecruitmentController controller) {
        return Scaffold(
          appBar: AppBarWidget(
            title: "Tin tuyển dụng",
            action: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    color: ColorResources.WHITE,
                    onPressed: () {
                      controller.onChangedSearch();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.history),
                    color: ColorResources.WHITE,
                    onPressed: () {
                      controller.onClickHistory();
                    },
                  ),
                ],
              )
            ],
          ),
          body: SafeArea(
              child: Column(
            children: [
              tabBarWidget(context, controller: controller),
              if (controller.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
              else
                recruitment(context, controller: controller)
            ],
          )),
        );
      },
    );
  }

  Widget recruitment(BuildContext context,
      {required V2RecruitmentController controller}) {
    return Expanded(
      child: SmartRefresher(
        controller: controller.refreshControllerList![controller.currentIndex],
        enablePullUp: true,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        footer: const ClassicFooter(
          loadingText: "Đang tải...",
          noDataText: "Không có dữ liệu",
          canLoadingText: "Kéo lên để tải thêm dữ liệu",
        ),
        child: ListView.builder(
          itemCount: controller.tuyenDungListModel.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  controller.onClickRecruitmentNews(
                      tuyendung: controller.tuyenDungListModel[index]);
                },
                child: V2RecruimentNewsCard(
                  tuyenDungResponse: controller.tuyenDungListModel[index],
                ));
          },
        ),
      ),
    );
  }

  // Khi chọn tab
  Widget onSelectedTab(
      {required BuildContext context,
      required V2RecruitmentController controller,
      required String title,
      required int index,
      bool? isMT = false,
      bool? isSelectedMN = false}) {
    return GestureDetector(
      onTap: () {
        controller.onChangeTab(index: index);
      },
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        width: DeviceUtils.getScaledWidth(context, 0.9).roundToDouble() / 3,
        decoration: BoxDecoration(
          borderRadius: isMT!
              ? null
              : isSelectedMN!
                  ? const BorderRadius.only(
                      topRight: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
                      bottomRight:
                          Radius.circular(Dimensions.BORDER_RADIUS_SMALL))
                  : const BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.BORDER_RADIUS_SMALL),
                      bottomLeft:
                          Radius.circular(Dimensions.BORDER_RADIUS_SMALL)),
          color: controller.currentIndex == index
              ? ColorResources.PRIMARYCOLOR
              : ColorResources.WHITE,
          border: isMT
              ? const Border(
                  top: BorderSide(color: ColorResources.PRIMARYCOLOR),
                  bottom: BorderSide(color: ColorResources.PRIMARYCOLOR))
              : Border.all(color: ColorResources.PRIMARYCOLOR),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: controller.currentIndex == index
                ? ColorResources.WHITE
                : ColorResources.BLACK,
            fontWeight: controller.currentIndex == index
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  ///
  /// Thanh tab bar
  ///
  Widget tabBarWidget(BuildContext context,
      {required V2RecruitmentController controller}) {
    return Container(
      alignment: Alignment.center,
      width: DeviceUtils.getScaledWidth(context, 1),
      height: DeviceUtils.getScaledHeight(context, 0.1),
      child: Container(
          alignment: Alignment.center,
          width: DeviceUtils.getScaledWidth(context, 0.9).roundToDouble(),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate(
                  controller.loaiTinTuyenDung.length,
                  (index) => onSelectedTab(
                      controller: controller,
                      context: context,
                      title:
                          controller.loaiTinTuyenDung[index].tieuDe.toString(),
                      index: index,
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      isMT: index == 1 ? true : false,
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      isSelectedMN: index == 2 ? true : false))
            ],
          )),
    );
  }
}
