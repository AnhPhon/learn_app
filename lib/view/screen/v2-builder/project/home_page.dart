import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/screen/v2-builder/project/home_controller.dart';

class V2ProjectPage extends GetView<V2ProjectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: Center(
        child: GestureDetector(
          onTap: (){
            Get.toNamed(AppRoutes.V1NOTIFICATION);
          },
          child: const Text("Dự án")),
      ),
    );
  }
}