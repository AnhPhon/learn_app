import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/basewidget/component/tab_bar_widget.dart';
import 'package:template/view/screen/v1-customer/account/point_based/point_based_controller.dart';

class V1PointBasedPage extends GetView<V1PointBasedController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1PointBasedController>(
        init: V1PointBasedController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //tab bar
                  _tabBarWidget(context: context, controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //time range
                  if (controller.currentIndex == 0)
                    const SizedBox.shrink()
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //start
                        InputWidget(
                          label: "Từ ngày",
                          textEditingController: controller.startController,
                          width: .4,
                          isDate: true,
                          allowEdit: false,
                          isColorFieldWhite: true,
                        ),

                        //end
                        InputWidget(
                          label: "Đến ngày",
                          textEditingController: controller.startController,
                          width: .4,
                          isDate: true,
                          allowEdit: false,
                          isColorFieldWhite: true,
                        ),
                      ],
                    ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //item list
                  ItemListWidget(
                    onTap: () {},
                    urlImage: controller.urlImage,
                    title: "Biệt thự 170 Nguyễn Đình Thi",
                    icon1: const Icon(Icons.monetization_on_outlined),
                    rowText1: "2.000.000 vnđ",
                    colorRowText1: ColorResources.RED,
                    isStart: true,
                  ),
                ],
              ),
            ),
            bottomNavigationBar:
                controller.currentIndex == 0 ? null : _bottomTimeRange(context),
          );
        });
  }

  ///
  /// tab
  ///
  Widget _tabBarWidget(
      {required BuildContext context,
      required V1PointBasedController controller}) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: DeviceUtils.getScaledHeight(context, .07),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.titleTabBar.length,
          itemBuilder: (BuildContext context, int index) {
            return TabBarWidget(
                onTap: () => controller.onChangeTab(index),
                index: index,
                currentIndex: controller.currentIndex,
                title: controller.titleTabBar[index].toString());
          }),
    );
  }

  ///
  ///hide/show time range
  ///
  Widget timeRange(
    BuildContext context, {
    required String title,
    required TextEditingController textController,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Dimensions.fontSizeStyle16w600(),
        ),
        InputWidget(
          width: .4,
          textEditingController: textController,
          hintText: hintText,
          isDate: true,
        ),
      ],
    );
  }

  // ///
  // ///btn bottom sheet
  // ///
  // Widget _btnBottomSheet(BuildContext context) {
  //   return Container(
  //     padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
  //     height: DeviceUtils.getScaledHeight(context, .2),
  //     color: ColorResources.WHITE,
  //     child: Column(
  //       children: [
  //         //total
  //         const RowText(text1: "Tổng đơn", text2: "1 đơn"),

  //         const SizedBox(
  //           height: Dimensions.MARGIN_SIZE_LARGE,
  //         ),

  //         //btn
  //         BtnCustom(
  //           onTap: () {},
  //           color: ColorResources.PRIMARY,
  //           text: "Tích điểm",
  //           width: DeviceUtils.getScaledWidth(context, .9),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  ///
  ///bottom time range
  ///
  Widget _bottomTimeRange(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
      height: DeviceUtils.getScaledHeight(context, .2),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.BORDER_RADIUS_LARGE),
          topRight: Radius.circular(Dimensions.BORDER_RADIUS_LARGE),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.5),
              blurRadius: 4,
              offset: const Offset(0, 1))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          RowText(
            text1: "Tổng giá trị các đơn hàng",
            text2: "4.000.000 vnđ",
            colorRed: true,
          ),
          RowText(
            text1: "Phí dịch vụ",
            text2: "4.000.000 vnđ",
            colorRed: true,
          ),
          RowText(
            text1: "Thuế đươc khấu trừ (Nếu có)",
            text2: "5.000 vnđ",
            colorRed: true,
          ),
        ],
      ),
    );
  }
}
