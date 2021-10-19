import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/workflow_management/workflow_management_controller.dart';

class V2WorkflowManagementPage extends GetView<V2WorkflowManagementController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const AppBarWidget(title: "Quản lý công việc"),
        body: GetBuilder(
            init: V2WorkflowManagementController(),
            builder: (V2WorkflowManagementController controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: DeviceUtils.getScaledWidth(context, .9),
                          height: DeviceUtils.getScaledHeight(context, .07),
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(
                              Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                            ),
                          ),
                          child: TabBar(
                            labelPadding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            ),
                            labelStyle: Dimensions.fontSizeStyle16w600(),
                            indicator: BoxDecoration(
                              color: ColorResources.APPBARCOLOR,
                              borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_EXTRA_SMALL,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 2),
                                  blurRadius: 2,
                                  color: ColorResources.BLACK.withAlpha(90),
                                )
                              ],
                            ),
                            unselectedLabelColor:
                                ColorResources.UNSELECT_TABBAR,
                            tabs: const [
                              //tab VIỆC ĐANG LÀM
                              Text('Việc đang làm'),

                              //tab VIỆC ĐÃ LÀM
                              Text('Việc đã làm'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Tab View
                  Container(
                    height: DeviceUtils.getScaledHeight(context, .7),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE,
                    ),

                    //Tabbar View Tiến độ công việc
                    child: TabBarView(children: [
                      //listview VIỆC ĐANG LÀM
                      _listViewDangLam(),

                      //Listview VIỆC ĐÃ LÀM
                      _listViewDaLam(),
                    ]),
                  ),
                ],
              );
            }),
      ),
    );
  }

  ///
  ///ListView Việc đang làm
  ///
  Widget _listViewDangLam() {
    return ListView.builder(
      itemCount: controller.dangLam.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            controller
                .onClickToWorkInProgressPage(controller.dangLam[index].id!);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_SMALL,
            ),
            width: DeviceUtils.getScaledWidth(context, 1),
            height: DeviceUtils.getScaledHeight(context, 0.15),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
              color: ColorResources.WHITE,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                  color: ColorResources.BLACK.withAlpha(60),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                SizedBox(
                  width: DeviceUtils.getScaledWidth(context, 0.65),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_LARGE,
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: ColorResources.BLACK,
                            ),
                            children: [
                              //Tiêu đề công việc
                              TextSpan(
                                text:
                                    controller.dangLam[index].tieuDe.toString(),
                                style: Dimensions.fontSizeStyle16w600(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_SMALL,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                ),

                                //Địa điểm
                                Text(
                                  controller.dangLam[index].idTinhTp!.ten!,
                                  style: Dimensions.fontSizeStyle14(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  controller.dangLam[index].idTrangThaiDonHang!
                                              .tieuDe!
                                              .toLowerCase() ==
                                          controller.dangTuyenKey
                                      ? Icons.person_add_outlined
                                      : Icons.watch_later_outlined,
                                  color: controller.dangLam[index]
                                              .idTrangThaiDonHang!.tieuDe!
                                              .toLowerCase() ==
                                          controller.dangTuyenKey
                                      ? ColorResources.GREEN
                                      : ColorResources.YELLOW,
                                ),

                                //Trạng thái
                                Text(
                                  controller.dangLam[index].idTrangThaiDonHang!
                                              .tieuDe!
                                              .toLowerCase() ==
                                          controller.dangTuyenKey
                                      ? controller.dangLam[index]
                                          .idTrangThaiDonHang!.tieuDe!
                                      : controller.getDeadline(controller
                                          .dangLam[index].ngayKetThuc!),
                                  style: Dimensions.fontSizeStyle14(),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                //Icon
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: DeviceUtils.getScaledWidth(context, 0.25),
                    height: DeviceUtils.getScaledHeight(context, 0.15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          Dimensions.BORDER_RADIUS_DEFAULT,
                        ),
                        bottomLeft: Radius.circular(
                          Dimensions.BORDER_RADIUS_DEFAULT,
                        ),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          Images.logo_image,
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          ColorResources.GREY,
                          BlendMode.multiply,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Thành phố
                        Stack(
                          children: [
                            Text(
                              controller.hoanThanh[index].idTinhTp!.ten!,
                              style: TextStyle(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                fontWeight: FontWeight.w600,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..color = ColorResources.WHITE
                                  ..strokeWidth = 1,
                              ),
                            ),
                            Text(
                              controller.hoanThanh[index].idTinhTp!.ten!,
                              style: const TextStyle(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: ColorResources.BLACK,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  ///ListView Việc ĐÃ LÀM
  ///
  Widget _listViewDaLam() {
    return ListView.builder(
      itemCount: controller.hoanThanh.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            controller.onClickToWorkDonePage(controller.hoanThanh[index].id!);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_SMALL,
            ),
            width: DeviceUtils.getScaledWidth(context, 1),
            height: DeviceUtils.getScaledHeight(context, 0.15),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
              color: ColorResources.WHITE,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                  color: ColorResources.BLACK.withAlpha(60),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                SizedBox(
                  width: DeviceUtils.getScaledWidth(context, 0.65),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_LARGE,
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: ColorResources.BLACK,
                            ),
                            children: [
                              //Tiêu đề công việc
                              TextSpan(
                                text: controller.hoanThanh[index].tieuDe,
                                style: Dimensions.fontSizeStyle16w600(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_SMALL,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                ),

                                //Địa điểm
                                Text(
                                  controller.hoanThanh[index].idTinhTp!.ten!,
                                  style: Dimensions.fontSizeStyle14(),
                                ),
                              ],
                            ),

                            //Trang thái kết quả công việc đã làm
                            Text(
                              controller
                                  .hoanThanh[index].idTrangThaiDonHang!.tieuDe!,
                              style: Dimensions.fontSizeStyle14w600(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                //Icon
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: DeviceUtils.getScaledWidth(context, 0.25),
                    height: DeviceUtils.getScaledHeight(context, 0.15),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          Dimensions.BORDER_RADIUS_DEFAULT,
                        ),
                        bottomLeft: Radius.circular(
                          Dimensions.BORDER_RADIUS_DEFAULT,
                        ),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          Images.logo_image,
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          ColorResources.GREY,
                          BlendMode.multiply,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Thành phố
                        Stack(
                          children: [
                            Text(
                              controller.hoanThanh[index].idTinhTp!.ten!,
                              style: TextStyle(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                fontWeight: FontWeight.w600,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..color = ColorResources.WHITE
                                  ..strokeWidth = 1,
                              ),
                            ),
                            Text(
                              controller.hoanThanh[index].idTinhTp!.ten!,
                              style: const TextStyle(
                                fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                color: ColorResources.BLACK,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
