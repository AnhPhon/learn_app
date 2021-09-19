
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/home_page/info.dart';
// template
import 'package:template/data/template/categories.dart';
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';

import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {

  @override
  Widget build(BuildContext context) {

    const String title = "Đăng ký";

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          title,
          style: TextStyle(
            color: Color(0xFF27272A),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        shadowColor: const Color(0x3F000000),
      ),
      body: Container(
          child: const Text(title)
      ),
    );
  }
}