import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/notifications/detail_notification/detail_notification_controller.dart';
import 'package:template/view/screen/v3-agent/notifications/detail_notification/detail_notification_controller.dart';


class V3DetailNotificationPage extends GetView<V3DetailNotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Chi tiết thông báo",
      ),
      body: GetBuilder<V3DetailNotificationController>(
          init: V3DetailNotificationController(),
          builder: (V3DetailNotificationController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: controller.thongBaoModel.hinhDaiDien!,
                    child: Container(
                      width: DeviceUtils.getScaledWidth(context, 1),
                      height: DeviceUtils.getScaledHeight(context, 0.3),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            controller.thongBaoModel.hinhDaiDien.toString(),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: controller.thongBaoModel.hinhDaiDien.toString().isEmpty || 
                      controller.thongBaoModel.hinhDaiDien.toString().contains('null') ? 
                      Image.asset(Images.notifications, fit: BoxFit.cover,) : 
                      Image.network(controller.thongBaoModel.hinhDaiDien.toString(),fit: BoxFit.cover,),
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
