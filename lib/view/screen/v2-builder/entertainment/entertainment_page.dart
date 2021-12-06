import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';

import 'entertainment_controller.dart';

class V2EntertainmentPage extends GetView<V2EntertainmentController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const DrawerWidget(),
        body: Center(
          child: Image.asset(Images.giai_tri),
        ),
      ),
    );
  }
}
