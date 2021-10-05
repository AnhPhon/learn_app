import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
// ignore: unused_import
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_LARGE,
          vertical: Dimensions.PADDING_SIZE_LARGE,
        ),
        child: ListView.builder(
          itemCount: UINotificationsList.length,
          itemBuilder: (context, index) {
            // ignore: prefer_final_locals
            UINotifications uiNotificationsList = UINotificationsList[index];
            return Container(
              margin: const EdgeInsets.only(
                bottom: Dimensions.PADDING_SIZE_SMALL,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_LARGE,
                vertical: Dimensions.PADDING_SIZE_LARGE,
              ),
              decoration: BoxDecoration(
                  color: index == 2
                      ? ColorResources.UNREAD_NOTICE
                      : ColorResources.WHITE,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                      color: ColorResources.BLACK.withAlpha(60),
                    ),
                  ]),
              child: Row(
                children: [
                  // ignore: prefer_if_elements_to_conditional_expressions
                  if (index == 2)
                    const Icon(
                      Icons.notifications_active,
                      size: Dimensions.ICON_SIZE_LARGE,
                    )
                  else
                    const Icon(
                      Icons.notifications_active_outlined,
                      size: Dimensions.ICON_SIZE_LARGE,
                    ),
                  const SizedBox(
                    width: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        uiNotificationsList.title!,
                        style: Dimensions.fontSizeStyle18w600(),
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      Row(
                        children: [
                          Text(
                            'Công việc:',
                            style: Dimensions.fontSizeStyle14(),
                          ),
                          const SizedBox(
                            width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),
                          Text(
                            uiNotificationsList.subTitle!,
                            style: Dimensions.fontSizeStyle14w600(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      Text(
                        uiNotificationsList.desciption!,
                        style: Dimensions.fontSizeStyle14(),
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: ColorResources.PRIMARYCOLOR,
                          ),
                          Text(
                            uiNotificationsList.address!,
                            style: Dimensions.fontSizeStyle14(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Dự án:',
                                style: Dimensions.fontSizeStyle14(),
                              ),
                              const SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),
                              Text(
                                uiNotificationsList.nameProject!,
                                style: Dimensions.fontSizeStyle14w600(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: Dimensions.PADDING_SIZE_LARGE * 3,
                          ),
                          Text(
                            uiNotificationsList.date!,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

////////////////////////////////
///
/// Set model notifications UI
///
class UINotifications {
  String? title, subTitle, desciption, address, nameProject, date;
  UINotifications(
      {required this.title,
      required this.subTitle,
      required this.desciption,
      required this.address,
      required this.nameProject,
      required this.date});
}

// ignore: non_constant_identifier_names
List<UINotifications> UINotificationsList = [
  UINotifications(
      title: "Thông báo tiến độ công việc",
      subTitle: "Xây tường",
      desciption: "Phòng A của công trình Lampark",
      address: "Hồ Chí Minh City",
      nameProject: "ĐH123456",
      date: "04/10/2021"),
  UINotifications(
      title: "Thông báo tiến độ công việc",
      subTitle: "Lót gạch nền",
      desciption: "Phòng D của công trình Lampark",
      address: "Đà Nẵng City",
      nameProject: "ĐH123456",
      date: "04/10/2021"),
  UINotifications(
      title: "Thông báo tiến độ công việc",
      subTitle: "Xây tường chắn",
      desciption: "Phòng A của công trình Lampark",
      address: "Đà Nẵng City",
      nameProject: "ĐH123456",
      date: "04/10/2021"),
  UINotifications(
      title: "Thông báo tiến độ công việc",
      subTitle: "Đổ nền",
      desciption: "Phòng A của công trình Lampark",
      address: "Hồ Chí Minh City",
      nameProject: "ĐH123456",
      date: "04/10/2021"),
];
