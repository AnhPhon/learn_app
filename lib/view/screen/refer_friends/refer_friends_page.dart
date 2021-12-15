import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/refer_friends/refer_friends_controller.dart';

class ReferFriendsPage extends GetView<ReferFriendsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
      appBar: IZIAppBar(
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
        title: "Giới thiệu bạn bè",
      ),
      body: GetBuilder(
        init: ReferFriendsController(),
        builder: (ReferFriendsController controller) {
          return Container();
        },
      ),
    );
  }
}
