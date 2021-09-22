import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/home_page/info.dart';
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
  @override
  Widget build(BuildContext context) {
    /**
     * Create home 2 part
     * - part 1: background and avatar and name
     * - part 2: content
     */

    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        color: const Color(0xFFF5F5FA),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //avatar background user
              _avatarBackgroundUser(context),

              //banner
              _imgProduct(context),

              //Đội nhóm
              SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),
              _groupWidget(context, DeviceUtils.getScaledSize(context, 0.178),
                  controller),

              // Danh mục
              SizedBox(height: DeviceUtils.getScaledSize(context, 0.025)),
              _categoryWidget(
                  DeviceUtils.getScaledSize(context, 0.178), controller)
            ],
          ),
        ),
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
        height: DeviceUtils.getScaledHeight(context, 0.3),
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

    final List<UserInfo> _basicInformationStatistic = [
      UserInfo(
          money: PriceConverter.convertPrice(context, 6000000),
          label: "Doanh số đội nhóm"),
      UserInfo(
          money: PriceConverter.convertPrice(context, 6000000),
          label: "Doanh số cá nhân"),
      UserInfo(money: "3", label: "Số lượng ID"),
      UserInfo(money: "17", label: "Số lượng đơn giá")
    ];

    return Container(
      color: Colors.white,
      height: 420,
      child: Column(
        children: [
          Stack(
            children: [
              // background
              Stack(
                children: [
                  Image.asset(
                    Images.admin_background,
                    width: width,
                  ),
                  Container(
                    width: width,
                    height: partOneHeight,
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
                      top: partOneHeight - avatarHeight / 2 - 10),
                  child: Stack(
                    children: [
                      // avatar
                      _avatarUser(
                          Images.admin_avatar, avatarWidth, avatarHeight),
                      // info of user
                      _infoUser('Khoi Minh', 'administration', Colors.white,
                          Colors.white, avatarWidth)
                    ],
                  )),

              // notification - fix
              Positioned(
                right: 0,
                top: 20,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        CupertinoIcons.bell,
                        size: 30,
                        color: Colors.white,
                      )),
                ),
              ),
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
                          _basicInformationStatistic[0].money!,
                          style: const TextStyle(
                            fontSize: _moneyTextSize,
                            fontWeight: _moneyFontWeight,
                          ),
                        ),
                        Text(
                          _basicInformationStatistic[0].label!,
                          style: const TextStyle(
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
                          _basicInformationStatistic[1].money!,
                          style: const TextStyle(
                            fontSize: _moneyTextSize,
                            fontWeight: _moneyFontWeight,
                          ),
                        ),
                        Text(
                          _basicInformationStatistic[1].label!,
                          style: const TextStyle(
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
                          _basicInformationStatistic[2].money!,
                          style: const TextStyle(
                            fontSize: _moneyTextSize,
                            fontWeight: _moneyFontWeight,
                          ),
                        ),
                        Text(
                          _basicInformationStatistic[2].label!,
                          style: const TextStyle(
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
                          _basicInformationStatistic[3].money!,
                          style: const TextStyle(
                            fontSize: _moneyTextSize,
                            fontWeight: _moneyFontWeight,
                          ),
                        ),
                        Text(
                          _basicInformationStatistic[3].label!,
                          style: const TextStyle(
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
}

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
                ClipRRect(
                  borderRadius: BorderRadius.circular(size / 3),
                  child: Image.asset(
                    Images.template,
                    width: size,
                    height: size,
                  ),
                ),
                'Kho hàng điều kiện', () {
              controller.onBtnCategoriesDetailClick();
              print("2");
            }),
            _danhMucBtn(
                ClipRRect(
                  borderRadius: BorderRadius.circular(size / 3),
                  child: Image.asset(
                    Images.template,
                    width: size,
                    height: size,
                  ),
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
Widget _categoryWidget(double size, HomeController controller) {
  return CategoryWidget(
    text: "Xem thêm",
    label: 'Danh mục',
    onPressed: () {
      controller.onBtnCategoriesClick(0);
    },
    content: Column(
      children: [
        Row(
          children: [
            const Spacer(),
            _danhMucBtn(
                ClipRRect(
                  borderRadius: BorderRadius.circular(size / 3),
                  child: Image.asset(
                    Images.template,
                    width: size,
                    height: size,
                  ),
                ),
                'Nước giặt', () {
              controller.onBtnCategoriesClick(0);
              print("1");
            }),
            const SizedBox(width: Dimensions.SPACE_WIDTH_FAR),
            _danhMucBtn(
                ClipRRect(
                  borderRadius: BorderRadius.circular(size / 3),
                  child: Image.asset(
                    Images.template,
                    width: size,
                    height: size,
                  ),
                ),
                'Viên nén', () {
              controller.onBtnCategoriesClick(1);
              print("2");
            }),
            const SizedBox(width: Dimensions.SPACE_WIDTH_FAR),
            _danhMucBtn(
                ClipRRect(
                  borderRadius: BorderRadius.circular(size / 3),
                  child: Image.asset(
                    Images.template,
                    width: size,
                    height: size,
                  ),
                ),
                'Kiềm', () {
              controller.onBtnCategoriesClick(2);
              print("3");
            }),
            const Spacer(),
          ],
        ),
        const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT * 3),
        Row(
          children: [
            const Spacer(),
            _danhMucBtn(
                ClipRRect(
                  borderRadius: BorderRadius.circular(size / 3),
                  child: Image.asset(
                    Images.template,
                    width: size,
                    height: size,
                  ),
                ),
                'Viên Hàn Lâm', () {
              controller.onBtnCategoriesClick(3);
              print("4");
            }),
            const SizedBox(width: Dimensions.SPACE_WIDTH_FAR),
            _danhMucBtn(
                ClipRRect(
                  borderRadius: BorderRadius.circular(size / 3),
                  child: Image.asset(
                    Images.template,
                    width: size,
                    height: size,
                  ),
                ),
                'Hóa mỹ phẩm', () {
              controller.onBtnCategoriesClick(4);
              print("5");
            }),
            const SizedBox(width: Dimensions.SPACE_WIDTH_FAR),
            _danhMucBtn(
                ClipRRect(
                  borderRadius: BorderRadius.circular(size / 3),
                  child: Image.asset(
                    Images.template,
                    width: size,
                    height: size,
                  ),
                ),
                'Khác', () {
              controller.onBtnCategoriesClick(5);
              print("6");
            }),
            const Spacer(),
          ],
        )
      ],
    ),
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
