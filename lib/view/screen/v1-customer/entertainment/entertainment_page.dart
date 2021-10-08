import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';


import 'entertainment_controller.dart';

class V1EntertainmentPage extends GetView<V1EntertainmentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: Center(
        child: GestureDetector(
          onTap: (){
            Get.toNamed(AppRoutes.V1_NOTIFICATION);
          },
          child: Text("Giải trí")),
      ),
    );
  }
}