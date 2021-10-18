import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/drawer/usage_procedure_controller.dart';

class UsageProcedure extends GetView<UsageProcedureController> {
  const UsageProcedure({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const AppBarWidget(title: "Quy trình sử dụng vào giao dịch"),
      body: GetBuilder(
        init: UsageProcedureController(),
        builder: (UsageProcedureController controller) {
          if(controller.isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Text(controller.fss.first.quyTrinhSuDungGiaoDich!),
          );
        },
      )
    );
  }
}