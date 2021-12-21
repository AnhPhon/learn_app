import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_smart_refresher.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/notification/notification_controller.dart';

class NotificationPage extends GetView<NotificationController> {
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
        title: "Thông báo (${controller.soThongBao})",
      ),
      body: GetBuilder(
        init: NotificationController(),
        builder: (NotificationController controller) {
          return Container(
            constraints: BoxConstraints(
              minHeight: IZIDimensions.iziSize.height,
              minWidth: IZIDimensions.iziSize.width,
            ),
            decoration: const BoxDecoration(
              color: ColorResources.BACKGROUND,
            ),
            child: IZISmartRefresher(
              onRefresh: controller.onRefresh,
              onLoading: controller.onLoading,
              refreshController: controller.refreshController,
              enablePullDown: true,
              isLoading: false,
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.goToNotificationDetails();
                    },
                    child: IZICard(
                      marginCard: EdgeInsets.fromLTRB(
                        IZIDimensions.SPACE_SIZE_4X,
                        index == 0 ? IZIDimensions.SPACE_SIZE_4X : 0,
                        IZIDimensions.SPACE_SIZE_4X,
                        IZIDimensions.SPACE_SIZE_3X,
                      ),
                      icon: Icons.more_horiz_outlined,
                      cardType: IZICardType.CARD_NOTIFICATION,
                      row1Left: "Đầu tư",
                      row1Right: "Thứ ba, 16/11",
                      row2Left: "Hot Contest Title",
                      row3Left: "Lorem Ipsum is simply dummy text of the printing",
                      urlImage: "https://ngoclinhxanh.com/wp-content/uploads/2017/12/sam-day-ngoc-linh-kho-hong-dang-sam-kho-sam-day-kho-rung-samday-samdayngoclinh-ngoc-linh-xanh-ngoclinhxanh.jpg-8.jpg",
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
