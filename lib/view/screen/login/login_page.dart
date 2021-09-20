import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
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
                  _usernameEnterWidget(usernameController!),
                  const SizedBox(
                    height: 20,
                  ),
                  //  password enter widget
                  _passwordEnterWidget(passwordController!),
                  const SizedBox(
                    height: 50,
                  ),

                  //  login button widget
                  _loginBtnWidget("Đăng nhập", width),
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
Widget _usernameEnterWidget(TextEditingController usernameController) {
  return TextField(
    obscureText: false,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Tài khoản',
    ),
    controller: usernameController,
  );
}

///
/// _passwordEnterWidget
///
Widget _passwordEnterWidget(TextEditingController passwordController) {
  return TextField(
    obscureText: true,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Mật khẩu',
    ),
    controller: passwordController,
  );
}

///
/// button login
///
Widget _loginBtnWidget(String label, double width) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(AppRoutes.DASHBOARD);
    },
    child: Container(
      padding: const EdgeInsets.all(Dimensions.FONT_SIZE_LARGE),
      width: width,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(Dimensions.FONT_SIZE_LARGE * 2)),
        gradient: LinearGradient(
          colors: [
            Color(0xFF59DC12),
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
