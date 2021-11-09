import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/format/format_html.dart';
import 'package:template/view/screen/v3-agent/account/profile/insurance_detail/insurance_detail_controller.dart';

class V3InsuranceDetailPage extends GetView<V3InsuranceDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3InsuranceDetailController>(
      init: V3InsuranceDetailController(),
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
