import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/screen/v3-agent/project/project_controller.dart';

class V3ProjectPage extends GetView<V3ProjectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: Center(
        child: GestureDetector(
          onTap: (){
          },
          child: const Text("Dự án")),
      ),
    );
  }
}