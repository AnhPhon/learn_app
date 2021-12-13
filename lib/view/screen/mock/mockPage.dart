import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:template/base_widget/app_bar.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_otp.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/mock/mock_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:template/view/screen/mock/test/test_component.dart';

class MockPage extends GetView<MockController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
      appBar: const IZIAppBar(
        title: "Splash Page",
      ),
      body: GetBuilder(
        init: MockController(),
        builder: (MockController controller) {
          return Column(
            children: [
              SizedBox(
                height: IZIDimensions.iziSize.height,
                child: Center(
                  child: IZIOtp(
                    lables: [
                      Container(
                        margin: EdgeInsets.only(
                          top: IZIDimensions.SPACE_SIZE_5X,
                        ),
                        child: IZIText(
                          text: "Xác thực tài khoản",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: IZIDimensions.FONT_SIZE_H4,
                            color: ColorResources.CIRCLE_COLOR_BG3,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(
                          IZIDimensions.SPACE_SIZE_1X,
                        ),
                        child: IZIText(
                          text: "Nôi dung miêu tả xác thực tài khoản",
                          textAlign: TextAlign.center,
                          maxLine: 4,
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                      ),
                    ],
                    codeLength: 4,
                    countDown: 10,
                    isEnabled: true,
                    onTapSendSMS: () {},
                    onTap: () {
                      Get.to(TestComponentPage());
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  IZIButton(
                    margin: EdgeInsets.all(
                      IZIDimensions.ONE_UNIT_SIZE * 20,
                    ),
                    onTap: () => Get.to(TestComponentPage()),
                    label: "Click to Demo Base Input",
                  ),
                  IZIButton(
                    margin: EdgeInsets.all(
                      IZIDimensions.ONE_UNIT_SIZE * 20,
                    ),
                    onTap: () => controller.goToMyOrder(),
                    label: "Click to Đơn hàng của tôi",
                  ),
                  IZIButton(
                    margin: EdgeInsets.all(
                      IZIDimensions.ONE_UNIT_SIZE * 20,
                    ),
                    onTap: () => controller.goToDemoBaseCard(),
                    label: "Click to Demo Base Card",
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
