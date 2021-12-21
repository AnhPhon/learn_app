import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_smart_refresher.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/contract_list/reciprocal_list/reciprocal_list_controller.dart';

class ReciprocalListPage extends GetView<ReciprocalListController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAccount(),
      appBar: IZIAppBar(
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
        title: "Danh sách đối ứng",
      ),
      body: GetBuilder(
        init: ReciprocalListController(),
        builder: (ReciprocalListController controller) {
          return Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X * 3,
            ),
            constraints: BoxConstraints(
              minWidth: IZIDimensions.iziSize.width,
              minHeight: IZIDimensions.iziSize.height,
            ),
            color: ColorResources.BACKGROUND,
            child: IZISmartRefresher(
              onRefresh: controller.onRefresh,
              onLoading: controller.onLoading,
              refreshController: controller.refreshController,
              enablePullDown: true,
              isLoading: false,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      controller.goToReciprocalDetails();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: index == 0 ? IZIDimensions.SPACE_SIZE_4X : 0,
                        bottom: IZIDimensions.SPACE_SIZE_4X,
                        left: IZIDimensions.SPACE_SIZE_4X,
                        right: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: IZIDimensions.SPACE_SIZE_3X,
                        horizontal: IZIDimensions.SPACE_SIZE_3X,
                      ),
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        boxShadow: IZIOther().boxShadow,
                        borderRadius: BorderRadius.circular(
                          IZIDimensions.BORDER_RADIUS_3X,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Trải nghiệm 303 ",
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      color: ColorResources.BLACK,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "TST 3 triệu 2",
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      fontWeight: FontWeight.w600,
                                      color: ColorResources.BLACK,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Số tiền đối ứng : ",
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      color: ColorResources.BLACK,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "2.000.000 đ",
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      fontWeight: FontWeight.w600,
                                      color: ColorResources.BLACK,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
      widgetBottomSheet: //Button xác nhận
          Container(
        color: ColorResources.BACKGROUND,
        padding: EdgeInsets.fromLTRB(
          IZIDimensions.SPACE_SIZE_4X,
          0,
          IZIDimensions.SPACE_SIZE_4X,
          IZIDimensions.SPACE_SIZE_2X,
        ),
        child: IZIButton(
          margin: const EdgeInsets.all(0),
          onTap: () {
            controller.goToAddReciprocal();
          },
          label: "Thêm đối ứng",
        ),
      ),
    );
  }
}
