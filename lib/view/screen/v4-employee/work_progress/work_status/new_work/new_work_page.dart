import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v4-employee/work_progress/work_status/new_work/new_work_controller.dart';

class V4NewWorkPage extends GetView<V4NewWorkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Chi tiết công việc mới tạo'),
      body: GetBuilder<V4NewWorkController>(
          init: V4NewWorkController(),
          builder: (V4NewWorkController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: Column(
                children: [
                  Container(
                    width: DeviceUtils.getScaledWidth(context, 1),
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_DEFAULT,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          color: ColorResources.BLACK.withAlpha(40),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE,
                      vertical: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.moiTaoModel!.tieuDe.toString(),
                              style: Dimensions.fontSizeStyle20w600(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Thời gian bắt đầu: ")],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
