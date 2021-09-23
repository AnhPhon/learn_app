import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/custom_appbar.dart';
import 'package:template/view/screen/group/group_controller.dart';

class GroupPage extends GetView<GroupController> {
  ///
  /// avatar of user declared
  ///
  Widget _avatarUser(BuildContext context, String imageURL) {
    // return
    return Container(
      width: DeviceUtils.getScaledSize(context, 0.254),
      height: DeviceUtils.getScaledSize(context, 0.254),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imageURL),
        ),
        border: Border.all(width: 3, color: ColorResources.WHITE),
      ),
    );
  }

  ///
  /// info of info declared
  ///
  Widget _infoUser(BuildContext context, String userName, String ruleName,
      Color userColor, Color ruleColor, double marginLeft) {
    // user name size is FONT_SIZE_EXTRA_LARGE
    const double userNameSize = Dimensions.FONT_SIZE_EXTRA_LARGE;

    // rule name size is FONT_SIZE_DEFAULT
    const double ruleNameSize = Dimensions.FONT_SIZE_DEFAULT;

    // @ is prefix rule name
    const String prefixRuleName = "@";

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.012)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Text(
              "Doanh số cá nhân: ${PriceConverter.convertPrice(context, 10000000)}"),
          Text(
              "Doanh số đội nhóm: ${PriceConverter.convertPrice(context, 60000000)}")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupController>(
        init: GroupController(),
        builder: (GroupController value) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                      right: DeviceUtils.getScaledSize(context, 0.025)),
                  child: GestureDetector(
                    onTap: () {
                      showDateRangePicker(
                        locale: const Locale("vi", "VI"),
                        context: context,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2050),
                      ).then((value) => print("thời gian đã chọn: $value"));
                    },
                    child: const Icon(Icons.calendar_today_outlined,
                        color: ColorResources.PRIMARY),
                  ),
                ),
              ],
              leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios)),
              backgroundColor: ColorResources.WHITE,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text(
                "Đội nhóm",
                style: TextStyle(color: ColorResources.BLACK),
              ),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset(
                    Images.admin_background,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: DeviceUtils.getScaledSize(context, 0.05),
                          top: DeviceUtils.getScaledSize(context, 0.127)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // avatar
                          _avatarUser(context, Images.admin_avatar),

                          SizedBox(
                              width: DeviceUtils.getScaledSize(context, 0.04)),

                          // info of user
                          _infoUser(context, 'Khoi Minh', 'administration',
                              Colors.black, Colors.black, 100)
                        ],
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: DeviceUtils.getScaledSize(context, 0.03)),
                    transform: Matrix4.translationValues(
                        0, DeviceUtils.getScaledSize(context, 0.458), 1),
                    decoration: const BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(children: [
                      SizedBox(
                          height: DeviceUtils.getScaledSize(context, 0.025)),
                      ...List.generate(
                          20,
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
