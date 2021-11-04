


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/common_helper.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/helper/string_cut.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/image_url.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/v2-builder/notifications/notification_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

class V2NotificationPage extends GetView<V2NotificationController> {
  const V2NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Thông báo"),
      body: GetBuilder(
        builder: (V2NotificationController controller) {
          if(controller.isLoading){
            return const Center(child: CircularProgressIndicator(),);
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL)
          ),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
              color: index % 2 == 0 ?  ColorResources.PRIMARYCOLOR.withOpacity(0.3) : ColorResources.WHITE,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder, 
                      image: controller.notifications[index].hinhDaiDien != 'null' ? controller.notifications[index].hinhDaiDien! : ImageURL.V2_IMAGE_WORK_IN_PROGRESS,
                      fit: BoxFit.cover,
                      placeholderErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(Images.placeholder);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Text(controller.notifications[index].tieuDe.toString(),
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_LARGE
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric( horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Text(controller.notifications[index].noiDung.toString(),
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: Dimensions.FONT_SIZE_SMALL
                        ),),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(timeago.format(DateConverter.stringToLocalDate(controller.notifications[index].updatedAt!))),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                                
                            //   ],
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget needPerson(){
    return Row(
      children: const [
        Icon(Icons.work),
        Text("Đang cần người")
      ],
    );
  }

  Widget chuaPhanHoi(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        Icon(Icons.warning),
        Text("Chưa phản hồi")
      ],
    );
  }

  Widget daPhanHoi(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        Icon(Icons.check_circle),
        Text("Đã phản hồi")
      ],
    );
  }
}
