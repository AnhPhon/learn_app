import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/large_size_app_bar.dart';
import 'package:template/view/screen/v3-agent/account/account_controller.dart';

class V3AccountPage extends GetView<V3AccountController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3AccountController>(
        init: V3AccountController(),
        builder: (V3AccountController controller) {
          return Scaffold(
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
                        _avatar(context, controller),

                        // profile
                        _items(
                          icon: const Icon(Icons.account_circle_outlined),
                          text: "Hồ sơ cá nhân (thuế, sức khoẻ, bảo hiểm, HĐ)",
                          onTap: () => controller.onProfileClick(),
                        ),

                        // personal information
                        _items(
                          icon: const Icon(Icons.person_outlined),
                          text: "Thông tin cá nhân (chỉnh sửa nếu có thể)",
                          onTap: () {},
                        ),

                        // point-based
                        _items(
                          icon: const Icon(Icons.monetization_on_outlined),
                          text: "Tổng đơn và tích điểm",
                          onTap: () => controller.onPointBasedPageClick(),
                        ),

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
                          icon: const Icon(Icons.person_outlined),
                          text: "Đánh giá",
                          onTap: () {},
                        ),

                        // history
                        _items(
                          icon: const Icon(Icons.history),
                          text: "Lịch sử",
                          onTap: () {},
                        ),

                        // support
                        _items(
                          icon: const Icon(Icons.account_circle_outlined),
                          text: "Hỗ trợ",
                          onTap: () => controller.onHelpPageClick(),
                        ),

                        // hướng dẫn lao động an toàn
                        _items(
                          icon: const Icon(Icons.work),
                          text: "Hướng dẫn lao động an toàn",
                          onTap: () {},
                        ),

                        // Cập nhập sản phẩm mẫu
                        _items(
                          icon: const Icon(Icons.work),
                          text: "Cập nhập sản phẩm mẫu",
                          onTap: () {},
                        ),

                        // introduce
                        _items(
                          icon: const Icon(Icons.groups),
                          text: "Mời bạn, giới thiệu bạn tích luỹ",
                          onTap: () => controller.onIntroducePageClick(),
                        ),

                        // mail
                        _items(
                          icon: const Icon(Icons.local_post_office),
                          text: "Hộp thư",
                          onTap: () {},
                        ),

                        // image update
                        // _items(
                        //   icon: const Icon(Icons.image),
                        //   text: "Cập nhật hình ảnh",
                        //   onTap: () {},
                        // ),

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
  Widget _avatar(BuildContext context, V3AccountController controller) {
    return Stack(
      children: [
        Column(
          children: [
            //image
            Container(
              margin:
                  const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_SMALL),
              height: DeviceUtils.getScaledSize(context, .2),
              width: DeviceUtils.getScaledSize(context, .2),
              child: ClipOval(
                child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    image: controller.urlImage,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (c, o, s) => const CircleAvatar(
                        backgroundImage: AssetImage(Images.placeholder))),
              ),
            ),

            //full name
            Text(
              controller.name,
              style: Dimensions.fontSizeStyle16w600(),
            ),

            SizedBox(
              height: DeviceUtils.getScaledHeight(context, .01),
            ),

            //email
            Text(
              controller.email,
              style: Dimensions.fontSizeStyle16w600(),
            ),

            SizedBox(
              height: DeviceUtils.getScaledHeight(context, .01),
            ),
          ],
        ),
        Positioned(
          right: Dimensions.PADDING_SIZE_LARGE,
          top: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
          child: GestureDetector(
            onTap: () {
              // controller.onEditInfoClick();
            },
            child: Container(
              padding:
                  const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: const BoxDecoration(
                  color: ColorResources.WHITE,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: const Icon(
                Icons.add_a_photo_outlined,
                color: ColorResources.PRIMARY,
                size: Dimensions.ICON_SIZE_SMALL,
              ),
            ),
          ),
        )
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
        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),,
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
