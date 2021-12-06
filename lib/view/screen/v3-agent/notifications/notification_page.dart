import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/format/format_html_notification.dart';
import 'package:template/view/screen/v3-agent/notifications/notification_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class V3NotificationPage extends GetView<V3NotificationController> {
  const V3NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(title: "Thông báo"),
        body: GetBuilder(
          builder: (V3NotificationController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SmartRefresher(
              controller: controller.refreshController,
              enablePullUp: true,
              onLoading: controller.moreData,
              onRefresh: controller.onRefresh,
              footer: const ClassicFooter(
                loadingText: "Đang tải...",
                noDataText: "Không có dữ liệu",
                canLoadingText: 'Đang tải...',
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) {
                  return itemNotification(context, index: index);
                },
              ),
            );
          },
        ));
  }

  Widget itemNotification(BuildContext context, {required int index}) {
    return GestureDetector(
      onTap: () {
        controller.onClickItem(controller.notifications[index]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL)),
          child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
                color: controller.notifications[index].status == null
                    ? ColorResources.WHITE
                    : controller.notifications[index].status! != '0'
                        ? ColorResources.WHITE
                        : controller.notifications[index].status! == '0' &&
                                controller.notifications[index].idTaiKhoan
                                        .toString() ==
                                    "null"
                            ? ColorResources.WHITE
                            : ColorResources.PRIMARYCOLOR.withOpacity(0.3),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
                      child: FadeInImage.assetNetwork(
                        height: DeviceUtils.getScaledHeight(context, 1),
                        placeholder: Images.placeholder,
                        image: controller.notifications[index].hinhDaiDien!,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(Images.placeholder,
                              fit: BoxFit.cover,
                              height: DeviceUtils.getScaledHeight(context, 1));
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Text(
                            FormatHtmlNotification.formatHtml(
                                content: controller.notifications[index].tieuDe
                                    .toString()),
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.FONT_SIZE_LARGE),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Text(
                            FormatHtmlNotification.formatHtml(
                                content: controller.notifications[index].noiDung
                                    .toString()),
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: Dimensions.FONT_SIZE_SMALL),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  timeago.format(
                                      DateConverter.stringToLocalDate(controller
                                          .notifications[index].createdAt!)),
                                  locale: const Locale('vi')),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
