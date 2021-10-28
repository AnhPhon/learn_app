import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

import 'update_password_controller.dart';

class UpdatePasswordPage extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdatePasswordController>(
        init: UpdatePasswordController(),
        builder: (UpdatePasswordController value) {
          return Scaffold(
            body: Stack(children: [
              // background
              Positioned.fill(
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(Images.login_background),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  ),
                )),
              ),

              // Card
              Positioned(
                width: DeviceUtils.getScaledWidth(context, 0.9),
                height: 393,
                top: DeviceUtils.getScaledWidth(context, 0.4),
                left: DeviceUtils.getScaledWidth(context, 0.05),
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Color(0xa0ffffff),
                  ),
                  child: Column(
                    children: [
                      // logo
                      _logoWidget(context),

                      // input password
                      _passwordEnterWidget(context),

                      // input repassword
                      _rePasswordEnterWidget(context),

                      // login button
                      _onBtnLoginTap(context),
                    ],
                  ),
                ),
              )
            ]),
          );
        });
  }

  ///
  /// _logo Widget
  ///
  Widget _logoWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
      width: 251,
      height: 79,
      child: Stack(
        children: [
          const Positioned(
            left: 104,
            top: 20,
            child: Text(
              "KẾT NỐI TINH HOA",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff3275ad),
                fontSize: 16,
                fontFamily: "Nunito Sans",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Positioned(
            left: 101,
            top: 47,
            child: Text(
              "HỘI TỤ PHÁT TRIỂN",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffc82e3e),
                fontSize: 16,
                fontFamily: "Nunito Sans",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                  width: 96,
                  height: 79,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.logo_removebg),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// _passwordEnterWidget
  ///
  Widget _passwordEnterWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_EXTRA_LARGE),
      width: DeviceUtils.getScaledWidth(context, 0.7),
      height: 48,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: DeviceUtils.getScaledWidth(context, 0.7),
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                top: 13,
                bottom: 7,
              ),
              child: TextField(
                obscureText: true,
                textInputAction: TextInputAction.done,
                textAlignVertical: TextAlignVertical.center,
                controller: controller.passwordController,
                cursorColor: ColorResources.PRIMARY,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: "Nhập mật khẩu mới",
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              )),
        ],
      ),
    );
  }

  ///
  /// _rePasswordEnterWidget
  ///
  Widget _rePasswordEnterWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
      width: DeviceUtils.getScaledWidth(context, 0.7),
      height: 48,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: DeviceUtils.getScaledWidth(context, 0.7),
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                top: 13,
                bottom: 7,
              ),
              child: TextField(
                obscureText: true,
                textInputAction: TextInputAction.done,
                textAlignVertical: TextAlignVertical.center,
                controller: controller.passwordController,
                cursorColor: ColorResources.PRIMARY,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: "Xác nhận mật khẩu",
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              )),
        ],
      ),
    );
  }

  ///
  /// _on Btn Login Tap
  ///
  Widget _onBtnLoginTap(BuildContext context) {
    return GestureDetector(
      // onLoginBtnClick
      onTap: () => controller.onLoginBtnClick(),
      child: Container(
        margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_LARGE),
        width: DeviceUtils.getScaledWidth(context, 0.7),
        height: 48,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: DeviceUtils.getScaledWidth(context, 0.7),
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 9,
              ),
              child: const Text(
                "Hoàn thành",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff0d5da0),
                  fontSize: 20,
                  fontFamily: "Nunito Sans",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
