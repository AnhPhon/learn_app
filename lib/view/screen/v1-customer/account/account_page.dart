import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/large_size_app_bar.dart';
import 'package:template/view/screen/v1-customer/account/account_controller.dart';

class V1AccountPage extends GetView<V1AccountController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1AccountController>(
        init: V1AccountController(),
        builder: (V1AccountController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: const Text(
                "Tài khoản",
                style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                ),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Stack(
              children: [
                LargeSizeAppBar(title: controller.title),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  transform: Matrix4.translationValues(0, 130, 1),
                  decoration: const BoxDecoration(
                    color: Color(0xffF6F6F7),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.BORDER_RADIUS_LARGE),
                      topLeft: Radius.circular(Dimensions.BORDER_RADIUS_LARGE),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(context, .013),
                        ),

                        // avatar
                        _avatar(context, controller: controller),

                        // profile
                        _items(
                          icon: const Icon(Icons.account_circle_outlined),
                          text: "Hồ sơ cá nhân",
                          onTap: () => controller.onProfileClick(),
                        ),

                        // personal information
                        _items(
                          icon: const Icon(Icons.person_outlined),
                          text: "Thông tin cá nhân",
                          onTap: () => controller.onPersonalInfoClick(),
                        ),

                        // point-based
                        // _items(
                        //   icon: const Icon(Icons.monetization_on_outlined),
                        //   text: "Tổng đơn và tích điểm",
                        //   onTap: () => controller.onPointBasedPageClick(),
                        // ),

                        // wallet
                        _items(
                          icon:
                              const Icon(Icons.account_balance_wallet_outlined),
                          text: "Ví FSS",
                          onTap: () => controller.onWalletPageClick(),
                        ),

                        // rules
                        _items(
                          icon: const Icon(Icons.gavel_outlined),
                          text: "Điều khoản và chính sách",
                          onTap: () => controller.onRulesPageClick(),
                        ),

                        // Review
                        _items(
                          icon: const Icon(Icons.star_half),
                          text: "Đánh giá",
                          onTap: () => controller.showDialogRating(context),
                        ),

                        // support
                        _items(
                          icon: const Icon(Icons.account_circle_outlined),
                          text: "Hỗ trợ",
                          onTap: () => controller.onHelpPageClick(),
                        ),

                        // job management
                        _items(
                          icon: const Icon(Icons.work),
                          text: "Quản lý công việc",
                          onTap: () => controller.onJobManagementClick(),
                        ),

                        // introduce
                        _items(
                          icon: const Icon(Icons.groups),
                          text: "Mời bạn, giới thiệu bạn tích luỹ",
                          onTap: () => Share.share('http://izisoft.io/'),
                          // onTap: () => controller.onIntroducePageClick(),
                        ),

                        // mail
                        _items(
                          icon: const Icon(Icons.local_post_office),
                          text: "Hộp thư",
                          onTap: () => controller.onMailClick(),
                        ),

                        // my order
                        _items(
                          icon: const Icon(Icons.shopping_cart_outlined),
                          text: "Đơn hàng của tôi",
                          onTap: () => controller.onMyOrderClick(),
                        ),

                        const SizedBox(
                          height: Dimensions.SIZE_BOX_BOTTOM_NAV,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  ///
  ///avatar
  ///
  Widget _avatar(BuildContext context,
      {required V1AccountController controller}) {
    return Column(
      children: [
        //image
        Container(
          margin: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
          height: DeviceUtils.getScaledSize(context, .2),
          width: DeviceUtils.getScaledSize(context, .2),
          child: ClipOval(
            child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                image: controller.taiKhoanResponse.hinhDaiDien.toString(),
                fit: BoxFit.cover,
                imageErrorBuilder: (c, o, s) => const CircleAvatar(
                    backgroundImage: AssetImage(Images.placeholder))),
          ),
        ),

        //full name
        Text(
          controller.taiKhoanResponse.hoTen.toString(),
          style: Dimensions.fontSizeStyle16w600(),
        ),

        SizedBox(
          height: DeviceUtils.getScaledHeight(context, .01),
        ),

        //email
        Text(
          controller.taiKhoanResponse.email.toString(),
          style: Dimensions.fontSizeStyle16w600(),
        ),

        SizedBox(
          height: DeviceUtils.getScaledHeight(context, .01),
        ),
      ],
    );
  }

  ///
  ///items
  ///
  Widget _items(
      {required Icon icon, required String text, required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
      ),
      color: ColorResources.WHITE,
      // shadowColor: ColorResources.BLACK.withOpacity(.4),
      margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_SMALL),
      child: ListTile(
        onTap: onTap,
        leading: icon,
        title: Text(text),
      ),
    );
  }
}
