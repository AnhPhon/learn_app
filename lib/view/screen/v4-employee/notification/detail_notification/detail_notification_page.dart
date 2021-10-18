import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

import 'package:template/view/screen/v4-employee/notification/detail_notification/detail_notification_controller.dart';

class V4DetailNotificationPage extends GetView<V4DetailNotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Chi tiết thông báo",
      ),
      body: GetBuilder<V4DetailNotificationController>(
          init: V4DetailNotificationController(),
          builder: (V4DetailNotificationController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(
                  Dimensions.PADDING_SIZE_LARGE,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_LARGE,
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_LARGE,
                      ),
                      decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_SMALL,
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 2,
                            color: ColorResources.BLACK.withAlpha(30),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.notifications_active_outlined,
                                    size: Dimensions.ICON_SIZE_LARGE,
                                  ),
                                  Text(
                                    'Tiêu đề:',
                                    style: Dimensions.fontSizeStyle18w600(),
                                  ),
                                ],
                              ),
                              Text(controller.formatDateTime(
                                dateTime: controller.thongBaoModel.createdAt!,
                              ))
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),
                          Text(
                            controller.thongBaoModel.tieuDe!,
                            style: Dimensions.fontSizeStyle18(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          Text(
                            'Nội Dung:',
                            style: Dimensions.fontSizeStyle18w600(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),
                          Text(
                            controller.thongBaoModel.noiDung!,
                            style: Dimensions.fontSizeStyle16(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
