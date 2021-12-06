import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/home/home_widget.dart';
import 'home_controller.dart';

class V4HomePage extends GetView<V4HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<V4HomeController>(
        init: V4HomeController(),
        builder: (V4HomeController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return HomeWidget(
            isGoToInfor: true,
            pressToInfor: controller.goToInfo,
            fullname: "Hi, ${controller.fullname}!",
            imageNetwork: controller.avatar,
            isNotNotification: false,
            content: SmartRefresher(
              controller: controller.refreshController!,
              onRefresh: controller.onRefresh,
              onLoading: controller.onLoading,
              child: ListView(
                children: [
                  // notificate label
                  // nếu thời gian lớn hơn 16h thì báo cáo mở là đúng
                  if (controller.isChange == false)
                    _notificateLabelReport()
                  else
                    // ngược lại thời gian 7h đến 16h chấm công mở là đúng
                    _notificateLabelTime(),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.isSelected == true)
                        _btnTimed(context)
                      else if (controller.isReport == true)
                        _btnReported(context)
                      else
                        _btnTimekeeping(context),
                    ],
                  ),
                  // time keeping

                  const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),

                  // _followWorkProgressWidget
                  _followWorkProgressWidget(context),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),

                  // _splitWidget
                  _splitWidget(context),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),

                  // _revenueStatistic
                  _revenueStatistic(context),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),

                  // _splitWidget
                  _splitWidget(context),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),

                  // _inputWarehouse
                  _inputWarehouse(context),

                  const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
                  const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// _notificateLabelTime
  ///
  Widget _notificateLabelTime() {
    return Container(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            color: Color(0xff2A3547),
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
          children: [
            TextSpan(
                text:
                    "${controller.thu}, ngày ${controller.ngay}, tháng ${controller.thang}, năm ${controller.nam}"),
            TextSpan(
              text: controller.isSelected == false ||
                      controller.isSelected == null
                  ? "\nBạn chưa chấm công, vui lòng nhấn nút nhé!"
                  : "\nBạn đã chấm công, thật tuyệt vời!",
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// _notificateLabelTime
  ///
  Widget _notificateLabelReport() {
    return Container(
      alignment: Alignment.center,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            color: Color(0xff2A3547),
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
          children: [
            TextSpan(
                text:
                    "${controller.thu}, ngày ${controller.ngay}, tháng ${controller.thang}, năm ${controller.nam}"),
            TextSpan(
              text: controller.isReport == false || controller.isReport == null
                  ? "\nBạn chưa báo cáo, vui lòng nhấn nút nhé!"
                  : "\nBạn đã báo cáo, thật tuyệt vời!",
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// button time keeping
  ///
  Widget _btnTimekeeping(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.onBtnTimeKeepingClick();
      },
      child: Container(
        width: DeviceUtils.getScaledWidth(context, .45),
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff2196F3),
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
        ),
        child: Center(
          child: Text(
            controller.isChange == true ? "Chấm công" : "Báo cáo cuối ngày",
            style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// button đã chấm công
  ///
  Widget _btnTimed(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, .45),
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorResources.GREY,
        borderRadius:
            BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
      ),
      child: const Center(
        child: Text(
          "Đã chấm công",
          style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  ///
  /// button đã báo cáo
  ///
  Widget _btnReported(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, .45),
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorResources.GREY,
        borderRadius:
            BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
      ),
      child: const Center(
        child: Text(
          "Đã báo cáo",
          style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  ///
  /// follow work progress
  ///
  Widget _followWorkProgressWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
          boxShadow: [
            BoxShadow(offset: Offset(0, 2), color: Colors.grey, blurRadius: 2),
          ]),
      child: Column(
        children: [
          const Text(
            'Theo dõi tiến độ công việc',
            style: TextStyle(
                color: Color(Dimensions.COLOR_LABEL_DEFAULT),
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, .33),
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.MARGIN_SIZE_DEFAULT,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 100,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (BuildContext ctx, index) {
                return GestureDetector(
                  onTap: () {
                    controller.onClickToWorkProgress(index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: controller.contentGrid![index]["color"]
                          as RadialGradient,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.contentGrid![index]["title"].toString(),
                          style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                offset: Offset(1, 0),
                              ),
                              Shadow(
                                color: Colors.white,
                                offset: Offset(0, 1),
                              ),
                              Shadow(
                                color: Colors.white,
                                offset: Offset(0, -1),
                              ),
                              Shadow(
                                color: Colors.white,
                                offset: Offset(-1, 0),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        Text(
                          controller.contentGrid![index]["quality"].toString(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.white,
                                offset: Offset(2, 0),
                              ),
                              Shadow(
                                color: Colors.white,
                                offset: Offset(0, 2),
                              ),
                              Shadow(
                                color: Colors.white,
                                offset: Offset(0, -2),
                              ),
                              Shadow(
                                color: Colors.white,
                                offset: Offset(-2, 0),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  ///
  ///_revenueStatistic
  ///
  Widget _revenueStatistic(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
          boxShadow: [
            BoxShadow(offset: Offset(0, 2), color: Colors.grey, blurRadius: 2),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Thống kê thu chi',
                style: TextStyle(
                    color: Color(Dimensions.COLOR_LABEL_DEFAULT),
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.centerRight,
                width: DeviceUtils.getScaledWidth(context, .4),
                child: Text(
                  "${(controller.total! > 0 ? "+" : (controller.total! == 0) ? "" : "-") + PriceConverter.convertPrice(
                        context,
                        controller.total!.toDouble(),
                      )} VND",
                  style: TextStyle(
                    color: controller.total! > 0
                        ? ColorResources.REVENUE_COLOR
                        : ColorResources.EXPENDITURE_COLOR,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
          Row(
            children: [
              const Text(
                'Tiền thu',
                style: TextStyle(
                  color: Color(Dimensions.COLOR_LABEL_DEFAULT),
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                "${PriceConverter.convertPrice(
                  context,
                  controller.revenue!,
                )} VND",
                style: const TextStyle(
                  color: ColorResources.REVENUE_COLOR,
                ),
              )
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
          Row(
            children: [
              const Text(
                'Tiền chi',
                style: TextStyle(
                  color: Color(Dimensions.COLOR_LABEL_DEFAULT),
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                "${PriceConverter.convertPrice(
                  context,
                  controller.expenditure!,
                )} VND",
                style: const TextStyle(
                  color: ColorResources.EXPENDITURE_COLOR,
                ),
              )
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.onClickRevenue(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: DeviceUtils.getScaledWidth(context, .333333333),
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  decoration: const BoxDecoration(
                    color: ColorResources.REVENUE_COLOR,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                    ),
                  ),
                  child: const Text(
                    "Thêm thu",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  controller.onClickExpenditure();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: DeviceUtils.getScaledWidth(context, .333333333),
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  decoration: const BoxDecoration(
                    color: ColorResources.EXPENDITURE_COLOR,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                    ),
                  ),
                  child: const Text(
                    "Thêm chi",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  ///
  /// _inputWarehouse
  ///
  Widget _inputWarehouse(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
          boxShadow: [
            BoxShadow(offset: Offset(0, 2), color: Colors.grey, blurRadius: 2),
          ]),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: const Text(
              'Xuất nhập kho',
              style: TextStyle(
                color: Color(0xff2A3547),
                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.onClickToExprot();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: DeviceUtils.getScaledWidth(context, 1) / 3,
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  decoration: const BoxDecoration(
                    color: ColorResources.REVENUE_COLOR,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.MARGIN_SIZE_SMALL),
                    ),
                  ),
                  child: const Text(
                    "Xuất kho",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  controller.onClickToImport();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: DeviceUtils.getScaledWidth(context, 1) / 3,
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  decoration: const BoxDecoration(
                    color: ColorResources.EXPENDITURE_COLOR,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.MARGIN_SIZE_SMALL),
                    ),
                  ),
                  child: const Text(
                    "Nhập kho",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),
        ],
      ),
    );
  }

  ///
  /// split widget
  ///
  Widget _splitWidget(BuildContext context) {
    const double square = 2.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: DeviceUtils.getScaledWidth(context, 1) / 2 - 3 * 15,
          height: square,
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
          width: DeviceUtils.getScaledWidth(context, 1) / 2 - 3 * 15,
          height: square,
          decoration: const BoxDecoration(
            color: Color(0xff4D4D4D),
          ),
        )
      ],
    );
  }
}
