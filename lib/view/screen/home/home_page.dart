import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/home_page/info.dart';
// template
import 'package:template/data/template/categories.dart';
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

              // Danh mục
              const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
              _categoryWidget(Dimensions.CATEGORY_WIDTH_DEFAULT, controller),

              //Sản phẩm mới
              const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
              _sanPhamMoi(controller),

              // sản phẩm thịnh hành
              const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
              _sanPhamThinhHanh(controller),
            ],
          ),
        ),
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
          money: controller.moneyNormalize(6700000, ","),
          label: "Doanh số đội nhóm"),
      UserInfo(
          money: controller.moneyNormalize(6000000, ","),
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
          Container(
            margin: const EdgeInsets.only(right: 35),
            alignment: Alignment.centerRight,
            child:
                Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
              Text(
                'Xem thêm',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF1A94FF),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: Dimensions.FONT_SIZE_DEFAULT,
                color: Color(0xFF1A94FF),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

///
/// Category widget
///
Widget _categoryWidget(double size, HomeController controller) {
  return CategoryWidget(
    label: 'Danh mục',
    onPressed: () {
      controller.onBtnCategoriesClick();
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

///
/// nút trong danh muc
///
Widget _sanPhamDanhMucBtn(
    Image image, String label, int money, HomeController controller) {
  return SizedBox(
      height: 280,
      width: Dimensions.SQUARE_CATEGORY_SIZE,
      child: GestureDetector(
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                child: ClipRRect(
                    // borderRadius: BorderRadius.circular(20),
                    child: image)),
            const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                label,
                style: const TextStyle(
                    color: Color(0xFF27272A),
                    fontSize: Dimensions.FONT_SIZE_LARGE),
              ),
            ),
            const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "${controller.moneyNormalize(money, ",")} vnd",
                style: const TextStyle(
                  color: Color(0xFF27272A),
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          controller.onProductClick();
        },
      ));
}

Widget _sanPhamMoi(HomeController controller) {
  return CategoryWidget(
    hasMore: true,
    label: 'Sản phẩm mới',
    content: Column(children: [
      Row(children: [
        _sanPhamDanhMucBtn(
          Image.asset(
            Images.sp3,
            width: Dimensions.SQUARE_CATEGORY_SIZE,
            height: Dimensions.SQUARE_CATEGORY_SIZE,
          ),
          'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
          138000,
          controller,
        ),
        const Spacer(),
        _sanPhamDanhMucBtn(
          Image.asset(
            Images.sp4,
            width: Dimensions.SQUARE_CATEGORY_SIZE,
            height: Dimensions.SQUARE_CATEGORY_SIZE,
          ),
          'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
          138000,
          controller,
        ),
      ]),
      const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT * 2),
      Row(children: [
        _sanPhamDanhMucBtn(
          Image.asset(
            Images.sp3,
            width: Dimensions.SQUARE_CATEGORY_SIZE,
            height: Dimensions.SQUARE_CATEGORY_SIZE,
          ),
          'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
          138000,
          controller,
        ),
        const Spacer(),
        _sanPhamDanhMucBtn(
          Image.asset(
            Images.sp4,
            width: Dimensions.SQUARE_CATEGORY_SIZE,
            height: Dimensions.SQUARE_CATEGORY_SIZE,
          ),
          'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
          138000,
          controller,
        ),
      ])
    ]),
  );
}

Widget _sanPhamThinhHanh(HomeController controller) {
  return CategoryWidget(
    hasMore: true,
    label: 'Sản phẩm thịnh hành',
    content: Column(children: [
      Row(children: [
        _sanPhamDanhMucBtn(
          Image.asset(
            Images.sp3,
            width: Dimensions.SQUARE_CATEGORY_SIZE,
            height: Dimensions.SQUARE_CATEGORY_SIZE,
          ),
          'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
          138000,
          controller,
        ),
        const Spacer(),
        _sanPhamDanhMucBtn(
          Image.asset(
            Images.sp4,
            width: Dimensions.SQUARE_CATEGORY_SIZE,
            height: Dimensions.SQUARE_CATEGORY_SIZE,
          ),
          'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
          138000,
          controller,
        ),
      ]),
      const SizedBox(height: Dimensions.SPACE_HEIGHT_DEFAULT * 2),
      Row(children: [
        _sanPhamDanhMucBtn(
          Image.asset(
            Images.sp3,
            width: Dimensions.SQUARE_CATEGORY_SIZE,
            height: Dimensions.SQUARE_CATEGORY_SIZE,
          ),
          'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
          138000,
          controller,
        ),
        const Spacer(),
        _sanPhamDanhMucBtn(
          Image.asset(
            Images.sp4,
            width: Dimensions.SQUARE_CATEGORY_SIZE,
            height: Dimensions.SQUARE_CATEGORY_SIZE,
          ),
          'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
          138000,
          controller,
        ),
      ])
    ]),
  );
}
