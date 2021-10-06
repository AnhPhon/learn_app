import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'home_controller.dart';

class V4HomePage extends GetView<V4HomeController> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GetBuilder<V4HomeController>(
        init: V4HomeController(),
        builder: (V4HomeController controller) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: ColorResources.THEME_DEFAULT,
                ),
                child: Stack(children: [
                  Positioned(
                    top: -20,
                    left: -25,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                            ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -80,
                    right: -20,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorResources.APPBARCIRCLECOLOR.withOpacity(0.4),
                            ColorResources.APPBARCIRCLECOLOR2.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 25,
                    // left: 15,
                    width: size.width,
                    child: Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_EXTRA_LARGE,
                              ),
                            ),
                            padding: const EdgeInsets.all(2),
                            margin: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_EXTRA_LARGE,
                              ),
                              child: Image.asset(
                                Images.V4AvatarHome,
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                          const Text(
                            "Hi, Phạm Dương!",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.all(5),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  CupertinoIcons.bell_fill,
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(width: 10)
                        ],
                      ),
                    ),
                  ),
                ]),
              ),

              // white
              Positioned(
                top: 100,
                child: Container(
                  height: size.height - 180,
                  width: size.width,
                  margin: const EdgeInsets.only(),
                  padding: const EdgeInsets.all(
                    Dimensions.PADDING_SIZE_DEFAULT,
                  ),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    color: Color(0xffF6F6F7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.HOME_BORDER_RADIUS),
                      topRight: Radius.circular(Dimensions.HOME_BORDER_RADIUS),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          // notificate label
                          _notificateLabel(),

                          const SizedBox(height: 20),

                          // time keeping
                          _btnTimekeeping(),

                          const SizedBox(height: 20),

                          // _followWorkProgressWidget
                          _followWorkProgressWidget(),

                          const SizedBox(height: 20),

                          // _splitWidget
                          _splitWidget(context),

                          const SizedBox(height: 20),

                          // _revenueStatistic
                          _revenueStatistic(context),

                          const SizedBox(height: 20),

                          // _splitWidget
                          _splitWidget(context),

                          const SizedBox(height: 20),

                          // _inputWarehouse
                          _inputWarehouse(context),

                          const SizedBox(height: 20),

                          // _splitWidget
                          _splitWidget(context)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
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
  Widget _btnTimekeeping() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff2196F3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Text(
          'Chấm Công',
          style: TextStyle(
            fontSize: Dimensions.FONT_SIZE_DEFAULT,
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
  Widget _followWorkProgressWidget() {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: controller.contentGrid[index]["color"]
                        as RadialGradient,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.contentGrid[index]["title"].toString(),
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
                      const SizedBox(height: 10),
                      Text(
                        controller.contentGrid[index]["quality"].toString(),
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
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                width: size.width / 3,
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                decoration: BoxDecoration(
                  color: controller.total > 0
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
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  "${(controller.total > 0 ? "+" : "-") + PriceConverter.convertPrice(
                        context,
                        controller.total,
                      )} Đ",
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
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
                  controller.revenue,
                )} Đ",
                style: const TextStyle(
                  color: ColorResources.THEME_DEFAULT,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
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
                  controller.expenditure,
                )} Đ",
                style: const TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width / 3,
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
                    Radius.circular(10),
                  ),
                ),
                child: const Text(
                  "Thêm thu",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                width: size.width / 3,
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
                    Radius.circular(10),
                  ),
                ),
                child: const Text(
                  "Thêm chi",
                  style: TextStyle(color: Colors.white),
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
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width / 3,
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
                    Radius.circular(10),
                  ),
                ),
                child: const Text(
                  "Thêm thu",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                width: size.width / 3,
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
                    Radius.circular(10),
                  ),
                ),
                child: const Text(
                  "Thêm chi",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  ///
  /// split widget
  ///
  Widget _splitWidget(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double square = 4.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width / 2 - 3 * 15,
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
          width: size.width / 2 - 3 * 15,
          height: square,
          decoration: const BoxDecoration(
            color: Color(0xff4D4D4D),
          ),
        )
      ],
    );
  }
}
