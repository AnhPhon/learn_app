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
    return ListView.builder(
        shrinkWrap: true,
        itemCount: controller.thongbaoList.length,
        itemBuilder: (context, index) {
          return Container(
            width: DeviceUtils.getScaledWidth(context, 1),
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              borderRadius: BorderRadius.circular(
                Dimensions.BORDER_RADIUS_SMALL,
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
                            controller.thongbaoList[index].tieuDe!,
                            style: Dimensions.fontSizeStyle18w600(),
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
                            controller.thongbaoList[index].noiDung!,
                            style: Dimensions.fontSizeStyle16(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),

                      //Địa chỉ
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: ColorResources.PRIMARY,
                          ),
                          Text(
                            controller
                                .thongbaoList[index].idDuAnNhanVien!.diaChi
                                .toString(),
                            style: Dimensions.fontSizeStyle16(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),

                      //Tên dự án và thời gian
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: ColorResources.BLACK,
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                              ),
                              children: [
                                const TextSpan(
                                  text: "Dự án: ",
                                ),
                                TextSpan(
                                  text: controller.thongbaoList[index]
                                      .idDuAnNhanVien!.tieuDe,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Đợi update trường date ở model
                          Text(
                            '2021-10-13',
                            style: Dimensions.fontSizeStyle14(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
