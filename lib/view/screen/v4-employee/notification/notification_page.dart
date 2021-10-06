import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
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
            // if (controller.isLoading) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_SMALL,
                horizontal: Dimensions.PADDING_SIZE_LARGE,
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
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: DeviceUtils.getScaledWidth(context, 1),
            height: DeviceUtils.getScaledHeight(context, 0.2),
            decoration: BoxDecoration(
              color: index == 2
                  ? ColorResources.UNREAD_NOTICE
                  : ColorResources.WHITE,
              borderRadius: BorderRadius.circular(9),
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
                // ignore: sized_box_for_whitespace
                Container(
                  width: DeviceUtils.getScaledWidth(context, 0.75),
                  height: DeviceUtils.getScaledHeight(context, 0.2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thông báo tiến độ công việc",
                          style: Dimensions.fontSizeStyle16w600(),
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),
                        RichText(
                          text: TextSpan(
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              color: ColorResources.BLACK,
                            ),
                            children: [
                              TextSpan(
                                text: 'Công việc:  ',
                                style: Dimensions.fontSizeStyle14(),
                              ),
                              TextSpan(
                                text: 'Xây tường',
                                style: Dimensions.fontSizeStyle14w600(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),
                        Text(
                          'Phòng D,E,F của công trình A',
                          style: Dimensions.fontSizeStyle14(),
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Icon(
                              Icons.place_outlined,
                              color: ColorResources.PRIMARY,
                            ),
                            Text(
                              'Ngũ Hành Sơn',
                              style: Dimensions.fontSizeStyle14w600(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: ColorResources.BLACK,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Dự án:  ",
                                      style: Dimensions.fontSizeStyle14(),
                                    ),
                                    TextSpan(
                                      text: 'Dự án ABC',
                                      style: Dimensions.fontSizeStyle14w600(),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '05/10/2021',
                                style: Dimensions.fontSizeStyle14(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2.5,
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  child: Icon(
                    index == 2
                        ? Icons.notifications_active
                        : Icons.notifications_active_outlined,
                    size: Dimensions.ICON_SIZE_LARGE,
                  ),
                )
              ],
            ),
          );
        });
  }
}
