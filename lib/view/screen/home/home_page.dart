import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

// images
import 'package:template/utils/images.dart';

import 'home_controller.dart';
import 'package:template/data/model/home_page/info.dart';

// template
import 'package:template/data/template/categories.dart';

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
        color: Color(0xFFF5F5FA),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _avatarBackgroundUser(context),

              // Danh mục
              SizedBox(height: 10),
              CategoryWidget(
                label: 'Danh mục',
                content: Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _danhMucBtn(
                              Image.asset(
                                Images.template,
                                width: 120,
                                height: 120,
                              ),
                              'Nước giặt'
                          ),
                          Spacer(flex: 1,),
                          _danhMucBtn(
                              Image.asset(
                                Images.template,
                                width: 120,
                                height: 120,
                              ),
                              'Viên nén'
                          ),
                          Spacer(flex: 1,),
                          _danhMucBtn(
                              Image.asset(
                                Images.template,
                                width: 120,
                                height: 120,
                              ),
                              'Kiềm'
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _danhMucBtn(
                              Image.asset(
                                Images.template,
                                width: 120,
                                height: 120,
                              ),
                              'Viên Hàn Lâm'
                          ),
                          Spacer(flex: 1,),
                          _danhMucBtn(
                              Image.asset(
                                Images.template,
                                width: 120,
                                height: 120,
                              ),
                              'Hóa mỹ phẩm'
                          ),
                          Spacer(flex: 1,),
                          _danhMucBtn(
                              Image.asset(
                                Images.template,
                                width: 120,
                                height: 120,
                              ),
                              'Khác'
                          ),
                        ],
                      )
                    ],
                  )
                ),
                hasMore: true,
              ),

              //Sản phẩm mới
              SizedBox(height: 10),
              CategoryWidget(
                hasMore: true,
                label: 'Sản phẩm mới',
                content: Column(
                  children: [
                    Row(
                      children: [
                        _sanPhamDanhMucBtn(
                            Image.asset(
                                Images.sp3,
                              width: 170,
                              height: 170
                            ),
                            'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
                            138000,
                            controller,
                        ),
                        Spacer(flex: 1),
                        _sanPhamDanhMucBtn(
                          Image.asset(
                              Images.sp4,
                              width: 170,
                              height: 170
                          ),
                          'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
                          138000,
                          controller,
                        ),
                      ]
                    ),
                    SizedBox(height: 20),
                    Row(
                        children: [
                          _sanPhamDanhMucBtn(
                            Image.asset(
                                Images.sp3,
                                width: 170,
                                height: 170
                            ),
                            'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
                            138000,
                            controller,
                          ),
                          Spacer(flex: 1),
                          _sanPhamDanhMucBtn(
                            Image.asset(
                                Images.sp4,
                                width: 170,
                                height: 170
                            ),
                            'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
                            138000,
                            controller,
                          ),
                        ]
                    )
                  ]
                ),
              ),

              // sản phẩm thịnh hành
              SizedBox(height: 10),
              CategoryWidget(
                hasMore: true,
                label: 'Sản phẩm thịnh hành',
                content: Column(
                    children: [
                      Row(
                          children: [
                            _sanPhamDanhMucBtn(
                              Image.asset(
                                  Images.sp3,
                                  width: 170,
                                  height: 170
                              ),
                              'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
                              138000,
                              controller,
                            ),
                            Spacer(flex: 1),
                            _sanPhamDanhMucBtn(
                              Image.asset(
                                  Images.sp4,
                                  width: 170,
                                  height: 170
                              ),
                              'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
                              138000,
                              controller,
                            ),
                          ]
                      ),
                      SizedBox(height: 20),
                      Row(
                          children: [
                            _sanPhamDanhMucBtn(
                              Image.asset(
                                  Images.sp3,
                                  width: 170,
                                  height: 170
                              ),
                              'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-CAM',
                              138000,
                              controller,
                            ),
                            Spacer(flex: 1),
                            _sanPhamDanhMucBtn(
                              Image.asset(
                                  Images.sp4,
                                  width: 170,
                                  height: 170
                              ),
                              'DK NƯỚC GIẶT CAO CẤP HOSHI 3,8L-TRẮNG',
                              138000,
                              controller,
                            ),
                          ]
                      )
                    ]
                ),
              ),

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
    double avatarWidth = 100;
    double avatarHeight = 100;

    // get width and height
    double width = context.mediaQuerySize.width;
    double height = context.mediaQuerySize.height;

    // pixel unit
    double partOneHeight = 210;
    double partTwoHeigh = 400;

    // margin left of avatar
    double avatarMarginLeft = 20;

    // basic font size
    double _moneyTextSize = 18;
    double _labelTextSize = 12;

    // basic font weight
    FontWeight _moneyFontWeight = FontWeight.bold;
    FontWeight _labelFontWeight = FontWeight.normal;

    List<UserInfo> _basicInformationStatistic = [
      UserInfo(money: controller.moneyNormalize(6700000, ","), label: "Doanh số đội nhóm"),
      UserInfo(money: controller.moneyNormalize(6000000, ","), label: "Doanh số cá nhân"),
      UserInfo(money: "3", label: "Số lượng ID"),
      UserInfo(money: "17", label: "Số lượng đơn giá")
    ];

    return Container(
      color: Colors.white,
      height: 400,
      child: Column(
        children: [
          Stack(
            children: [
              // background
              Stack(
                children: [
                  Container(
                    child: Image.asset(
                      Images.admin_background,
                      width: width,
                    ),
                  ),
                  Container(
                    width: width,
                    height: partOneHeight,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.transparent,
                          Color(0xff333333)
                        ], begin: Alignment.center, end: Alignment.bottomCenter)
                    ),
                  ),
                ],
              ),
              // avatar user
              Container(
                  margin: EdgeInsets.only(
                      left: avatarMarginLeft,
                      top: partOneHeight - avatarHeight / 2 - 10
                  ),
                  child: Container(
                    child: Stack(
                      children: [
                        // avatar
                        _avatarUser(Images.admin_avatar, avatarWidth, avatarHeight),
                        // info of user
                        _infoUser('Khoi Minh', 'administration', Colors.white, Colors.white, avatarWidth)
                      ],
                    ),
                  )
              ),
              // notification
              Positioned(
                right: 0,
                top: 20,
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(CupertinoIcons.bell, size: 30),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      shape: MaterialStateProperty.all(CircleBorder()),
                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // basic information statistic
          Column(
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    width: width/2,
                    child: Column(
                      children: [
                        Text(
                          _basicInformationStatistic[0].money!,
                          style: TextStyle(
                            fontSize: _moneyTextSize,
                            fontWeight: _moneyFontWeight,
                          ),
                        ),
                        Text(
                          _basicInformationStatistic[0].label!,
                          style: TextStyle(
                            fontSize: _labelTextSize,
                            fontWeight: _labelFontWeight,
                            color: Color(0xff999999),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width/2,
                    child: Column(
                      children: [
                        Text(
                          _basicInformationStatistic[1].money!,
                          style: TextStyle(
                            fontSize: _moneyTextSize,
                            fontWeight: _moneyFontWeight,
                          ),
                        ),
                        Text(
                          _basicInformationStatistic[1].label!,
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
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    width: width/2,
                    child: Column(
                      children: [
                        Text(
                          _basicInformationStatistic[2].money!,
                          style: TextStyle(
                            fontSize: _moneyTextSize,
                            fontWeight: _moneyFontWeight,
                          ),
                        ),
                        Text(
                          _basicInformationStatistic[2].label!,
                          style: TextStyle(
                            fontSize: _labelTextSize,
                            fontWeight: _labelFontWeight,
                            color: Color(0xff999999),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width/2,
                    child: Column(
                      children: [
                        Text(
                          _basicInformationStatistic[3].money!,
                          style: TextStyle(
                            fontSize: _moneyTextSize,
                            fontWeight: _moneyFontWeight,
                          ),
                        ),
                        Text(
                          _basicInformationStatistic[3].label!,
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
  }

  ///
  /// avatar of user declared
  ///
  Widget _avatarUser(String imageURL, double width, double height) {

    // return
    return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(width)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(width)),
        child: Image.asset(
            imageURL,
            width: width,
            height: height
        ),
      ),
    );
  }

  ///
  /// info of info declared
  ///
  Widget _infoUser(String userName, String ruleName, Color userColor, Color ruleColor, double marginLeft) {

    // user name size is 14 pixel
    double userNameSize = 18;

    // rule name size is 10 pixel
    double ruleNameSize = 13;

    // @ is prefix rule name
    String prefixRuleName = "@";

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
                  color: userColor
              ),
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
                  color: ruleColor
              ),
            ),
          ),

        ],
      ),
    );
  }
}

///
/// nút trong danh muc
///
Widget _danhMucBtn(Image image, String label) {
  return ElevatedButton(
    style: ButtonStyle(
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      padding: MaterialStateProperty.all(EdgeInsets.all(0)),
    ),
    child: Column(
      children: [
        Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(120),
              child: image
            )
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
                color: Color(0xFF27272A),
                fontSize: 14
            ),
          ),
        ),
      ],
    ),
    onPressed: (){},
  );
}


///
/// nút trong danh muc
///
Widget _sanPhamDanhMucBtn(Image image, String label, int money, HomeController controller) {
  return Container(
    width: 170,
    child: ElevatedButton(
      style: ButtonStyle(
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        padding: MaterialStateProperty.all(EdgeInsets.all(0)),
      ),
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              child: ClipRRect(
                  // borderRadius: BorderRadius.circular(20),
                  child: image
              )
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                  color: Color(0xFF27272A),
                  fontSize: 14
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              controller.moneyNormalize(money, ",") + " vnd",
              style: TextStyle(
                color: Color(0xFF27272A),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      onPressed: (){},
    )
  );
}