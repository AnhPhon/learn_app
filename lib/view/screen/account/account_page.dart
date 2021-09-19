import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'account_controller.dart';

class AccountPage extends GetView<AccountController> {
  ///
  ///container box
  ///
  Container _containerBox(BuildContext context, {required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.017)),
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledSize(context, 0.06),
          horizontal: DeviceUtils.getScaledSize(context, 0.05)),
      decoration: BoxDecoration(
          color: ColorResources.WHITE, borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  ///
  ///row co 3 item
  ///
  Row _row3(BuildContext context,
      {required String text1,
      required String text2,
      required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text1,
            style: Dimensions.fontSizeStyle18w600(),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(text2,
              style: const TextStyle(
                color: ColorResources.PRIMARY,
              )),
        ),
        SizedBox(width: DeviceUtils.getScaledSize(context, 0.01)),
        Icon(
          Icons.arrow_forward_ios,
          color: ColorResources.PRIMARY,
          size: DeviceUtils.getScaledSize(context, 0.035),
        ),
      ],
    );
  }

  ///
  ///icons method
  ///
  Widget _iconMethod(BuildContext context,
      {required String imgUrl, required String text}) {
    return Expanded(
      child: Column(
        children: [
          SvgPicture.asset(imgUrl),
          SizedBox(height: DeviceUtils.getScaledSize(context, 0.04)),
          Text(
            text,
            textAlign: TextAlign.center,
            style: Dimensions.fontSizeStyle16(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(DeviceUtils.getScaledSize(context, 0.038)),
          child: Align(
            child: Column(
              children: [
                //image
                Container(
                  margin: EdgeInsets.only(
                      bottom: DeviceUtils.getScaledSize(context, 0.02)),
                  height: DeviceUtils.getScaledSize(context, 0.183),
                  width: DeviceUtils.getScaledSize(context, 0.183),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/avatar_account.png")),
                    shape: BoxShape.circle,
                  ),
                ),
                //name
                Text(
                  "Khoi Minh",
                  style: Dimensions.fontSizeStyle16w600(),
                ),

                SizedBox(height: DeviceUtils.getScaledSize(context, 0.02)),

                //ID
                Text(
                  "ID: ytb00000",
                  style: Dimensions.fontSizeStyle16(),
                ),

                SizedBox(height: DeviceUtils.getScaledSize(context, 0.04)),

                //order cua toi
                _containerBox(context,
                    child: Column(
                      children: [
                        _row3(context,
                            text1: "Order của tôi",
                            text2: "Xem thêm", onTap: () {
                          controller.onOrderClick();
                        }),
                        SizedBox(
                            height: DeviceUtils.getScaledSize(context, 0.1)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _iconMethod(context,
                                imgUrl: "assets/icon/wallet.svg",
                                text: "Chờ thanh toán"),
                            _iconMethod(context,
                                imgUrl: "assets/icon/forklift_truck.svg",
                                text: "Xử lý"),
                            _iconMethod(context,
                                imgUrl: "assets/icon/delivery_truck.svg",
                                text: "Shipping"),
                          ],
                        ),
                      ],
                    )),

                //rules
                _containerBox(context,
                    child: _row3(context,
                        text1: "Điều khoản", text2: "Chi tiết", onTap: () {
                      controller.onRulesClick();
                    })),

                //share
                _containerBox(context,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("Chia sẻ",
                              style: Dimensions.fontSizeStyle18w600()),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
