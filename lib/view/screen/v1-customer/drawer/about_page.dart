import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/drawer/about_controller.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Giới thiệu"),
      body: GetBuilder(
        init: AboutController(),
        builder: (AboutController controller) {
          if(controller.isLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Center(
              child: Text(controller.conent)
            ),
          );
        },
      )
    );
  }
}