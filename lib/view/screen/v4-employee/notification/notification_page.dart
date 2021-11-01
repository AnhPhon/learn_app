import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';

import 'package:template/view/screen/v4-employee/notification/notification_controller.dart';

class V4NotificationPage extends GetView<V4NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.HOME_BG,
      appBar: const AppBarWidget(
        isNotBack: true,
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
      enablePullUp: true,
      onLoading: controller.onLoading,
      onRefresh: controller.onRefresh,
      controller: controller.refreshController,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.thongbaoModelList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            child: GestureDetector(
              onTap: () {
                controller.onClickDetailNotification(index: index);
              },
              child: Container(
                width: DeviceUtils.getScaledWidth(context, 1),
                height: DeviceUtils.getScaledHeight(context, 0.13),
                decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius: BorderRadius.circular(
                    Dimensions.BORDER_RADIUS_EXTRA_SMALL,
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
                    //IÊU ĐỀ THÔNG BÁO
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                        Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                        Dimensions.PADDING_SIZE_LARGE,
                        Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        Dimensions.PADDING_SIZE_LARGE,
                      ),
                      width: DeviceUtils.getScaledWidth(context, 0.7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                controller.thongbaoModelList[index].tieuDe!,
                                style: const TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
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
                        ],
                      ),
                    ),

                    //THỜI GIAN THÔNG BÁO
                    Positioned(
                      right: Dimensions.PADDING_SIZE_LARGE,
                      bottom: Dimensions.PADDING_SIZE_SMALL,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.date_range,
                            color: ColorResources.BLACK.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),
                          //Thời gian
                          Text(
                            controller.formatDateTime(
                              dateTime: controller
                                  .thongbaoModelList[index].createdAt!,
                            ),
                            style: TextStyle(
                              color: ColorResources.BLACK.withOpacity(0.6),
                            ),
                          )
                        ],
                      ),
                    ),
                    //HÌNH ẢNH THÔNG BÁO
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: DeviceUtils.getScaledHeight(context, 0.15),
                        width: DeviceUtils.getScaledWidth(context, 0.28),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                            ),
                            bottomLeft: Radius.circular(
                              Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                            ),
                          ),
                        ),
                        child: FadeInImageCustom(
                          height: DeviceUtils.getScaledHeight(context, 0.15),
                          urlImage: controller
                              .thongbaoModelList[index].hinhDaiDien
                              .toString(),
                          width: DeviceUtils.getScaledWidth(context, 0.28),
                        ),
                      ),
                    ),
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
