import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/drawer/terms_and_policy_controller.dart';

class TermsAndPolicy extends GetView<TermsAndPolicyController> {
  const TermsAndPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppBarWidget(title: "Điều khoản và chính sách"),
      body: GetBuilder(
        init: TermsAndPolicyController(),
        builder: (TermsAndPolicyController controller) {
          if(controller.isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Text(controller.fss.first.doiTuong!)
          );
        },
      )
    );
  }
}