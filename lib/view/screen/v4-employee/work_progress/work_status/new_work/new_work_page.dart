import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/screen/v4-employee/work_progress/work_status/new_work/details_work.dart';
import 'package:template/view/screen/v4-employee/work_progress/work_status/new_work/new_work_controller.dart';

class V4DetailWorkPage extends GetView<V4DetailWorkController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Chi tiết công việc mới tạo'),
      body: GetBuilder<V4DetailWorkController>(
          init: V4DetailWorkController(),
          builder: (V4DetailWorkController controller) {
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
                      style: TextStyle(
                        color: ColorResources.BLACK.withOpacity(.8),
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.w600,
                      ),
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
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.moiTaoModel!.tieuDe.toString(),
                                    style: TextStyle(
                                      color:
                                          ColorResources.BLACK.withOpacity(.8),
                                      fontSize: Dimensions
                                          .FONT_SIZE_EXTRA_SUPER_LARGE,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
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
                                style: TextStyle(
                                  color: ColorResources.BLACK.withOpacity(.8),
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                controller.formatDateTime(
                                  dateTime: controller.moiTaoModel!.ngayBatDau
                                      .toString(),
                                ),
                                style: TextStyle(
                                  color: ColorResources.BLACK.withOpacity(.8),
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                ),
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
                                style: TextStyle(
                                  color: ColorResources.BLACK.withOpacity(.8),
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                controller.formatDateTime(
                                  dateTime: controller.moiTaoModel!.ngayKetThuc
                                      .toString(),
                                ),
                                style: TextStyle(
                                  color: ColorResources.BLACK.withOpacity(.8),
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                ),
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
                                style: TextStyle(
                                  color: ColorResources.BLACK.withOpacity(.8),
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              //Thay đổi trạng thái công việc
                              _chonTrangThai(controller),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    // Chi tiết công việc đang làm
                    Container(
                      width: DeviceUtils.getScaledWidth(context, 1),
                      height: DeviceUtils.getScaledHeight(context, 0.4),
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            DetailWork(
                              detailWork:
                                  controller.moiTaoModel!.noiDung.toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: DeviceUtils.getScaledHeight(context, 0.04),
                    ),

                    //Button cập nhập
                    _btnCapNhap(controller, context),
                  ],
                ),
              ),
            );
          }),
    );
  }

  ///
  ///Thay đổi trạng thái công việc
  ///
  Widget _chonTrangThai(V4DetailWorkController controller) {
    return DropDownButton1<String>(
      isColorFieldWhite: true,
      isShadow: true,
      isBorder: false,
      fillColor: ColorResources.WHITE,
      value: controller.selectIndex,
      data: controller.selectList,
      onChanged: (value) => controller.onStatusChange(value),
      width: 0.4,
    );
  }

  ///
  ///Button cập nhập
  ///
  Widget _btnCapNhap(V4DetailWorkController controller, BuildContext context) {
    return LongButton(
      title: "Cập nhập",
      color: ColorResources.PRIMARYCOLOR,
      onPressed: () {
        controller.updateWork(context);
      },
    );
  }
}
