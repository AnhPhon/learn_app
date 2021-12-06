import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:template/data/model/response/revenue_data_model.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
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
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InputWidget(
                        label: "Từ ngày ",
                        width: .4,
                        isDate: true,
                        allowEdit: false,
                        textEditingController: controller.startController,
                        fillColor: ColorResources.WHITE,
                        isddMMyyyy: true,
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                        ),
                        firstDate: DateTime(2021),
                        lastDate: DateTime.now(),
                        padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                      ),
                      InputWidget(
                        label: "Đến ngày ",
                        width: .4,
                        isDate: true,
                        allowEdit: false,
                        textEditingController: controller.endController,
                        fillColor: ColorResources.WHITE,
                        isddMMyyyy: true,
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                        ),
                        firstDate: DateTime(2021),
                        lastDate: DateTime.now(),
                        padding: const EdgeInsets.only(
                          right: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                      ),
                    ],
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
                          color: controller.revenueDataList[index].color!,
                          label:
                              controller.revenueDataList[index].unit.toString(),
                        );
                      }),
                ],
              ),
            ),
          );
        });
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
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ColumnSeries<RevenueData, String>>[
          ColumnSeries<RevenueData, String>(
            name: "Doanh thu",
            yAxisName: "VNĐ",
            xAxisName: "VNĐ",
            dataSource: controller.revenueDataList,
            xValueMapper: (RevenueData revenue, _) => revenue.unit,
            pointColorMapper: (RevenueData revenue, _) => revenue.color,
            yValueMapper: (RevenueData revenue, _) => revenue.money,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
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
