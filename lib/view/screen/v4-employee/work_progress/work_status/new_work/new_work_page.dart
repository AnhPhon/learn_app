import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
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
                horizontal: Dimensions.PADDING_SIZE_SMALL,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //Tiêu đề THÔNG TIN
                    Text(
                      'Thông tin',
                      style: Dimensions.fontSizeStyle16w600(),
                    ),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                    ),

                    // Nội dung thông tin
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
                        horizontal: Dimensions.PADDING_SIZE_SMALL,
                        vertical: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.moiTaoModel!.tieuDe.toString(),
                                  style: Dimensions.fontSizeStyle20w600(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_DEFAULT,
                          ),

                          // Thời gian bắt đầu
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Thời gian bắt đầu:",
                                style: Dimensions.fontSizeStyle16w600(),
                              ),
                              Text(
                                controller.formatDateTime(
                                  dateTime: controller.moiTaoModel!.ngayBatDau
                                      .toString(),
                                ),
                                style: Dimensions.fontSizeStyle16(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_SMALL,
                          ),

                          //Thời gian kết thúc
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Thời gian kết thúc:",
                                style: Dimensions.fontSizeStyle16w600(),
                              ),
                              Text(
                                controller.formatDateTime(
                                  dateTime: controller.moiTaoModel!.ngayKetThuc
                                      .toString(),
                                ),
                                style: Dimensions.fontSizeStyle16(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: Dimensions.MARGIN_SIZE_SMALL,
                          ),

                          // Trạng thái
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Trạng thái:",
                                style: Dimensions.fontSizeStyle16w600(),
                              ),
                              DropDownButton1<String>(
                                isShadow: true,
                                isBorder: false,
                                fillColor: ColorResources.WHITE,
                                value: controller.selectIndex,
                                data: controller.selectList,
                                onChanged: (value) =>
                                    controller.onStatusChange(value),
                                width: 0.3,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    // Chi tiết công việc đang làm
                    InputWidget(
                      isBorder: false,
                      isShadow: true,
                      fillColor: ColorResources.WHITE,
                      label: "Chi tiết",
                      maxLine: 14,
                      textEditingController: controller.contentDetailWork,
                      width: 1,
                    ),
                    Container(
                      height: DeviceUtils.getScaledHeight(context, 0.05),
                    ),

                    //Button cập nhập
                    LongButton(
                      title: "Cập nhập",
                      color: ColorResources.PRIMARYCOLOR,
                      onPressed: () {
                        controller.updateWork(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
