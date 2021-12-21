import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/notification/notification_detail/notification_detail_controller.dart';

class NotificationDetailPage extends GetView<NotificationDetailController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
      appBar: IZIAppBar(
        colorBG: ColorResources.WHITE,
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.BLACK,
          ),
        ),
        title: "Chi tiết thông báo",
        colorTitle: ColorResources.BLACK,
      ),
      body: GetBuilder(
        init: NotificationDetailController(),
        builder: (NotificationDetailController controller) {
          return Container(
            constraints: BoxConstraints(
              minHeight: IZIDimensions.iziSize.height,
              minWidth: IZIDimensions.iziSize.width,
            ),
            decoration: const BoxDecoration(
              color: ColorResources.BACKGROUND,
            ),
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              children: [
                IZIImage(
                  "https://www.thuocdantoc.org/wp-content/uploads/2019/06/sam-ngoc-linh.jpg",
                  width: IZIDimensions.iziSize.width,
                  height: IZIDimensions.iziSize.height * .3,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_4X,
                    vertical: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Text(
                            "Đầu tư",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: IZIDimensions.FONT_SIZE_H5,
                              color: ColorResources.BLACK,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.favorite_rounded,
                                color: ColorResources.RED,
                              ),
                              Text(
                                "1,200k",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  color: ColorResources.BLACK.withOpacity(.7),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: ColorResources.BLACK.withOpacity(.7),
                              ),
                              Text(
                                "10/11/2021",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  color: ColorResources.BLACK.withOpacity(.7),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Vì sao chọn công ty An Toàn Thực Phẩm Hà Nội?",
                        style: TextStyle(
                          color: ColorResources.CIRCLE_COLOR_BG,
                          fontSize: IZIDimensions.FONT_SIZE_H5,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    IZIDimensions.SPACE_SIZE_4X,
                    IZIDimensions.SPACE_SIZE_2X,
                    IZIDimensions.SPACE_SIZE_4X,
                    0,
                  ),
                  child: Text(
                    "Trước khi đến được tay người tiêu dùng, các sản phẩm đã phải trải qua hàng loạt những quy trình kiểm định và xét nghiệm khắt khe. Ngoài ra chúng tôi cũng có giấy xét nghiệm hàm lượng dinh dưỡng cho từng đầu mục sản phẩm. Trước khi đến được tay người tiêu dùng, các sản phẩm đã phải trải qua hàng loạt những quy trình kiểm định và xét nghiệm khắt khe. Ngoài ra chúng tôi cũng có giấy xét nghiệm hàm lượng dinh dưỡng cho từng đầu mục sản phẩm.",
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
