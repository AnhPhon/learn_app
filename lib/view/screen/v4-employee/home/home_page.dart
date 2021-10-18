import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/routes/app_routes.dart';
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
            fullname: "Hi, ${controller.fullname}!",
            notificationURL: AppRoutes.V4_NOTIFICATION,
            content: Column(
              children: [
                // notificate label
                _notificateLabel(),
                const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),

                // time keeping
                _btnTimekeeping(context),
                const SizedBox(height: Dimensions.MARGIN_SIZE_LARGE),

                // _followWorkProgressWidget
                _followWorkProgressWidget(),
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

                // _splitWidget
                _splitWidget(context)
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  /// _notificateLabel
  ///
  Widget _notificateLabel() {
    return Container(
      alignment: Alignment.centerLeft,
      child: const Text(
        'Chủ nhật, ngày 26 tháng 9 năm 2021. \nBạn chưa chấm công, vui lòng nhấn nút nhé!',
        style: TextStyle(
          color: Color(0xff2A3547),
          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          fontWeight: FontWeight.bold,
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
        controller.onBtnTimeKeepingClick(context);
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff2196F3),
          borderRadius:
              BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
        ),
        child: Center(
          child: Text(
            controller.isvalid ? "Chấm công" : "Báo cáo",
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
  /// follow work progress
  ///
  Widget _followWorkProgressWidget() {
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
          Container(
            height: 250,
            padding:
                const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
            child: GridView.builder(
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
                'Thông kê thu chi',
                style: TextStyle(
                    color: Color(Dimensions.COLOR_LABEL_DEFAULT),
                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                width: DeviceUtils.getScaledWidth(context, .4),
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(
                  color: controller.total! > 0
                      ? ColorResources.THEME_DEFAULT
                      : Colors.red,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    )
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  ),
                ),
                child: Text(
                  "${(controller.total! > 0 ? "+" : "") + PriceConverter.convertPrice(
                        context,
                        controller.total!.toDouble(),
                      )} Đ",
                  style: const TextStyle(color: Colors.white),
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
                )} Đ",
                style: const TextStyle(
                  color: ColorResources.THEME_DEFAULT,
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
                )} Đ",
                style: const TextStyle(
                  color: Colors.red,
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
                    color: ColorResources.THEME_DEFAULT,
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
                  controller.onClickExpenditure(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: DeviceUtils.getScaledWidth(context, .333333333),
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  decoration: const BoxDecoration(
                    color: Colors.red,
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
                    color: ColorResources.THEME_DEFAULT,
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
                    "Thêm thu",
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
                    color: Colors.red,
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
                    "Thêm chi",
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
    const double square = 4.0;
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
