import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v4-employee/report/component/v4_drop_dow_button.dart';
import 'package:template/view/screen/v4-employee/report/report_controller.dart';

class V4ReportPage extends GetView<V4ReportController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: V4ReportController(),
        builder: (V4ReportController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBarWidget(
              action: [
                _filterlistreport(context, controller),
              ],
              title: "Danh sách báo cáo",
              isNotBack: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_LARGE,
              ),
              child:

                  //danh sách báo cáo
                  _listReport(controller, context),
            ),

            //floating Action Button Thêm báo cáo
            floatingActionButton:
                _floatingActionButtonReport(controller, context),
          );
        });
  }

  //
  //  Lọc danh sách báo cáo hằng ngày hoặc báo cáo theo yêu cầu
  //
  Widget _filterlistreport(
      BuildContext context, V4ReportController controller) {
    return V4DropButtonAppBar(
      data: controller.baoCaoNhanVienModel,
      value: controller.nhanVienModel,
      onChanged: (value) => controller.onChanged(newValue: value!),
      hint: '',
    );
  }

  ///
  /// Danh sách báo cáo
  ///
  Widget _listReport(V4ReportController controller, BuildContext context) {
    return SmartRefresher(
      header: const WaterDropHeader(
        complete: Text("Tải thành công!"),
      ),
      enablePullUp: true,
      onLoading: controller.onLoading,
      onRefresh: controller.onRefresh,
      controller: controller.refreshController,
      footer: const ClassicFooter(
        loadingText: "Đang tải...",
        noDataText: "Không có dữ liệu",
        canLoadingText: 'Đang tải...',
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.baoCaoNhanVienModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.onClickDetailReport(
                  controller.baoCaoNhanVienModelList[index]);
            },
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  width: DeviceUtils.getScaledWidth(context, 1),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.MARGIN_SIZE_SMALL),
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
                              //Tiêu đề báo cáo công việc theo yêu cầu hoặc theo ngày
                              Text(
                                controller.baoCaoNhanVienModelList[index]
                                            .loai ==
                                        "1"
                                    ? "Báo cáo công việc theo yêu cầu"
                                    : "Báo cáo công việc theo ngày",
                                style: TextStyle(
                                  color: ColorResources.BLACK.withOpacity(.8),
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_SMALL,
                              ),
                              //tên dự án
                              Text(
                                "Dự án: ${controller.baoCaoNhanVienModelList[index].idDuAnNhanVien}",
                                style: Dimensions.fontSizeStyle14w600(),
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                              //chi tiết báo cáo

                              Text(
                                controller
                                    .baoCaoNhanVienModelList[index].noiDung!,
                                style: TextStyle(
                                  color: ColorResources.BLACK.withOpacity(.8),
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                  right: Dimensions.PADDING_SIZE_SMALL,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.place_sharp,
                                      color: ColorResources.GREY,
                                      size: Dimensions.ICON_SIZE_SMALL,
                                    ),
                                    Expanded(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      child: Text(
                                        // địa chỉ
                                        controller
                                            .baoCaoNhanVienModelList[index]
                                            .idDuAnNhanVien!
                                            .diaChi!,
                                        style: Dimensions.fontSizeStyle14(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        const Icon(
                                          Icons.date_range,
                                          color: ColorResources.GREY,
                                          size: Dimensions.ICON_SIZE_SMALL,
                                        ),
                                        const SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL,
                                        ),
                                        Text(
                                          // ngày báo cáo
                                          controller.getFormattedDate(
                                            controller
                                                .baoCaoNhanVienModelList[index]
                                                .createdAt!,
                                          ),
                                          style: Dimensions.fontSizeStyle14(),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      //Icon flag
                      const Positioned(
                        top: Dimensions.PADDING_SIZE_EXTRA_LARGE / 2,
                        left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
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
            ),
          );
        },
      ),
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
  Widget _floatingActionButtonReport(
      V4ReportController controller, BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close_outlined,
      activeBackgroundColor: ColorResources.RED,
      backgroundColor: ColorResources.PRIMARY,
      overlayColor: ColorResources.GREY,
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
          labelBackgroundColor: ColorResources.WHITE,
          onTap: () {
            //đi đến trang báo cáo theo yêu cầu
            controller.onClickToReportOnRequest(context);
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
          labelBackgroundColor: ColorResources.WHITE,
          label: "Thêm báo cáo ngày",
          onTap: () {
            // kiểm tra có trong thời gian cho phép báo cáo hay không
            controller.managerReportTimer(context);
          },
          labelStyle: Dimensions.fontSizeStyle18w600(),
        ),
      ],
    );
  }
}
