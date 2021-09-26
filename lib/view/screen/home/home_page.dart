import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// template
import 'package:template/data/template/categories.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
// images
import 'package:template/utils/images.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  ///
  /// Group widget
  ///
  Widget _groupWidget(
      BuildContext context, double size, HomeController controller) {
    return CategoryWidget(
      text: "Tạo ID",
      label: 'Đội nhóm',
      icon: Icon(Icons.add_outlined,
          color: ColorResources.PRIMARY,
          size: DeviceUtils.getScaledSize(context, 0.045)),
      onPressed: () {
        controller.onRegisterIdClick();
      },
      content: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _danhMucBtn(
                  Container(
                    width: DeviceUtils.getScaledSize(context, 0.22),
                    height: DeviceUtils.getScaledSize(context, 0.22),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size / 3),
                        border:
                            Border.all(width: 3, color: Colors.grey.shade700),
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/dieukien.png",
                            ),
                            fit: BoxFit.fill)),
                  ),
                  'Kho hàng điều kiện', () {
                controller.onBtnKhoHangDieuKienClick();
                print("2");
              }),
              _danhMucBtn(
                  Container(
                    width: DeviceUtils.getScaledSize(context, 0.22),
                    height: DeviceUtils.getScaledSize(context, 0.22),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size / 3),
                        border:
                            Border.all(width: 3, color: Colors.grey.shade700),
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/trogia.png",
                            ),
                            fit: BoxFit.fill)),
                  ),
                  'Kho hàng trợ giá', () {
                controller.onProductVoucherClick();
                print("3");
              }),
            ],
          ),
        ],
      ),
      hasMore: true,
    );
  }

  ///
  /// Category widget
  ///
  Widget _categoryWidget(
      BuildContext context, double size, HomeController controller) {
    return controller.isLoading
        ? const Center(child: CircularProgressIndicator())
        : CategoryWidget(
            text: "Xem thêm",
            label: 'Danh mục',
            onPressed: () {
              controller.onBtnCategoriesClick(0);
            },
            content: controller.categoriesList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.85,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10),
                    itemCount: controller.categoriesList.length <= 6
                        ? controller.categoriesList.length
                        : 6,
                    itemBuilder: (BuildContext context, index) {
                      return _danhMucBtn(
                          Container(
                            width: DeviceUtils.getScaledSize(context, 0.178),
                            height: DeviceUtils.getScaledSize(context, 0.178),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(size / 3),
                              border: Border.all(
                                  width: 3, color: Colors.grey.shade700),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(size / 3),
                                child: Image.network(
                                  controller.categoriesList[index].thumbnail!,
                                  fit: BoxFit.fill,
                                )),
                          ),
                          controller.categoriesList[index].name!, () {
                        controller.onBtnCategoriesClick(index);
                      });
                    }),
            hasMore: true,
          );
  }

  ///
  /// nút trong danh muc
  ///
  Widget _danhMucBtn(Widget widget, String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          widget,
          const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
          Container(
            alignment: Alignment.center,
            width: Dimensions.CATEGORY_WIDTH_DEFAULT,
            child: Text(
              label,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF27272A),
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// banner
  ///
  Widget _imgProduct(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: controller.banner.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Image.asset(
          controller.banner[itemIndex].toString(),
          fit: BoxFit.fill,
          width: 1000,
        );
      },
      options: CarouselOptions(
        height: DeviceUtils.getScaledHeight(context, 0.35),
        autoPlay: true,
        viewportFraction: 1,
      ),
    );
  }

  ///
  /// avatar background user
  ///
  Widget _avatarBackgroundUser(BuildContext context) {
    // avatar width and height
    const double avatarWidth = 100;
    const double avatarHeight = 100;

    // get width and height
    final double width = context.mediaQuerySize.width;
    // final double height = context.mediaQuerySize.height;

    // pixel unit
    const double partOneHeight = 210;
    // const double partTwoHeight = 400;

    // margin left of avatar
    const double avatarMarginLeft = 20;

    // basic font size
    const double _moneyTextSize = Dimensions.FONT_SIZE_OVER_LARGE;
    const double _labelTextSize = Dimensions.FONT_SIZE_DEFAULT;

    // basic font weight
    const FontWeight _moneyFontWeight = FontWeight.bold;
    const FontWeight _labelFontWeight = FontWeight.normal;

    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Container(
            color: Colors.white,
            height: 460,
            child: Column(
              children: [
                Stack(
                  children: [
                    // background
                    Stack(
                      children: [
                        //banner
                        _imgProduct(context),
                        Container(
                          width: width,
                          height: partOneHeight,
                          margin: const EdgeInsets.only(top: 50),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Color(0xff333333)],
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // avatar user
                    Container(
                        margin: const EdgeInsets.only(
                            left: avatarMarginLeft,
                            top: 260 - avatarHeight / 2 - 10),
                        child: Stack(
                          children: [
                            // avatar
                            _avatarUser(
                                Images.admin_avatar, avatarWidth, avatarHeight),
                            // info of user
                            _infoUser(controller.name, controller.role,
                                Colors.white, Colors.white, avatarWidth)
                          ],
                        )),
                  ],
                ),
                // basic information statistic
                Column(
                  children: [
                    const SizedBox(
                      height: Dimensions.SPACE_HEIGHT_DEFAULT * 2,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: Column(
                            children: [
                              Text(
                                PriceConverter.convertPrice(
                                    context, controller.doanhSoDoiNhom!),
                                style: const TextStyle(
                                  fontSize: _moneyTextSize,
                                  fontWeight: _moneyFontWeight,
                                ),
                              ),
                              const Text(
                                "Doanh số đội nhóm",
                                style: TextStyle(
                                  fontSize: _labelTextSize,
                                  fontWeight: _labelFontWeight,
                                  color: Color(0xff999999),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width / 2,
                          child: Column(
                            children: [
                              Text(
                                PriceConverter.convertPrice(
                                    context, controller.doanhSoCaNhan!),
                                style: const TextStyle(
                                  fontSize: _moneyTextSize,
                                  fontWeight: _moneyFontWeight,
                                ),
                              ),
                              const Text(
                                "Doanh số cá nhân",
                                style: TextStyle(
                                  fontSize: _labelTextSize,
                                  fontWeight: _labelFontWeight,
                                  color: Color(0xff999999),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.SPACE_HEIGHT_DEFAULT * 2,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: Column(
                            children: [
                              Text(
                                controller.soLuongId!.toString(),
                                style: const TextStyle(
                                  fontSize: _moneyTextSize,
                                  fontWeight: _moneyFontWeight,
                                ),
                              ),
                              const Text(
                                "Số lượng ID",
                                style: TextStyle(
                                  fontSize: _labelTextSize,
                                  fontWeight: _labelFontWeight,
                                  color: Color(0xff999999),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width / 2,
                          child: Column(
                            children: [
                              Text(
                                controller.soLuongDonGia!.toString(),
                                style: const TextStyle(
                                  fontSize: _moneyTextSize,
                                  fontWeight: _moneyFontWeight,
                                ),
                              ),
                              const Text(
                                "Số lượng đơn giá",
                                style: TextStyle(
                                  fontSize: _labelTextSize,
                                  fontWeight: _labelFontWeight,
                                  color: Color(0xff999999),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  ///
  /// avatar of user declared
  ///
  Widget _avatarUser(String imageURL, double width, double height) {
    // return
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(width)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(width)),
        child: Image.asset(imageURL, width: width, height: height),
      ),
    );
  }

  ///
  /// info of info declared
  ///
  Widget _infoUser(String userName, String ruleName, Color userColor,
      Color ruleColor, double marginLeft) {
    // user name size is FONT_SIZE_EXTRA_LARGE
    const double userNameSize = Dimensions.FONT_SIZE_EXTRA_LARGE;

    // rule name size is FONT_SIZE_DEFAULT
    const double ruleNameSize = Dimensions.FONT_SIZE_DEFAULT;

    // @ is prefix rule name
    const String prefixRuleName = "@";

    return Container(
      margin: EdgeInsets.only(left: marginLeft + 20, top: marginLeft / 4 - 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              userName,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: userNameSize,
                  fontWeight: FontWeight.bold,
                  color: userColor),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              prefixRuleName + ruleName,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: ruleNameSize,
                fontWeight: FontWeight.normal,
                color: ruleColor,
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              controller.onGroupClick();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 35),
              alignment: Alignment.centerRight,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Xem thêm',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.normal,
                        color: ColorResources.PRIMARY,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: Dimensions.FONT_SIZE_DEFAULT,
                      color: ColorResources.PRIMARY,
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /**
     * Create home 2 part
     * - part 1: background and avatar and name
     * - part 2: content
     */

    return Scaffold(
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (HomeController controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              color: const Color(0xFFF5F5FA),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //avatar background user
                    _avatarBackgroundUser(context),

                    // Đội nhóm
                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),
                    _groupWidget(context,
                        DeviceUtils.getScaledSize(context, 0.178), controller),

                    // Danh mục
                    SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),
                    _categoryWidget(context,
                        DeviceUtils.getScaledSize(context, 0.178), controller)
                  ],
                ),
              ),
            );
          }),
    );
  }
}
