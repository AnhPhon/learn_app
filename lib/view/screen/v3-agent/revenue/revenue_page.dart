import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
import 'package:template/view/screen/v3-agent/revenue/revenue_controller.dart';

class V3RevenuePage extends GetView<V3RevenueController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3RevenueController>(
        init: V3RevenueController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _titleInput(
                          context,
                          controller,
                          title: "Từ ngày ",
                          textController: controller.startController,
                        ),
                        _titleInput(
                          context,
                          controller,
                          title: "Đến ngày ",
                          textController: controller.endController,
                        ),
                      ],
                    ),
                  ),

                  //chart
                  _chart(controller),

                  //legend
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.revenueDataList.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return _legend(
                          context,
                          color: controller.revenueDataList[index].color,
                          label: controller.revenueDataList[index].unit,
                        );
                      }),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///title and textfield
  ///
  Widget _titleInput(
    BuildContext context,
    V3RevenueController controller, {
    required String title,
    required TextEditingController textController,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Dimensions.fontSizeStyle16().copyWith(
            color: ColorResources.BLACK,
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),
        SizedBox(
          width: DeviceUtils.getScaledWidth(context, .4),
          child: InputWidget(
            isDate: true,
            allowEdit: false,
            textEditingController: textController,
            isColorFieldWhite: true,
            suffixIcon: const Icon(
              Icons.calendar_today,
            ),
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
      ],
    );
  }

  ///
  ///chart
  ///
  Widget _chart(V3RevenueController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          isVisible: false,
        ),
        series: <ColumnSeries<RevenueData, String>>[
          ColumnSeries<RevenueData, String>(
            dataSource: controller.revenueDataList,
            xValueMapper: (RevenueData revenue, _) => revenue.unit,
            pointColorMapper: (RevenueData revenue, _) => revenue.color,
            yValueMapper: (RevenueData revenue, _) => revenue.money,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }

  ///
  ///legend
  ///
  Widget _legend(
    BuildContext context, {
    required Color color,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: Row(
        children: [
          Container(
            height: DeviceUtils.getScaledHeight(context, .026),
            width: DeviceUtils.getScaledWidth(context, .05),
            decoration:
                ShapeDecoration(color: color, shape: const CircleBorder()),
          ),
          const SizedBox(
            width: Dimensions.MARGIN_SIZE_DEFAULT,
          ),
          Text(
            label,
            style: Dimensions.fontSizeStyle18(),
          ),
        ],
      ),
    );
  }
}
