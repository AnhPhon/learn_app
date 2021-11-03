import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
        appBar: AppBarWidget(
          leading: IconButton(
            onPressed: () {
              controller.backHome();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.WHITE,
            ),
          ),
          title: "Tiến độ công việc",
        ),
        body: GetBuilder(
            init: V4WorkProgressController(),
            builder: (V4WorkProgressController controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Container(
                    height: DeviceUtils.getScaledHeight(context, .08),
                    color: ColorResources.WHITE,
                    child: TabBar(
                      labelPadding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                      ),
                      labelStyle: Dimensions.fontSizeStyle14w600(),
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
    return SmartRefresher(
      header: const WaterDropHeader(
        complete: Text("Tải thành công!"),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("Kéo xuống để tải lại nhé!");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text("Tải không thành công! Nhấp vào thử lại!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("Kéo lên để xem thêm!");
          } else {
            body = const Text("Không có dữ liệu!");
          }
          return Container(
            height: 55.0,
            child: Center(
              child: body,
            ),
          );
        },
      ),
      enablePullUp: true,
      controller: controller.refreshMoiTaoController,
      onLoading: controller.onMoiTaoLoading,
      onRefresh: controller.onMoiTaoRefresh,
      child: ListView.builder(
        itemCount: controller.moiTaoModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.onClickToDetailNewWork(
                      controller.moiTaoModelList[index].id!);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  width: DeviceUtils.getScaledWidth(context, 1),
                  // height: DeviceUtils.getScaledHeight(context, 0.18),
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
                      Container(
                        width: DeviceUtils.getScaledWidth(context, 0.77),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            Dimensions.PADDING_SIZE_LARGE,
                            Dimensions.PADDING_SIZE_SMALL,
                            Dimensions.PADDING_SIZE_LARGE,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Tiêu đề tiến độ công việc mới tạo
                              Wrap(
                                children: [
                                  Text(
                                    controller.moiTaoModelList[index].tieuDe
                                        .toString(),
                                    style: TextStyle(
                                      color:
                                          ColorResources.BLACK.withOpacity(.8),
                                      fontSize: Dimensions.FONT_SIZE_LARGE,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                              //Tóm tắt
                              Wrap(
                                children: [
                                  Text(
                                    controller.moiTaoModelList[index].tomTat
                                        .toString(),
                                    style: TextStyle(
                                      color:
                                          ColorResources.BLACK.withOpacity(.8),
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                              //Thời gian
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //Bắt đầu
                                  Row(
                                    children: [
                                      Text(
                                        'Bắt đầu: ',
                                        style: TextStyle(
                                          color: ColorResources.BLACK
                                              .withOpacity(.8),
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                        ),
                                      ),
                                      Text(
                                        controller.formatDateTime(
                                          dateTime: controller
                                              .moiTaoModelList[index].ngayBatDau
                                              .toString(),
                                        ),
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                    ],
                                  ),

                                  //Kết thúc
                                  Row(
                                    children: [
                                      Text(
                                        'Kết thúc: ',
                                        style: TextStyle(
                                          color: ColorResources.BLACK
                                              .withOpacity(.8),
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                        ),
                                      ),
                                      Text(
                                        controller.formatDateTime(
                                          dateTime: controller
                                              .moiTaoModelList[index]
                                              .ngayKetThuc
                                              .toString(),
                                        ),
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                    ],
                                  ),
                                ],
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
              ),

              //line Widget
              _lineWidget(context),
            ],
          );
        },
      ),
    );
  }

  ///
  ///ListView tiến độ công việc bảng ĐANG LÀM
  ///
  Widget _listViewDangLam() {
    return SmartRefresher(
      header: const WaterDropHeader(
        complete: Text("Tải thành công!"),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("Kéo xuống để tải lại nhé!");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text("Tải không thành công! Nhấp vào thử lại!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("Kéo lên để xem thêm!");
          } else {
            body = const Text("Không có dữ liệu!");
          }
          return Container(
            height: 55.0,
            child: Center(
              child: body,
            ),
          );
        },
      ),
      controller: controller.refreshDangLamController,
      enablePullUp: true,
      onRefresh: controller.onDangLamRefresh,
      onLoading: controller.onDangLamLoading,
      child: ListView.builder(
        itemCount: controller.dangLamModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.onClickToDetailNewWork(
                      controller.dangLamModelList[index].id!);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  width: DeviceUtils.getScaledWidth(context, 1),
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
                      Container(
                        width: DeviceUtils.getScaledWidth(context, 0.77),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            Dimensions.PADDING_SIZE_LARGE,
                            Dimensions.PADDING_SIZE_SMALL,
                            Dimensions.PADDING_SIZE_LARGE,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Tiêu đề tiến độ công việc mới tạo
                              Text(
                                controller.dangLamModelList[index].tieuDe
                                    .toString(),
                                style: TextStyle(
                                  color: ColorResources.BLACK.withOpacity(.8),
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                              //Tóm tắt
                              Wrap(
                                children: [
                                  Text(
                                    controller.dangLamModelList[index].tomTat
                                        .toString(),
                                    style: TextStyle(
                                      color:
                                          ColorResources.BLACK.withOpacity(.8),
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                              //Thời gian
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //Bắt đầu
                                  Row(
                                    children: [
                                      Text(
                                        'Bắt đầu: ',
                                        style: TextStyle(
                                          color: ColorResources.BLACK
                                              .withOpacity(.8),
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                        ),
                                      ),
                                      Text(
                                        controller.formatDateTime(
                                          dateTime: controller
                                              .dangLamModelList[index]
                                              .ngayBatDau
                                              .toString(),
                                        ),
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                    ],
                                  ),

                                  //Ngày thực thế
                                  Row(
                                    children: [
                                      Text(
                                        'Hoàn thành: ',
                                        style: TextStyle(
                                          color: ColorResources.BLACK
                                              .withOpacity(.8),
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                        ),
                                      ),
                                      Text(
                                        controller.formatDateTime(
                                          dateTime: controller
                                              .dangLamModelList[index]
                                              .ngayKetThuc
                                              .toString(),
                                        ),
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                    ],
                                  ),
                                ],
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
              ),

              //line Widget
              _lineWidget(context),
            ],
          );
        },
      ),
    );
  }

  ///
  ///ListView tiến độ công việc bảng HOÀN THÀNH
  ///
  Widget _listViewHoanThanh() {
    return SmartRefresher(
      header: const WaterDropHeader(
        complete: Text("Tải thành công!"),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;

          if (mode == LoadStatus.idle) {
            body = const Text("Kéo xuống để tải lại nhé!");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text("Tải không thành công! Nhấp vào thử lại!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("Kéo lên để xem thêm!");
          } else {
            body = const Text("Không có dữ liệu!");
          }
          return Container(
            height: 55.0,
            child: Center(
              child: body,
            ),
          );
        },
      ),
      enablePullUp: true,
      controller: controller.refreshHoanThanhController,
      onRefresh: controller.onHoanThanhRefresh,
      onLoading: controller.onHoanThanhLoading,
      child: ListView.builder(
        itemCount: controller.hoanThanhModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.onClickToDetailNewWork(
                      controller.hoanThanhModelList[index].id!);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  width: DeviceUtils.getScaledWidth(context, 1),
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
                      Container(
                        width: DeviceUtils.getScaledWidth(context, 0.77),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            Dimensions.PADDING_SIZE_LARGE,
                            Dimensions.PADDING_SIZE_SMALL,
                            Dimensions.PADDING_SIZE_LARGE,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Tiêu đề tiến độ công việc mới tạo
                              Text(
                                controller.hoanThanhModelList[index].tieuDe
                                    .toString(),
                                style: TextStyle(
                                  color: ColorResources.BLACK.withOpacity(.8),
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                              //Tóm tắt
                              Wrap(
                                children: [
                                  Text(
                                    controller.hoanThanhModelList[index].tomTat
                                        .toString(),
                                    style: TextStyle(
                                      color:
                                          ColorResources.BLACK.withOpacity(.8),
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                              //Thời gian
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //Bắt đầu
                                  Row(
                                    children: [
                                      Text(
                                        'Tiến độ: ',
                                        style: TextStyle(
                                          color: ColorResources.BLACK
                                              .withOpacity(.8),
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                        ),
                                      ),
                                      Text(
                                        "${controller.tienDo(
                                          startDate: controller
                                              .hoanThanhModelList[index]
                                              .ngayThucTe
                                              .toString(),
                                          endDate: controller
                                              .hoanThanhModelList[index]
                                              .ngayKetThuc
                                              .toString(),
                                        )}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                          color: controller.tienDo(
                                                    startDate: controller
                                                        .hoanThanhModelList[
                                                            index]
                                                        .ngayThucTe
                                                        .toString(),
                                                    endDate: controller
                                                        .hoanThanhModelList[
                                                            index]
                                                        .ngayKetThuc
                                                        .toString(),
                                                  ) >=
                                                  0
                                              ? ColorResources.GREEN
                                              : ColorResources.RED,
                                        ),
                                      ),
                                      Text(
                                        " Ngày",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                          color: controller.tienDo(
                                                    startDate: controller
                                                        .hoanThanhModelList[
                                                            index]
                                                        .ngayThucTe
                                                        .toString(),
                                                    endDate: controller
                                                        .hoanThanhModelList[
                                                            index]
                                                        .ngayKetThuc
                                                        .toString(),
                                                  ) >=
                                                  0
                                              ? ColorResources.GREEN
                                              : ColorResources.RED,
                                        ),
                                      ),
                                    ],
                                  ),

                                  //Ngày hoàn thành
                                  Row(
                                    children: [
                                      Text(
                                        'Hoàn thành: ',
                                        style: TextStyle(
                                          color: ColorResources.BLACK
                                              .withOpacity(.8),
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                        ),
                                      ),
                                      Text(
                                        controller.formatDateTime(
                                          dateTime: controller
                                              .hoanThanhModelList[index]
                                              .ngayKetThuc
                                              .toString(),
                                        ),
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                    ],
                                  ),
                                ],
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
              ),

              //line Widget
              _lineWidget(context),
            ],
          );
        },
      ),
    );
  }

  ///
  ///ListView tiến độ công việc bảng CHẬM TRỄ
  ///
  Widget _listViewChamTre() {
    return SmartRefresher(
      header: const WaterDropHeader(
        complete: Text("Tải thành công!"),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;

          if (mode == LoadStatus.idle) {
            body = const Text("Kéo xuống để tải lại nhé!");
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = const Text("Tải không thành công! Nhấp vào thử lại!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("Kéo lên để xem thêm!");
          } else {
            body = const Text("Không có dữ liệu!");
          }
          return Container(
            height: 55.0,
            child: Center(
              child: body,
            ),
          );
        },
      ),
      enablePullUp: true,
      onRefresh: controller.onChamTreRefresh,
      onLoading: controller.onChamTreLoading,
      controller: controller.refreshChamTreController,
      child: ListView.builder(
        itemCount: controller.chamTreModelList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.onClickToDetailNewWork(
                      controller.chamTreModelList[index].id!);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  width: DeviceUtils.getScaledWidth(context, 1),
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
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            Dimensions.PADDING_SIZE_LARGE,
                            Dimensions.PADDING_SIZE_SMALL,
                            Dimensions.PADDING_SIZE_LARGE,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Tiêu đề tiến độ công việc mới tạo
                              Text(
                                controller.chamTreModelList[index].tieuDe
                                    .toString(),
                                style: TextStyle(
                                  color: ColorResources.BLACK.withOpacity(.8),
                                  fontSize: Dimensions.FONT_SIZE_LARGE,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                              //Tóm tắt
                              Wrap(
                                children: [
                                  Text(
                                    controller.chamTreModelList[index].tomTat
                                        .toString(),
                                    style: TextStyle(
                                      color:
                                          ColorResources.BLACK.withOpacity(.8),
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),

                              //Thời gian
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //Bắt đầu
                                  Row(
                                    children: [
                                      Text(
                                        'Tiến độ: ',
                                        style: TextStyle(
                                          color: ColorResources.BLACK
                                              .withOpacity(.8),
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                        ),
                                      ),
                                      Text(
                                        "${controller.tienDo(
                                          startDate: controller.tienDoChamTre,
                                          endDate: controller
                                              .chamTreModelList[index]
                                              .ngayKetThuc
                                              .toString(),
                                        )}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                          color: controller.tienDo(
                                                    startDate: controller
                                                        .tienDoChamTre,
                                                    endDate: controller
                                                        .chamTreModelList[index]
                                                        .ngayKetThuc
                                                        .toString(),
                                                  ) >=
                                                  0
                                              ? ColorResources.GREEN
                                              : ColorResources.RED,
                                        ),
                                      ),
                                      Text(
                                        " Ngày",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                          color: controller.tienDo(
                                                    startDate: controller
                                                        .tienDoChamTre,
                                                    endDate: controller
                                                        .chamTreModelList[index]
                                                        .ngayKetThuc
                                                        .toString(),
                                                  ) >=
                                                  0
                                              ? ColorResources.GREEN
                                              : ColorResources.RED,
                                        ),
                                      ),
                                    ],
                                  ),

                                  //Ngày hoàn thành
                                  Row(
                                    children: [
                                      Text(
                                        'Thực tế: ',
                                        style: TextStyle(
                                          color: ColorResources.BLACK
                                              .withOpacity(.8),
                                          fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                        ),
                                      ),
                                      Text(
                                        controller.ngayThucTe,
                                        style: Dimensions.fontSizeStyle14(),
                                      ),
                                    ],
                                  ),
                                ],
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
              ),

              //line Widget
              _lineWidget(context),
            ],
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
}
