import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

import 'login_employee_controller.dart';

class LoginEmployeePage extends GetView<LoginEmployeeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginEmployeeController>(
        init: LoginEmployeeController(),
        builder: (LoginEmployeeController value) {
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
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 30,
              //   top: DeviceUtils.getScaledWidth(context, 1.4),
              //   left: DeviceUtils.getScaledWidth(context, 0.15),
              //   child: _onBtnLogin(context),
              // )
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
      width: DeviceUtils.getScaledWidth(context, 1),
      height: 79,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 96,
              height: 79,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.logo_removebg),
                  fit: BoxFit.cover,
                ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "KẾT NỐI TINH HOA",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff3275ad),
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontFamily: "Nunito Sans",
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                child: const Text(
                  "HỘI TỤ PHÁT TRIỂN",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xffc82e3e),
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                    fontFamily: "Nunito Sans",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          )
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
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: ColorResources.PRIMARY,
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: "Nhập email",
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          // link forgot password
          Align(
            child: GestureDetector(
              // on tap button forgot password
              onTap: () => controller.onBtnLogin(),
              child: const Text(
                "Thợ, khách, đại lý",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff0f90f3),
                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                  decoration: TextDecoration.underline,
                  fontFamily: "Nunito Sans",
                  fontWeight: FontWeight.w700,
                ),
              ),
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
  /// _on Btn Login
  ///
  Widget _onBtnLogin(BuildContext context) {
    return GestureDetector(
      // onLoginBtnClick
      onTap: () => controller.onBtnLogin(),
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
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xff0d5da0),
                //color: ColorResources.WHITE.withOpacity(0.3)
              ),
              padding: const EdgeInsets.only(
                top: 12,
                bottom: 9,
              ),
              child: const Text(
                "Đăng nhập thợ, khách, đại lý",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorResources.WHITE,
                  fontSize: 18,
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
