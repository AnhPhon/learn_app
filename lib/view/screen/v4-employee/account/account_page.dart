import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

import 'package:template/view/screen/v4-employee/account/account_controller.dart';

class V4AccountPage extends GetView<V4AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V4AccountController>(
          init: V4AccountController(),
          builder: (V4AccountController controller) {
            // if (controller.isLoading) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: ColorResources.THEME_DEFAULT,
                  ),
                  child: Stack(children: [
                    Positioned(
                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL - 25,
                      left: Dimensions.PADDING_SIZE_EXTRA_SMALL - 30,
                      child: Container(
                        height: DeviceUtils.getScaledHeight(context, 0.2),
                        width: DeviceUtils.getScaledWidth(context, 0.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                              ColorResources.APPBARCIRCLECOLOR2
                                  .withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL - 85,
                      right: Dimensions.PADDING_SIZE_EXTRA_SMALL - 25,
                      child: Container(
                        height: DeviceUtils.getScaledHeight(context, 0.2),
                        width: DeviceUtils.getScaledWidth(context, 0.5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                              ColorResources.APPBARCIRCLECOLOR2
                                  .withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        width: DeviceUtils.getScaledWidth(context, 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: avoid_redundant_argument_values
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "Tài khoản",
                              style: TextStyle(
                                color: ColorResources.WHITE,
                                fontWeight: FontWeight.w600,
                                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Positioned(
                  top: Dimensions.PADDING_SIZE_EXTRA_LARGE * 3,
                  child: Container(
                    height: DeviceUtils.getScaledHeight(context, 0.8),
                    width: DeviceUtils.getScaledWidth(context, 1),
                    padding: const EdgeInsets.all(
                      Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xffF6F6F7),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.HOME_BORDER_RADIUS),
                        topRight:
                            Radius.circular(Dimensions.HOME_BORDER_RADIUS),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              // ignore: prefer_const_constructors
                              Container(
                                width: DeviceUtils.getScaledWidth(context, 0.3),
                                height:
                                    DeviceUtils.getScaledHeight(context, 0.1),
                                color: Colors.blue,
                                child: CircleAvatar(
                                  radius: Dimensions.BORDER_RADIUS_EXTRA_LARGE,
                                  backgroundColor: ColorResources.WHITE,
                                  child: const CircleAvatar(
                                    radius:
                                        Dimensions.BORDER_RADIUS_EXTRA_LARGE -
                                            2,
                                    backgroundImage: AssetImage(
                                      Images.V4AvatarHome,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
