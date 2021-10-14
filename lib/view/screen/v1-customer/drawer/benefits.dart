import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/drawer/benefits_controller.dart';

class Benefits extends GetView<BenefitsController> {
  const Benefits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppBarWidget(title: "Điều khoản và chính sách"),
      body: GetBuilder(
        init: BenefitsController(),
        builder: (BenefitsController controller) {
          if(controller.isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Text(controller.fss.first.loiIchThamGiaFSS!)
          );
        },
      )
    );
  }
}