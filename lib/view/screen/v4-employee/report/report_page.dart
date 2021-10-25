import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

import 'package:template/view/screen/v4-employee/report/component/v4_drop_dow_button.dart';
import 'package:template/view/screen/v4-employee/report/report_controller.dart';

class V4ReportPage extends GetView<V4ReportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        action: [
          _filterlistreport(context),
        ],
        title: "Danh sách báo cáo",
      ),
      body: GetBuilder<V4ReportController>(
          init: V4ReportController(),
          builder: (V4ReportController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_LARGE,
              ),
              child:

                  //danh sách báo cáo
                  _listReport(controller),
            );
          }),

      //floating Action Button Thêm báo cáo
      floatingActionButton: _floatingActionButtonReport(controller),
    );
  }

  ///
  /// Lọc danh sách báo cáo hằng ngày hoặc báo cáo theo yêu cầu
  ///
  Widget _filterlistreport(BuildContext context) {
    return V4DropButtonAppBar(
      data: const [
        'Báo cáo hằng ngày',
        'Báo cáo theo yêu cầu',
      ],
      hint: '',
      onChanged: (String? i) {},
    );
  }
}

///
/// Danh sách báo cáo
///
Widget _listReport(V4ReportController controller) {
  return ListView.builder(
    itemCount: controller.uiReport!.length,
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
                        //Tiêu đề báo cáo công việc theo yêu cầu
                        Text(
                          controller.uiReport![index]["title"].toString(),
                          style: Dimensions.fontSizeStyle16w600(),
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_SMALL,
                        ),

                        //phụ đề báo cáo công việc
                        Text(
                          controller.uiReport![index]["subtitle"].toString(),
                          style: Dimensions.fontSizeStyle14(),
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),

                        //chi tiết báo cáo
                        Text(
                          controller.uiReport![index]["description"].toString(),
                          style: Dimensions.fontSizeStyle14(),
                        ),
                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                            right: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Icon(
                                    Icons.place_outlined,
                                    color: ColorResources.PRIMARY,
                                  ),
                                  Text(
                                    controller.uiReport![index]["address"]
                                        .toString(),
                                    style: Dimensions.fontSizeStyle14w600(),
                                  ),
                                ],
                              ),
                              Text(
                                controller.uiReport![index]["daysReport"]
                                    .toString(),
                                style: Dimensions.fontSizeStyle14w600(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //Icon
                const Positioned(
                  top: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
                  left: Dimensions.PADDING_SIZE_SMALL,
                  child: Icon(
                    Icons.flag_outlined,
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

///
///floating Action Button Thêm báo cáo
///
Widget _floatingActionButtonReport(V4ReportController controller) {
  return SpeedDial(
    icon: Icons.add,
    activeIcon: Icons.close_outlined,
    activeBackgroundColor: ColorResources.RED,
    backgroundColor: ColorResources.PRIMARY,
    iconTheme: const IconThemeData(
      color: ColorResources.WHITE,
      size: Dimensions.ICON_SIZE_EXTRA_LARGE,
    ),
    children: [
      SpeedDialChild(
        child: const Icon(
          Icons.add,
          color: ColorResources.WHITE,
          size: Dimensions.ICON_SIZE_LARGE,
        ),
        label: "Thêm báo cáo theo yêu cầu",
        backgroundColor: ColorResources.YELLOW,
        onTap: () {
          //đi đến trang báo cáo theo yêu cầu
          controller.onClickToReportOnRequest();
        },
        labelStyle: Dimensions.fontSizeStyle18w600(),
      ),
      SpeedDialChild(
        child: const Icon(
          Icons.add,
          color: ColorResources.WHITE,
          size: Dimensions.ICON_SIZE_LARGE,
        ),
        backgroundColor: ColorResources.PRIMARY,
        label: "Thêm báo cáo hằng ngày",
        onTap: () {
          // kiểm tra có trong thời gian cho phép báo cáo hay không
          controller.managerReportTimer();
        },
        labelStyle: Dimensions.fontSizeStyle18w600(),
      ),
    ],
  );
}
