import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/profile/profile_controller.dart';

class V1ProfilePage extends GetView<V1ProfileController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ProfileController>(
        init: V1ProfileController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //contract
                  _items(
                    icon: const Icon(Icons.collections_bookmark),
                    text: "Hợp đồng nguyên tắc hợp tác với FSS",
                    onTap: () => controller.onContractPageClick(),
                  ),

                  //accident insurance
                  _items(
                    icon: const Icon(Icons.monetization_on_outlined),
                    text: "Bảo hiểm tai nạn",
                    onTap: () {},
                  ),

                  //other insurance
                  _items(
                    icon: const Icon(Icons.account_balance_wallet_outlined),
                    text: "Bảo hiểm khác",
                    onTap: () {},
                  ),

                  //tax
                  _items(
                    icon: const Icon(Icons.person_outlined),
                    text: "Hồ sơ thuế của bạn",
                    onTap: () => controller.onTaxPageClick(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///items
  ///
  Widget _items(
      {required Icon icon, required String text, required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: ColorResources.WHITE,
      // shadowColor: ColorResources.BLACK.withOpacity(.4),
      margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      child: ListTile(
        onTap: onTap,
        leading: icon,
        title: Text(text),
      ),
    );
  }
}
