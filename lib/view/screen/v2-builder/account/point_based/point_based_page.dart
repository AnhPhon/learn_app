import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v2-builder/account/point_based/point_based_controller.dart';
import 'package:template/view/screen/v2-builder/component_customer/btn_component.dart';
import 'package:template/view/screen/v2-builder/component_customer/input_widget.dart';
import 'package:template/view/screen/v2-builder/component_customer/item_list_widget.dart';
import 'package:template/view/screen/v2-builder/component_customer/row_text.dart';
import 'package:template/view/screen/v2-builder/component_customer/tab_bar_widget.dart';

class V2PointBasedPage extends GetView<V2PointBasedController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2PointBasedController>(
        init: V2PointBasedController(),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //start
                        _timeRange(
                          context,
                          title: "Từ ngày",
                          textController: controller.startController,
                          hintText:
                              DateConverter.estimatedDateOnly(DateTime.now()),
                        ),

                        const SizedBox(
                          width: Dimensions.MARGIN_SIZE_LARGE,
                        ),

                        //end
                        _timeRange(
                          context,
                          title: "Đến ngày",
                          textController: controller.endController,
                          hintText:
                              DateConverter.estimatedDateOnly(DateTime.now()),
                        ),
                      ],
                    ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //item list
                  ItemListWidget(
                    onTap: () {},
                    title: "Biệt thự 170 Nguyễn Đình Thi",
                    icon: const Icon(Icons.monetization_on_outlined),
                    rowText1: "2.000.000 vnđ",
                    colorRowText1: ColorResources.RED,
                    isStart: true,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: controller.currentIndex == 0
                ? _btnBottomSheet(context)
                : _bottomTimeRange(context),
          );
        });
  }

  ///
  /// tab
  ///
  Widget _tabBarWidget(
      {required BuildContext context,
      required V2PointBasedController controller}) {
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
  Widget _timeRange(
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

  ///
  ///btn bottom sheet
  ///
  Widget _btnBottomSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
      height: DeviceUtils.getScaledHeight(context, .2),
      color: ColorResources.WHITE,
      child: Column(
        children: [
          //total
          const RowText(text1: "Tổng đơn", text2: "1 đơn"),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),

          //btn
          BtnCustom(
            onTap: () {},
            color: ColorResources.PRIMARY,
            text: "Tích điểm",
            width: DeviceUtils.getScaledWidth(context, .9),
          ),
        ],
      ),
    );
  }

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