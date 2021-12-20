import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/refer_friends/refer_friends_controller.dart';

class ReferFriendsPage extends GetView<ReferFriendsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAccount(),
      appBar: IZIAppBar(
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
        title: "Giới thiệu bạn bè",
      ),
      body: GetBuilder(
        init: ReferFriendsController(),
        builder: (ReferFriendsController controller) {
          return Container(
            constraints: BoxConstraints(
              minHeight: IZIDimensions.iziSize.height,
              minWidth: IZIDimensions.iziSize.width,
            ),
            decoration: const BoxDecoration(
              color: ColorResources.BACKGROUND,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Ảnh bìa giới thiệu
                Container(
                  width: IZIDimensions.iziSize.width,
                  height: IZIDimensions.iziSize.height * .3,
                  child: IZIImage(
                    "https://scontent.fdad3-4.fna.fbcdn.net/v/t39.30808-6/245318999_419016769745455_6271160399218610947_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=e3f864&_nc_ohc=b8_COlIkVrMAX89FRPG&_nc_ht=scontent.fdad3-4.fna&oh=00_AT8ydHr1uZ4FJ3m_g739BHTVPyIcakoV-v2UgZ9BeN0w8w&oe=61BF73E0",
                  ),
                ),

                Container(
                  width: IZIDimensions.iziSize.width,
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_3X,
                    ),
                    color: ColorResources.BACKGROUND,
                    boxShadow: IZIOther().boxShadow,
                  ),
                  child: Column(
                    children: [
                      //Link giới thiệu bạn bè
                      _linkShare(controller),

                      //Quét mã QR
                      Container(
                        width: IZIDimensions.iziSize.width,
                        padding: EdgeInsets.fromLTRB(
                          IZIDimensions.SPACE_SIZE_4X,
                          IZIDimensions.SPACE_SIZE_4X,
                          IZIDimensions.SPACE_SIZE_4X,
                          IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        bottom: IZIDimensions.SPACE_SIZE_2X,
                                      ),
                                      child: Text(
                                        "Quét mã QR code",
                                        style: TextStyle(
                                          color: ColorResources.BLACK,
                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    IZIImage(
                                      ImagesPath.qr_code,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Flexible(
                              fit: FlexFit.tight,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        bottom: IZIDimensions.SPACE_SIZE_2X,
                                      ),
                                      child: Text(
                                        "Chia sẻ",
                                        style: TextStyle(
                                          color: ColorResources.BLACK,
                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await Share.share(controller.linkShare);
                                          },
                                          child: IZIImage(
                                            ImagesPath.logo_faecbook,
                                            height: IZIDimensions.ONE_UNIT_SIZE * 40,
                                            width: IZIDimensions.ONE_UNIT_SIZE * 40,
                                          ),
                                        ),
                                        Container(
                                          width: IZIDimensions.ONE_UNIT_SIZE * 20,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await Share.share(controller.linkShare);
                                          },
                                          child: IZIImage(
                                            ImagesPath.logo_share,
                                            height: IZIDimensions.ONE_UNIT_SIZE * 40,
                                            width: IZIDimensions.ONE_UNIT_SIZE * 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //List danh bạ
                Container(
                  margin: EdgeInsets.only(
                    top: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  width: IZIDimensions.iziSize.width,
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                    horizontal: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_3X,
                    ),
                    color: ColorResources.BACKGROUND,
                    boxShadow: IZIOther().boxShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.BLUR_RADIUS_3X,
                        ),
                        child: Text(
                          "HỘI CHƯA TẢI ỨNG DỤNG",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                            color: ColorResources.BLACK,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.BLUR_RADIUS_3X,
                        ),
                        child: Text(
                          "“Rủ rê” hội này đăng ký sử dụng app Hà Nội Safe Food để cùng nhận quà nào !",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                            color: ColorResources.BLACK,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: IZIOther().boxShadow,
                          color: ColorResources.WHITE,
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_3X,
                          ),
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.itemCountContactList,
                          itemBuilder: (context, index) {
                            Contact contact = controller.contactList[index];
                            return IZICard(
                              marginCard: const EdgeInsets.all(0),
                              cardType: IZICardType.CARD_CONTACT,
                              title: contact.initials().substring(0, 1),
                              row1Left: contact.displayName,
                              row2Left: contact.phones!.elementAt(0).value,
                              colorBG: ColorResources.LIGHT_GREY.withOpacity(.7),
                              actions: [
                                GestureDetector(
                                  onTap: () async {
                                    await Share.share(controller.linkShare);
                                  },
                                  child: const Icon(
                                    Icons.chat_outlined,
                                    color: ColorResources.CIRCLE_COLOR_BG,
                                  ),
                                ),
                                Container(
                                  width: IZIDimensions.ONE_UNIT_SIZE * 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    controller.btnCall(url: "tel:${contact.phones!.elementAt(0).value}");
                                  },
                                  child: const Icon(
                                    Icons.phone_forwarded_rounded,
                                    color: ColorResources.CIRCLE_COLOR_BG,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      //Button Xem Thêm
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          IZIDimensions.SPACE_SIZE_4X,
                          0,
                          IZIDimensions.SPACE_SIZE_4X,
                        ),
                        child: Align(
                          child: GestureDetector(
                            onTap: () {
                              controller.itemCountContactList == controller.contactList.length && controller.isReadMore == true ? controller.rutGon() : controller.xemThem();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.itemCountContactList == controller.contactList.length && controller.isReadMore == true ? "Rút gọn" : "Xem tất cả",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.CIRCLE_COLOR_BG,
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * .8,
                                  ),
                                ),
                                SvgPicture.asset(
                                  controller.itemCountContactList == controller.contactList.length && controller.isReadMore == true ? ImagesPath.icon_keyboard_double_arrow_up_outlined : ImagesPath.icon_keyboard_double_arrow_down_outlined,
                                  color: ColorResources.CIRCLE_COLOR_BG,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  ///Link giới thiệu bạn bè
  ///
  Widget _linkShare(ReferFriendsController controller) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        IZIDimensions.SPACE_SIZE_4X,
        IZIDimensions.SPACE_SIZE_4X,
        IZIDimensions.SPACE_SIZE_4X,
        IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Link giới thiệu bạn bè",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H5,
              color: ColorResources.BLACK,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: IZIDimensions.SPACE_SIZE_2X,
            ),
            width: IZIDimensions.iziSize.width,
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              boxShadow: IZIOther().boxShadow,
              borderRadius: BorderRadius.circular(
                IZIDimensions.BORDER_RADIUS_3X,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BORDER_RADIUS_3X,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: IZIDimensions.SPACE_SIZE_2X,
                      horizontal: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Text(
                      controller.linkShare,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.BLACK,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      controller.copyLinkShare(
                        content: controller.linkShare,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.CIRCLE_COLOR_BG,
                        borderRadius: BorderRadius.circular(
                          IZIDimensions.BORDER_RADIUS_3X,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: IZIDimensions.SPACE_SIZE_2X,
                        horizontal: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      child: Text(
                        "Sao chép",
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          color: ColorResources.WHITE,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
