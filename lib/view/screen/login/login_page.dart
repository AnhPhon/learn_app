import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
// template
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/register/register_page.dart';
import 'package:template/view/screen/register/register_page_2.dart';
// images

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  final TextEditingController? usernameController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorResources.WHITE,
      body: Stack(
        children: [
          // bottom
          Stack(
            children: [
              _bottomWidget(width),
            ],
          ),

          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),

                  // logo
                  Image.asset(
                    Images.logo_image,
                    scale: 1.3,
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // username enter widget
                  _usernameEnterWidget(context, usernameController!),
                  const SizedBox(
                    height: 20,
                  ),
                  //  password enter widget
                  _passwordEnterWidget(context, passwordController!),
                  const SizedBox(
                    height: 50,
                  ),

                  //  login button widget
                  _loginBtnWidget(context, "Đăng nhập", width),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
/// _usernameEnterWidget
///
Widget _usernameEnterWidget(
    BuildContext context, TextEditingController usernameController) {
  return TextField(
    textInputAction: TextInputAction.done,
    textAlignVertical: TextAlignVertical.center,
    controller: usernameController,
    cursorColor: ColorResources.PRIMARY,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.025),
          vertical: DeviceUtils.getScaledSize(context, 0.038)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorResources.PRIMARY)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorResources.GREY)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorResources.GREY)),
      hintText: "Tài khoản",
      filled: true,
      fillColor: Colors.transparent,
      suffixIconConstraints: BoxConstraints(
        maxHeight: DeviceUtils.getScaledSize(context, 0.025) * 2,
      ),
      suffixIcon: Container(
        padding:
            EdgeInsets.only(right: DeviceUtils.getScaledSize(context, 0.025)),
        child: Icon(
          Icons.person,
          size: DeviceUtils.getScaledSize(context, 0.045),
          color: ColorResources.PRIMARY,
        ),
      ),
    ),
  );
}

///
/// _passwordEnterWidget
///
Widget _passwordEnterWidget(
    BuildContext context, TextEditingController passwordController) {
  return TextField(
    obscureText: true,
    textInputAction: TextInputAction.done,
    textAlignVertical: TextAlignVertical.center,
    controller: passwordController,
    cursorColor: ColorResources.PRIMARY,
    decoration: InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledSize(context, 0.025),
          vertical: DeviceUtils.getScaledSize(context, 0.038)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorResources.PRIMARY)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorResources.GREY)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorResources.GREY)),
      hintText: "Mật khẩu",
      filled: true,
      fillColor: Colors.transparent,
      suffixIconConstraints: BoxConstraints(
        maxHeight: DeviceUtils.getScaledSize(context, 0.025) * 2,
      ),
      suffixIcon: Container(
        padding:
            EdgeInsets.only(right: DeviceUtils.getScaledSize(context, 0.025)),
        child: Icon(
          Icons.lock,
          size: DeviceUtils.getScaledSize(context, 0.045),
          color: ColorResources.PRIMARY,
        ),
      ),
    ),
  );
}

///
/// button login
///
Widget _loginBtnWidget(BuildContext context, String label, double width) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(AppRoutes.DASHBOARD);
    },
    child: Container(
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.035),
          horizontal: DeviceUtils.getScaledSize(context, 0.03)),
      width: width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF61A63C),
            Color(0xFF61A63C),
          ],
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  );
}

// _bottomWidget
Widget _bottomWidget(double width) {
  return Positioned(
    bottom: 0,
    child: Stack(
      children: [
        Image.asset(Images.bottom_login),
        Positioned(
          bottom: 20,
          left: width / 2 - 100,
          child: Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                const Text("Bạn chưa có tài khoản? "),
                GestureDetector(
                  onTap: () {
                    Get.put(RegisterPage());
                    Get.toNamed(AppRoutes.REGISTER);
                  },
                  child: const Text(
                    "Đăng ký",
                    style: TextStyle(color: Color(0xFF61A63C)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
