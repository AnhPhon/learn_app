import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/leaderboard/charts/charts_controller.dart';

class ChartsPage extends GetView<ChartsController> {
  ///
  ///circle avatar
  ///
  Widget _circleAvatar(BuildContext context,
      {required String imgUrl, required int rank}) {
    return Container(
      margin: EdgeInsets.only(top: DeviceUtils.getScaledSize(context, 0.04)),
      height: DeviceUtils.getScaledSize(context, 0.18),
      width: DeviceUtils.getScaledSize(context, 0.18),
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: rank == 1
              ? const Color(0xffFFC107)
              : rank == 2
                  ? ColorResources.GREY
                  : rank == 3
                      ? ColorResources.PRIMARY
                      : ColorResources.WHITE,
        ),
        image: const DecorationImage(
            image: AssetImage("assets/images/avatar_account.png")),
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return GetBuilder<ChartsController>(
        init: ChartsController(),
        builder: (ChartsController value) {
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: CustomAppBar().customAppBar(title: "Mục bảng thống kê"),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: DeviceUtils.getScaledSize(context, 0.04)),
                  SizedBox(
                    height: DeviceUtils.getScaledSize(context, 0.75),
                    child: Stack(
                      children: [
                        Positioned(
                          top: DeviceUtils.getScaledSize(context, 0.305),
                          right: DeviceUtils.getScaledSize(context, 0.203),
                          child: Image.asset(
                            Images.charts,
                            height: DeviceUtils.getScaledSize(context, 0.382),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  DeviceUtils.getScaledSize(context, 0.127)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //2nd
                              Column(
                                children: [
                                  SizedBox(
                                      height: DeviceUtils.getScaledSize(
                                          context, 0.05)),
                                  _circleAvatar(context,
                                      imgUrl:
                                          "assets/images/avatar_account.png",
                                      rank: 2),
                                  Text("Bảo\n45.000.000 đ",
                                      textAlign: TextAlign.center,
                                      style: Dimensions.fontSizeStyle14w600()),
                                ],
                              ),

                              //1st
                              Column(
                                children: [
                                  Stack(
                                    children: [
                                      _circleAvatar(context,
                                          imgUrl:
                                              "assets/images/avatar_account.png",
                                          rank: 1),
                                      Positioned(
                                          right: DeviceUtils.getScaledSize(
                                              context, 0.06),
                                          child: SvgPicture.asset(
                                              "assets/icon/crown.svg")),
                                    ],
                                  ),
                                  Text("Phương\n50.000.000 đ",
                                      textAlign: TextAlign.center,
                                      style: Dimensions.fontSizeStyle14w600()),
                                ],
                              ),

                              //3rd
                              Column(
                                children: [
                                  SizedBox(
                                      height: DeviceUtils.getScaledSize(
                                          context, 0.05)),
                                  _circleAvatar(context,
                                      imgUrl:
                                          "assets/images/avatar_account.png",
                                      rank: 3),
                                  Text("Thành\n40.000.000 đ",
                                      textAlign: TextAlign.center,
                                      style: Dimensions.fontSizeStyle14w600()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledSize(context, 0.063),
                        vertical: DeviceUtils.getScaledSize(context, 0.025)),
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2, // Shadow position
                        ),
                      ],
                    ),
                    child: Column(children: [
                      SizedBox(
                          height: DeviceUtils.getScaledSize(context, 0.025)),
                      ...List.generate(
                          11,
                          (index) => Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: DeviceUtils.getScaledSize(
                                            context, 0.03)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${index + 1}",
                                            style: Dimensions
                                                .fontSizeStyle18w600(),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Row(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: DeviceUtils
                                                        .getScaledSize(
                                                            context, 0.025)),
                                                height:
                                                    DeviceUtils.getScaledSize(
                                                        context, 0.12),
                                                width:
                                                    DeviceUtils.getScaledSize(
                                                        context, 0.12),
                                                decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/avatar_account.png")),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Text("Tên ${index + 1}"),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Align(
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  DeviceUtils.getScaledSize(
                                                      context, 0.015)),
                                              decoration: BoxDecoration(
                                                  color: ColorResources.GREY,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: const Text(
                                                "5.000.000đ",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: DeviceUtils.getScaledSize(
                                          context, 0.01),
                                      horizontal: DeviceUtils.getScaledSize(
                                          context, 0.05),
                                    ),
                                    child: const Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )).toList(),
                    ]),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
