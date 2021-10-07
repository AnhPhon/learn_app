import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/wallet/wallet_controller.dart';

class V1WalletPage extends GetView<V1WalletController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1WalletController>(
        init: V1WalletController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
          );
        });
  }
}
