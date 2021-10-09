import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

import 'package:template/view/screen/v4-employee/account/account_controller.dart';
import 'package:template/view/screen/v4-employee/account/component/card_profile.dart';

class V4AccountPage extends GetView<V4AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V4AccountController>(
          init: V4AccountController(),
          builder: (V4AccountController controller) {
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
                              // Custom Avatar
                              _avatar(context),
                            ],
                          ),
                          Column(
                            children: [
                              // Tên tài khoản
                              Text(
                                controller.title,
                                style: Dimensions.fontSizeStyle18w600(),
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                              //Tên email
                              Text(
                                controller.email,
                                style: Dimensions.fontSizeStyle16(),
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                              ),

                              //Thông tin cá nhân
                              CardProfile(
                                icon: const Icon(
                                  Icons.account_circle_outlined,
                                  color: ColorResources.BLACK,
                                ),
                                press: () {
                                  controller.onClickToInformation();
                                },
                                title: 'Thông tin cá nhân',
                              ),

                              //Bảng lương
                              CardProfile(
                                icon: const Icon(
                                  Icons.paid_outlined,
                                  color: ColorResources.BLACK,
                                ),
                                press: () {
                                  controller.onClickToSalarypage();
                                },
                                title: 'Bảng lương',
                              ),

                              //Vi phạm quy chế công ty
                              CardProfile(
                                icon: const Icon(
                                  Icons.gavel_outlined,
                                  color: ColorResources.BLACK,
                                ),
                                press: () {
                                  controller.onClickToRulesPage();
                                },
                                title: 'Quy phạm quy chế công ty',
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

  ///
  /// Custom Avatar
  ///
  Widget _avatar(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: DeviceUtils.getScaledWidth(context, 0.3),
      height: DeviceUtils.getScaledHeight(context, 0.14),
      child: Stack(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: Dimensions.BORDER_RADIUS_EXTRA_LARGE,
              backgroundColor: ColorResources.WHITE,
              child: CircleAvatar(
                radius: Dimensions.BORDER_RADIUS_EXTRA_LARGE - 2,
                backgroundImage: AssetImage(
                  Images.V4AvatarHome,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            child: Container(
              width: DeviceUtils.getScaledWidth(context, 0.1),
              height: DeviceUtils.getScaledWidth(context, 0.1),
              decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      // ignore: prefer_const_constructors
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      color: ColorResources.BLACK.withAlpha(20),
                    )
                  ]),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add_a_photo_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
