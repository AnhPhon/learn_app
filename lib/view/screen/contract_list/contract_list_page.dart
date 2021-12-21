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
import 'package:template/view/screen/contract_list/contract_list_controller.dart';

class ContractListPage extends GetView<ContactListController> {
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
          title: "Danh sách hợp đồng",
        ),
        body: GetBuilder(
          init: ContactListController(),
          builder: (ContactListController controller) {
            return Container(
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
                      onTap: () {},
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
                              child: Text(
                                "Trải nghiệm 303 ",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.BLACK,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: Text(
                                "Lãi / suất : 0.5 - Tiền lãi : 60.000",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.BLACK,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: Text(
                                "Thời hạn hợp đồng : 12/12/2021",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.BLACK,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: IZIDimensions.ONE_UNIT_SIZE * 55,
                                    child: IZIButton(
                                      borderRadius: IZIDimensions.BLUR_RADIUS_2X,
                                      withBorder: IZIDimensions.ONE_UNIT_SIZE * 2,
                                      type: IZIButtonType.OUTLINE,
                                      onTap: () {
                                        controller.onToContractDetail();
                                      },
                                      label: "Xem chi tiết",
                                      maxLine: 1,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: IZIDimensions.SPACE_SIZE_1X,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: IZIDimensions.SPACE_SIZE_1X,
                                        horizontal: IZIDimensions.SPACE_SIZE_1X,
                                      ),
                                      fontSizedLabel: IZIDimensions.FONT_SIZE_SPAN * .9,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: IZIDimensions.ONE_UNIT_SIZE * 55,
                                    child: IZIButton(
                                      borderRadius: IZIDimensions.BLUR_RADIUS_2X,
                                      onTap: () {
                                        controller.goToReciprocalList();
                                      },
                                      label: "Đối ứng",
                                      maxLine: 1,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: IZIDimensions.SPACE_SIZE_1X,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: IZIDimensions.SPACE_SIZE_1X,
                                        horizontal: IZIDimensions.SPACE_SIZE_1X,
                                      ),
                                      fontSizedLabel: IZIDimensions.FONT_SIZE_SPAN * .9,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: IZIDimensions.ONE_UNIT_SIZE * 55,
                                    child: IZIButton(
                                      borderRadius: IZIDimensions.BLUR_RADIUS_2X,
                                      withBorder: IZIDimensions.ONE_UNIT_SIZE * 2,
                                      type: IZIButtonType.OUTLINE,
                                      onTap: () {
                                        controller.goToListOfInterestPayments();
                                      },
                                      label: "DS trả lãi",
                                      maxLine: 1,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: IZIDimensions.SPACE_SIZE_1X,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: IZIDimensions.SPACE_SIZE_1X,
                                        horizontal: IZIDimensions.SPACE_SIZE_1X,
                                      ),
                                      fontSizedLabel: IZIDimensions.FONT_SIZE_SPAN * .9,
                                    ),
                                  ),
                                ),
                              ],
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
        ));
  }
}
