import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/screen/v1-customer/account/profile/insurance_detail/insurance_detail_controller.dart';

class V1InsuranceDetailPage extends GetView<V1InsuranceDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1InsuranceDetailController>(
      init: V1InsuranceDetailController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: ColorResources.WHITE,
          appBar: AppBarWidget(title: controller.title),
          body: (controller.thongTinFSSResponse.chiTietBaoHiem == null)
              ? const Center(
                  child: Text("Chưa có chi tiết bảo hiểm"),
                )
              : SingleChildScrollView(
                  child: Specification(
                    specification: controller.thongTinFSSResponse.chiTietBaoHiem
                        .toString(),
                  ),
                ),
        );
      },
    );
  }
}
