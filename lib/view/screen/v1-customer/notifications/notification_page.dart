


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/notifications/notification_controller.dart';

class V1NotificationPage extends GetView<V1NotificationController> {
  const V1NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Thông báo"),
      body: GetBuilder(
        builder: (V1NotificationController controller) {
          if(controller.isLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          return SmartRefresher(
            controller: controller.refreshController,
            enablePullUp: true,
            onLoading: controller.moreData,
            onRefresh: controller.onRefresh,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: controller.notifications.length ,
              itemBuilder: (context, index) {
                return itemNotification(index: index);
              },
            ),
          );
        },
      )
    );
  }

  Widget itemNotification({required int index}){
    return GestureDetector(
      onTap: (){
        controller.onClickItem(controller.notifications[index]);
      },
      child: Container(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        height: 100,
        color: index % 2 == 0 ?  ColorResources.PRIMARYCOLOR.withOpacity(0.3) : ColorResources.WHITE,
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: '${controller.notifications[index].tieuDe} ',
                style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  color: ColorResources.BLACK.withOpacity(0.8),
                ),
                children: [
                  TextSpan(
                    text: controller.notifications[index].noiDung,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )
                  ),
                  const TextSpan(
                    text: " mã số"
                  ),
                  const TextSpan(
                    text: " ĐH12353",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    )
                  ),
                ]
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(timeago.format(DateConverter.stringToLocalDate(controller.notifications[index].updatedAt!)), style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                  color: ColorResources.BLACK.withOpacity(0.5)
                ),)
              ),
            )
          ],
        )
      ),
    );
  }
}
