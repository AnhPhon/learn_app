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
                    height: DeviceUtils.getScaledHeight(context, 0.9),
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
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_DEFAULT,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              // Custom Avatar
                              _avatar(context),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          Column(
                            children: [
                              // Tên tài khoản
                              Text(
                                controller.nhanVienResponse.hoTen.toString(),
                                style: Dimensions.fontSizeStyle18w600(),
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL * 6,
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
                                  controller.onClickToSalarypage(context);
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
                                title: 'Vi phạm quy chế công ty',
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
    if (controller.isLoadingImage) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return
        //image
        Container(
      height: DeviceUtils.getScaledSize(context, .25),
      width: DeviceUtils.getScaledSize(context, .25),
      child: ClipOval(
        child: FadeInImage.assetNetwork(
            placeholder: Images.placeholder,
            image: controller.nhanVienResponse.hinhDaiDien.toString(),
            fit: BoxFit.cover,
            imageErrorBuilder: (c, o, s) => const CircleAvatar(
                backgroundImage: AssetImage(Images.placeholder))),
      ),
    );
  }
}
