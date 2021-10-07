import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';

import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

import 'package:template/view/screen/v4-employee/work_progress/work_progress_controller.dart';

class V4WorkProgressPage extends GetView<V4WorkProgressController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: controller.selectedIndex,
      length: 4,
      child: Scaffold(
        appBar: const AppBarWidget(
          title: "Tiến độ công việc",
        ),
        body: GetBuilder(
            init: V4WorkProgressController(),
            builder: (V4WorkProgressController controller) {
              // if (controller.isLoading) {
              //   return const Center(
              //     child: CircularProgressIndicator(),
              //   );
              // }
              return Column(
                children: [
                  Container(
                    height: DeviceUtils.getScaledHeight(context, .08),
                    color: ColorResources.WHITE,

                    // ignore: prefer_const_constructors
                    child: TabBar(
                      labelPadding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      labelStyle: Dimensions.fontSizeStyle16w600(),
                      indicator: BoxDecoration(
                        color: ColorResources.APPBARCOLOR,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 2,
                            color: ColorResources.BLACK.withAlpha(90),
                          )
                        ],
                      ),
                      unselectedLabelColor: ColorResources.UNSELECT_TABBAR,

                      // ignore: prefer_const_literals_to_create_immutables
                      tabs: [
                        //tab MỚI TẠO
                        const Text('Mới tạo'),

                        //tab ĐANG LÀM
                        const Text('Đang làm'),

                        //tab HOÀN THÀNH
                        const Text('Hoàn thành'),

                        // tab CHẬM TRỄ
                        const Text('Chậm trễ'),
                      ],
                    ),
                  ),

                  //Tab View
                  Container(
                    height: DeviceUtils.getScaledHeight(context, .75),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_LARGE,
                    ),

                    //Tabbar View Tiến độ công việc
                    child: TabBarView(children: [
                      //listview tiến độ công việc bảng MỚI TẠO
                      _listViewMoiTao(),

                      //Listview tiến độ công việc bảng ĐANG LÀM
                      _listViewDangLam(),

                      //Listview tiến độ công việc bảng HOÀN THÀNH
                      _listViewHoanThanh(),

                      //Listview tiến độ công việc bảng CHẬM TRỄ
                      _listViewChamTre(),
                    ]),
                  ),
                ],
              );
            }),
      ),
    );
  }

  ///
  ///ListView tiến độ công việc bảng MỚI TẠO
  ///
  Widget _listViewMoiTao() {
    return ListView.builder(
      itemCount: controller.uiWorkProgress!.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_LARGE,
              ),
              width: DeviceUtils.getScaledWidth(context, 1),
              height: DeviceUtils.getScaledHeight(context, 0.18),
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
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: DeviceUtils.getScaledWidth(context, 0.77),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Tiêu đề tiến độ công việc mới tạo
                          Text(
                            controller.uiWorkProgress![index]["title"]
                                .toString(),
                            style: Dimensions.fontSizeStyle16w600(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_SMALL,
                          ),

                          //phụ đề tiến độ công việc mới tạo
                          Text(
                            controller.uiWorkProgress![index]["subtitle"]
                                .toString(),
                            style: Dimensions.fontSizeStyle14(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),

                          //chi tiết tiến độ công việc
                          Text(
                            controller.uiWorkProgress![index]["description"]
                                .toString(),
                            style: Dimensions.fontSizeStyle14(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),

                          // thời gian bắt đầu & kết thúc tiến độ công việc mới tạo
                          Padding(
                            padding: const EdgeInsets.only(
                              right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Thời gian bắt đầu
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Bắt đầu:",
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                      TextSpan(
                                        text: controller.uiWorkProgress![index]
                                                ["daystart"]
                                            .toString(),
                                        style: Dimensions.fontSizeStyle14w600(),
                                      ),
                                    ],
                                  ),
                                ),

                                //thời gian kết thúc
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Kết thúc:",
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                      TextSpan(
                                        text: controller.uiWorkProgress![index]
                                                ["daystart"]
                                            .toString(),
                                        style: Dimensions.fontSizeStyle16w600(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Icon
                  const Positioned(
                    top: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
                    left: Dimensions.PADDING_SIZE_SMALL,
                    child: Icon(
                      Icons.engineering_outlined,
                      size: Dimensions.ICON_SIZE_LARGE,
                    ),
                  ),
                ],
              ),
            ),

            //line Widget
            _lineWidget(context),
          ],
        );
      },
    );
  }

  ///
  ///ListView tiến độ công việc bảng ĐANG LÀM
  ///
  Widget _listViewDangLam() {
    return ListView.builder(
      itemCount: controller.uiWorkProgress!.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_LARGE,
              ),
              width: DeviceUtils.getScaledWidth(context, 1),
              height: DeviceUtils.getScaledHeight(context, 0.18),
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
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: DeviceUtils.getScaledWidth(context, 0.77),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Tiêu đề tiến độ công việc mới tạo
                          Text(
                            controller.uiWorkProgress![index]["title"]
                                .toString(),
                            style: Dimensions.fontSizeStyle16w600(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_SMALL,
                          ),

                          //phụ đề tiến độ công việc mới tạo
                          Text(
                            controller.uiWorkProgress![index]["subtitle"]
                                .toString(),
                            style: Dimensions.fontSizeStyle14(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),

                          //chi tiết tiến độ công việc
                          Text(
                            controller.uiWorkProgress![index]["description"]
                                .toString(),
                            style: Dimensions.fontSizeStyle14(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),

                          // thời gian bắt đầu & kết thúc tiến độ công việc mới tạo
                          Padding(
                            padding: const EdgeInsets.only(
                              right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Thời gian bắt đầu
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Bắt đầu:",
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                      TextSpan(
                                        text: controller.uiWorkProgress![index]
                                                ["daystart"]
                                            .toString(),
                                        style: Dimensions.fontSizeStyle14w600(),
                                      ),
                                    ],
                                  ),
                                ),

                                //thời gian kết thúc
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Hoàn thành:",
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                      TextSpan(
                                        text: controller.uiWorkProgress![index]
                                                ["finishday"]
                                            .toString(),
                                        style: Dimensions.fontSizeStyle16w600(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Icon
                  const Positioned(
                    top: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
                    left: Dimensions.PADDING_SIZE_SMALL,
                    child: Icon(
                      Icons.engineering_outlined,
                      size: Dimensions.ICON_SIZE_LARGE,
                    ),
                  ),
                ],
              ),
            ),

            //line Widget
            _lineWidget(context),
          ],
        );
      },
    );
  }

  ///
  ///ListView tiến độ công việc bảng HOÀN THÀNH
  ///
  Widget _listViewHoanThanh() {
    return ListView.builder(
      itemCount: controller.uiWorkProgress!.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_LARGE,
              ),
              width: DeviceUtils.getScaledWidth(context, 1),
              height: DeviceUtils.getScaledHeight(context, 0.18),
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
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: DeviceUtils.getScaledWidth(context, 0.77),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Tiêu đề tiến độ công việc mới tạo
                          Text(
                            controller.uiWorkProgress![index]["title"]
                                .toString(),
                            style: Dimensions.fontSizeStyle16w600(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_SMALL,
                          ),

                          //phụ đề tiến độ công việc mới tạo
                          Text(
                            controller.uiWorkProgress![index]["subtitle"]
                                .toString(),
                            style: Dimensions.fontSizeStyle14(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),

                          //chi tiết tiến độ công việc
                          Text(
                            controller.uiWorkProgress![index]["description"]
                                .toString(),
                            style: Dimensions.fontSizeStyle14(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),

                          // thời gian bắt đầu & kết thúc tiến độ công việc mới tạo
                          Padding(
                            padding: const EdgeInsets.only(
                              right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Thời gian bắt đầu
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: "Tiến độ: ",
                                        style: TextStyle(
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                          color: ColorResources.BLACK,
                                        ),
                                      ),
                                      TextSpan(
                                        text: controller.uiWorkProgress![index]
                                                ["progress"]
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                          fontWeight: FontWeight.w600,
                                          color: ColorResources.RED,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: " Ngày",
                                        style: TextStyle(
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                          color: ColorResources.RED,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //thời gian kết thúc
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Hoàn thành:",
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                      TextSpan(
                                        text: controller.uiWorkProgress![index]
                                                ["finishday"]
                                            .toString(),
                                        style: Dimensions.fontSizeStyle16w600(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Icon
                  const Positioned(
                    top: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
                    left: Dimensions.PADDING_SIZE_SMALL,
                    child: Icon(
                      Icons.engineering_outlined,
                      size: Dimensions.ICON_SIZE_LARGE,
                    ),
                  ),
                ],
              ),
            ),

            //line Widget
            _lineWidget(context),
          ],
        );
      },
    );
  }

  ///
  ///ListView tiến độ công việc bảng CHẬM TRỄ
  ///
  Widget _listViewChamTre() {
    return ListView.builder(
      itemCount: controller.uiWorkProgress!.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: Dimensions.PADDING_SIZE_LARGE,
              ),
              width: DeviceUtils.getScaledWidth(context, 1),
              height: DeviceUtils.getScaledHeight(context, 0.18),
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
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: DeviceUtils.getScaledWidth(context, 0.77),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Tiêu đề tiến độ công việc mới tạo
                          Text(
                            controller.uiWorkProgress![index]["title"]
                                .toString(),
                            style: Dimensions.fontSizeStyle16w600(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_SMALL,
                          ),

                          //phụ đề tiến độ công việc mới tạo
                          Text(
                            controller.uiWorkProgress![index]["subtitle"]
                                .toString(),
                            style: Dimensions.fontSizeStyle14(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),

                          //chi tiết tiến độ công việc
                          Text(
                            controller.uiWorkProgress![index]["description"]
                                .toString(),
                            style: Dimensions.fontSizeStyle14(),
                          ),
                          const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                          ),

                          // thời gian bắt đầu & kết thúc tiến độ công việc mới tạo
                          Padding(
                            padding: const EdgeInsets.only(
                              right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Thời gian bắt đầu
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Tiến độ:",
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                      TextSpan(
                                        text: controller.uiWorkProgress![index]
                                                ["daystart"]
                                            .toString(),
                                        style: Dimensions.fontSizeStyle14w600(),
                                      ),
                                    ],
                                  ),
                                ),

                                //thời gian kết thúc
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: ColorResources.BLACK,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Hoàn thành:",
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                      TextSpan(
                                        text: controller.uiWorkProgress![index]
                                                ["finishday"]
                                            .toString(),
                                        style: Dimensions.fontSizeStyle16w600(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Icon
                  const Positioned(
                    top: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
                    left: Dimensions.PADDING_SIZE_SMALL,
                    child: Icon(
                      Icons.engineering_outlined,
                      size: Dimensions.ICON_SIZE_LARGE,
                    ),
                  ),
                ],
              ),
            ),

            //line Widget
            _lineWidget(context),
          ],
        );
      },
    );
  }

  ///
  ///Line Wiget
  ///
  Widget _lineWidget(BuildContext context) {
    const double square = 4;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: DeviceUtils.getScaledWidth(context, 0.4),
          height: square - 2,
          decoration: const BoxDecoration(
            color: Color(0xff4D4D4D),
          ),
        ),
        const SizedBox(width: 5),
        Row(
          children: [
            Container(
              width: square,
              height: square,
              decoration: const BoxDecoration(
                  color: Color(0xff4D4D4D),
                  borderRadius: BorderRadius.all(Radius.circular(square))),
            ),
            const SizedBox(width: 5),
            Container(
              width: square,
              height: square,
              decoration: const BoxDecoration(
                  color: Color(0xff4D4D4D),
                  borderRadius: BorderRadius.all(Radius.circular(square))),
            ),
            const SizedBox(width: 5),
            Container(
              width: square,
              height: square,
              decoration: const BoxDecoration(
                  color: Color(0xff4D4D4D),
                  borderRadius: BorderRadius.all(Radius.circular(square))),
            ),
          ],
        ),
        const SizedBox(width: 5),
        Container(
          width: DeviceUtils.getScaledWidth(context, 0.4),
          height: square - 2,
          decoration: const BoxDecoration(
            color: Color(0xff4D4D4D),
          ),
        )
      ],
    );
  }
}
