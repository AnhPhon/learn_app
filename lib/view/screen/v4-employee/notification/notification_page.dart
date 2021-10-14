import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/color_resources.dart';
// ignore: unused_import
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

import 'package:template/view/screen/v4-employee/notification/components/appbar_notifcation_page.dart';

import 'package:template/view/screen/v4-employee/notification/notification_controller.dart';

class V4NotificationPage extends GetView<V4NotificationController> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: ColorResources.HOME_BG,
      appBar: const AppBarWidget(
        title: 'Thông Báo',
      ),
      body: GetBuilder<V4NotificationController>(
          init: V4NotificationController(),
          builder: (V4NotificationController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_SMALL,
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              child:

                  //ListView Notification
                  _listViewNotification(),
            );
          }),
    );
  }

  ///
  /// ListView Notification
  ///
  Widget _listViewNotification() {
    return SmartRefresher(
      onLoading: controller.onLoading,
      onRefresh: controller.onRefresh,
      controller: controller.refreshController,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.thongbaoModelList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: GestureDetector(
              onTap: () {
                controller.onClickDetailNotification(index: index);
              },
              child: Container(
                width: DeviceUtils.getScaledWidth(context, 1),
                decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius: BorderRadius.circular(
                    Dimensions.BORDER_RADIUS_DEFAULT,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                      color: ColorResources.BLACK.withAlpha(20),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    const Positioned(
                      top: Dimensions.PADDING_SIZE_LARGE,
                      left: Dimensions.PADDING_SIZE_SMALL,
                      child: Icon(
                        Icons.notifications_active_outlined,
                        size: Dimensions.ICON_SIZE_LARGE,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        Dimensions.PADDING_SIZE_LARGE,
                        Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        Dimensions.PADDING_SIZE_LARGE,
                      ),
                      width: DeviceUtils.getScaledWidth(context, 0.85),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tiêu đề thông báo
                          Wrap(
                            children: [
                              Text(
                                controller.thongbaoModelList[index].tieuDe!,
                                style: const TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),

                          //Nội dung thông báo
                          Wrap(
                            children: [
                              Text(
                                controller.thongbaoModelList[index].noiDung!,
                                style: Dimensions.fontSizeStyle16(),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),

                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),

                          //Thời gian thông báo
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              //Đợi update trường date ở model
                              Text(
                                controller.formatDateTime(
                                  dateTime: controller
                                      .thongbaoModelList[index].createdAt!,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
