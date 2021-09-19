
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/home_page/info.dart';
// template
import 'package:template/data/template/categories.dart';
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {

  final TextEditingController? usernameController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const String title = "Đăng nhập";
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Column(
            children: [
              
              // // logo
              // Container(
              //   child: Image.asset(name)
              // )
              
              // username enter widget
              _usernameEnterWidget(usernameController!),

              //  password enter widget
              _passwordEnterWidget(passwordController!),

              //  login button widget
              _loginBtnWidget("Đăng nhập")
            ]
          )
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
Widget _loginBtnWidget(String label) {
  return GestureDetector(
    onTap: () {

    },
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF59DC12),
            Color(0xFF61A63C),
          ],

        )
      ),
      child: Text(label, style: TextStyle(color: Colors.white),)
    ),
  );
}