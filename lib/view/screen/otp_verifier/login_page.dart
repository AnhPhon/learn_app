import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (LoginController value) {
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

                      // input username
                      _usernameEnterWidget(context),

                      // input password
                      _passwordEnterWidget(context),

                      // remember password
                      _rememberAndForgotPasswordWidget(context),

                      // login button
                      _onBtnLoginTap(context),

                      // register arial
                      _registerWidget(context),
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
  /// _usernameEnterWidget
  ///
  Widget _usernameEnterWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_DEFAULT),
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
                textInputAction: TextInputAction.done,
                textAlignVertical: TextAlignVertical.center,
                controller: controller.usernameController,
                cursorColor: ColorResources.PRIMARY,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: "Nhập tên đăng nhập",
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              )),
        ],
      ),
    );
  }

  ///
  /// _passwordEnterWidget
  ///
  Widget _passwordEnterWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_DEFAULT),
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
                  hintText: "Nhập mật khẩu",
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              )),
        ],
      ),
    );
  }

  ///
  /// _remember And Forgot Password Widget
  ///
  Widget _rememberAndForgotPasswordWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_SMALL),
      width: DeviceUtils.getScaledWidth(context, 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 25,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Checkbox(
                    checkColor: Colors.white,
                    value: controller.isRemember,
                    onChanged: (bool? value) {
                      // onCheckBoxRememberClick
                      controller.onCheckBoxRememberClick(value);
                    },
                  ),
                ),
                const SizedBox(width: 2),
                const Text(
                  "Nhớ mật khẩu",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff2a3547),
                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                  ),
                ),
              ],
            ),
          ),

          // link forgot password
          const Text(
            "Quên mật khẩu?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff0f90f3),
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
              decoration: TextDecoration.underline,
              fontFamily: "Nunito Sans",
              fontWeight: FontWeight.w700,
            ),
          )
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
                top: 12,
                bottom: 9,
              ),
              child: const Text(
                "Đăng nhập",
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

  ///
  /// _on Btn Login Tap
  ///
  Widget _registerWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Dimensions.MARGIN_SIZE_LARGE),
      width: DeviceUtils.getScaledWidth(context, 0.7),
      height: 25,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text(
            "Bạn chưa có tài khoản?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff2a3547),
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),

          const SizedBox(width: 4),

          // ignore: prefer_const_literals_to_create_immutables
          const Text(
            "Đăng ký",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff0f90f3),
              fontSize: Dimensions.FONT_SIZE_LARGE,
              decoration: TextDecoration.underline,
              fontFamily: "Nunito Sans",
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}