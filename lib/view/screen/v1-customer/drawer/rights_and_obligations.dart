import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/drawer/right_and_obligations_controller.dart';

class RightsAndObligations extends GetView<RightsAndObligationsController> {
  const RightsAndObligations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppBarWidget(title: "Quyền và nghĩa vụ của FSS"),
      body: GetBuilder(
        init:RightsAndObligationsController() ,
        builder: (RightsAndObligationsController controller) {
          if (controller.isLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          return Center(
            child: Text(
              controller.fss.first.quyenNghiaVuFSS!
            )
          );
        },
      )
    );
  }
}