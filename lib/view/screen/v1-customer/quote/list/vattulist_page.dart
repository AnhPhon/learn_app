import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/quote/list/vattulist_controller.dart';

class V1VatTuListPage extends GetView<V1VatTuListController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBarWidget(title: controller.title),
        body: GetBuilder(
          init: V1VatTuListController(),
          builder: (V1VatTuListController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.PADDING_SIZE_LARGE,
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
                    _listViewDaPhanHoi(),

                    //Listview VIỆC ĐÃ LÀM
                    _listViewChuaPhanHoi(),
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
  ///ListView đã phản hồi
  ///
  Widget _listViewDaPhanHoi() {
    return SmartRefresher(
      controller: controller.refreshDaPhanHoiController!,
      onLoading: controller.onDaPhanHoiLoading,
      onRefresh: controller.onDaPhanHoiRefresh,
      child: ListView.builder(
        itemCount: controller.daPhanHoiDDV.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller
                  .onProductResponseClick(controller.daPhanHoiDDV[index].id!);
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
                            children: [
                              const Icon(Icons.watch_later_outlined),
                              Text(
                                DateConverter.isoStringToVNDateOnly(
                                  controller.daPhanHoiDDV[index].createdAt!
                                      .replaceAll("T", " ")
                                      .toString(),
                                ),
                                style: Dimensions.fontSizeStyle14w600(),
                              ),
                            ],
                          ),
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
  ///ListView chưa phản hồi
  ///
  Widget _listViewChuaPhanHoi() {
    return SmartRefresher(
      controller: controller.refreshChuaPhanHoiController!,
      onLoading: controller.onChuaPhanHoiLoading,
      onRefresh: controller.onChuaPhanHoiRefresh,
      child: ListView.builder(
        itemCount: controller.chuaPhanHoiDDV.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              controller.onProductNoResponseClick(
                  controller.chuaPhanHoiDDV[index].id!);
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
                            children: [
                              const Icon(Icons.watch_later_outlined),
                              Text(
                                DateConverter.isoStringToVNDateOnly(
                                  controller.chuaPhanHoiDDV[index].createdAt!
                                      .replaceAll("T", " ")
                                      .toString(),
                                ),
                                style: Dimensions.fontSizeStyle14w600(),
                              ),
                            ],
                          ),
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
