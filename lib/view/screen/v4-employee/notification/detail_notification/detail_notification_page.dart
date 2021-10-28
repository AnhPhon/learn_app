import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/widgets/fade_in_image.dart';

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: DeviceUtils.getScaledWidth(context, 1),
                    height: DeviceUtils.getScaledHeight(context, 0.3),
                    child: FadeInImageCustom(
                      height: DeviceUtils.getScaledHeight(context, 0.3),
                      urlImage: controller.thongBaoModel.hinhDaiDien.toString(),
                      width: DeviceUtils.getScaledWidth(context, 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        0,
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_SMALL),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.watch_later_outlined,
                        ),
                        const SizedBox(
                          width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),
                        Text(
                          controller.formatDateTime(
                            dateTime:
                                controller.thongBaoModel.createdAt.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.thongBaoModel.tieuDe!,
                          style: const TextStyle(
                            color: ColorResources.BLACK,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_LARGE,
                        ),
                        Text(
                          controller.thongBaoModel.noiDung!,
                          style: Dimensions.fontSizeStyle16(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_LARGE * 1.5,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
