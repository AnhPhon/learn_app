import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/profile/insurance_detail/insurance_detail_controller.dart';
import 'package:template/view/screen/v1-customer/account/profile/insurance_detail/insurance_specification.dart';

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
            body: ListView.builder(
                itemCount: controller.baoHiemResponse.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Container(
                    margin:
                        const EdgeInsets.all(Dimensions.MARGIN_SIZE_DEFAULT),
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          Dimensions.BORDER_RADIUS_DEFAULT),
                      border: Border.all(color: ColorResources.GREY),
                    ),
                    child: Column(
                      children: [
                        Text(
                          controller.baoHiemResponse[index].ten.toString(),
                          style: Dimensions.fontSizeStyle20w600(),
                        ),
                        InsuranceSpecification(
                          insuranceSpecification: controller
                              .baoHiemResponse[index].chiTiet
                              .toString(),
                        ),
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
