import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/withdraw_money/withdraw_money_controller.dart';

class WithdrawMoneyPage extends GetView<WithdrawMoneyController> {
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
        title: "Rút vốn",
      ),
      body: GetBuilder(
        init: WithdrawMoneyController(),
        builder: (WithdrawMoneyController controller) {
          return Container();
        },
      ),
    );
  }
}
