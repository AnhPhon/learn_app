<<<<<<< HEAD


=======
>>>>>>> origin/feature/ui/51_employee_notifications_page
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/notifications/notification_controller.dart';

class V1NotificationPage extends GetView<V1NotificationController> {
  V1NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (V1NotificationController controller) {
        return Scaffold(
<<<<<<< HEAD
          appBar: const AppBarWidget(title: "Thông báo"),
          body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  controller.onClickItem();
                },
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  height: 150,
                  color: index % 2 == 0 ?  ColorResources.PRIMARYCOLOR.withOpacity(0.3) : ColorResources.WHITE,
                  child: Column(
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: "Đã có một thông báo phản hồi từ",
                          style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                            color: ColorResources.BLACK,
                          ),
                          children: [
                            TextSpan(
                              text: " Thợ ốp lát: công trình khách 5",
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            TextSpan(
                              text: " mã số"
                            ),
                            TextSpan(
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
                          child: Text("a moment ago", style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                            color: ColorResources.BLACK.withOpacity(0.5)
                          ),)
                        ),
                      )
                    ],
                  )
                ),
              );
            },
          )
        );
      },
    );
  }
}
=======
            appBar: const AppBarWidget(title: "Thông báo"),
            body: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.onClickItem();
                  },
                  child: Container(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      height: 150,
                      color: index % 2 == 0
                          ? ColorResources.PRIMARYCOLOR.withOpacity(0.3)
                          : ColorResources.WHITE,
                      child: Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                                text: "Đã có một thông báo phản hồi từ",
                                style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                  color: ColorResources.BLACK,
                                ),
                                children: [
                                  TextSpan(
                                      text: " Thợ ốp lát: công trình khách 5",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: " mã số"),
                                  TextSpan(
                                      text: " ĐH12353",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                          Expanded(
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "a moment ago",
                                  style: TextStyle(
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      color: ColorResources.BLACK
                                          .withOpacity(0.5)),
                                )),
                          )
                        ],
                      )),
                );
              },
            ));
      },
    );
  }
}
>>>>>>> origin/feature/ui/51_employee_notifications_page
