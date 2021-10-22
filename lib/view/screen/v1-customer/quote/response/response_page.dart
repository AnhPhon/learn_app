import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/quote/response/response_controller.dart';

class V1ResponsePage extends GetView<V1ResponseController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const AppBarWidget(title: "Quản lý công việc"),
        body: GetBuilder(
          init: V1ResponseController(),
          builder: (V1ResponseController controller) {
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
                          unselectedLabelColor: ColorResources.UNSELECT_TABBAR,
                          tabs: const [
                            //tab ĐÃ PHẢN HỒI
                            Text('Đã phản hồi'),

                            //tab CHƯA PHẢN HỒI
                            Text('Chưa phản hồi'),
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
          },
        ),
      ),
    );
  }

  ///
  ///ListView Việc đang làm
  ///
  Widget _listViewDangLam() {
    return SmartRefresher(
      controller: controller.refreshDaPhanHoiController,
      onLoading: controller.onDaPhanHoiLoading,
      onRefresh: controller.onDaPhanHoiRefresh,
      child: ListView.builder(
        itemCount: controller.daPhanHoiDDV.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
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
                                  text: controller.daPhanHoiDDV[index].tieuDe
                                      .toString(),
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
                                    controller
                                        .daPhanHoiDDV[index].idTinhTp!.ten!,
                                    style: Dimensions.fontSizeStyle14(),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    controller.daPhanHoiDDV[index]
                                                .idTrangThaiDonDichVu!.tieuDe!
                                                .toLowerCase() ==
                                            "Đã phản hồi"
                                        ? Icons.person_add_outlined
                                        : Icons.watch_later_outlined,
                                    color: controller
                                                .daPhanHoiDDV[index].tieuDe!
                                                .toLowerCase() ==
                                            "Chưa phản hồi"
                                        ? ColorResources.GREEN
                                        : ColorResources.YELLOW,
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
                                controller.daPhanHoiDDV[index].idTinhTp!.ten
                                    .toString(),
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
                                controller.daPhanHoiDDV[index].idTinhTp!.ten
                                    .toString(),
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
      ),
    );
  }

  ///
  ///ListView Việc ĐÃ LÀM
  ///
  Widget _listViewDaLam() {
    return SmartRefresher(
      controller: controller.refreshChuaPhanHoiController,
      onLoading: controller.onChuaPhanHoiLoading,
      onRefresh: controller.onChuaPhanHoiRefresh,
      child: ListView.builder(
        itemCount: controller.chuaPhanHoiDDV.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {},
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
                                  text: controller.chuaPhanHoiDDV[index].tieuDe
                                      .toString(),
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
                                    controller
                                        .chuaPhanHoiDDV[index].idTinhTp!.ten
                                        .toString(),
                                    style: Dimensions.fontSizeStyle14(),
                                  ),
                                ],
                              ),

                              //Trang thái kết quả công việc đã làm
                              Text(
                                controller.chuaPhanHoiDDV[index]
                                    .idTrangThaiDonDichVu!.tieuDe
                                    .toString(),
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
                                controller.chuaPhanHoiDDV[index].idTinhTp!.ten
                                    .toString(),
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
                                controller.chuaPhanHoiDDV[index].idTinhTp!.ten
                                    .toString(),
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
      ),
    );
  }
}
