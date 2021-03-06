import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_account.dart';
import 'package:template/base_widget/izi_file.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/account/account_controller.dart';

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAccount(),
      body: Stack(
        // alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: IZIDimensions.iziSize.height * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      IZIDimensions.BLUR_RADIUS_5X,
                    ),
                    topRight: Radius.circular(
                      IZIDimensions.BLUR_RADIUS_5X,
                    ),
                  ),
                ),
                child: menu(controller),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: IZIDimensions.ONE_UNIT_SIZE * 270, //IZISize.device == IZIDevice.TABLE ?  IZIDimensions.iziSize.height * 0.3 : IZIDimensions.iziSize.height * 0.22,
            child: avatar(),
          ),
        ],
      ),
    );
  }

  Widget avatar() {
    return Container( 
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: IZISize.device == IZIDevice.TABLE ? IZIDimensions.ONE_UNIT_SIZE * 140 : IZIDimensions.ONE_UNIT_SIZE * 80,
            child: IZIImage(
              ImagesPath.nature,
            ),
          ),
          IZIFile.avatar()
        ],
      ),
    );
  }

  Widget menu(AccountController controller) {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.iziSize.height * 0.1,
      ),
      child: Column(
        children: [
          userInfo(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  itemMenu(
                    icon: Icons.account_circle,
                    label: "Th??ng tin c?? nh??n ",
                    onTap: () {
                      controller.onToAccountInformation();
                    },
                  ),
                  itemMenu(
                    icon: Icons.account_balance_wallet_rounded,
                    label: "V?? c???a t??i",
                    onTap: () {
                      controller.goToAccountManagements();
                    },
                  ),
                  itemMenu(
                    icon: Icons.savings_rounded,
                    label: "G??p v???n",
                    onTap: () {
                      controller.onToCapitalContribution();
                    },
                  ),
                  itemMenu(
                    icon: Icons.paid_rounded,
                    label: "Danh s??ch h???p ?????ng",
                    onTap: () {
                      controller.goToContractList();
                    },
                  ),
                  itemMenu(
                    icon: Icons.money_sharp,
                    label: "R??t v???n",
                    onTap: () {
                      controller.onToCapitalWithdDrawal();
                    },
                  ),
                  itemMenu(
                    icon: CupertinoIcons.person_2_fill,
                    label: "Gi???i thi???u b???n b??",
                    onTap: () {
                      controller.goToRefeFriend();
                    },
                  ),
                  itemMenu(
                    icon: Icons.shopping_cart_rounded,
                    label: "????n h??ng c???a t??i",
                    onTap: () {
                      controller.goToMyOrder();
                    },
                  ),
                  itemMenu(
                    icon: Icons.new_releases,
                    label: "Voucher",
                    onTap: () {
                      controller.goToVoucher();
                    },
                  ),
                  itemMenu(
                    icon: Icons.logout,
                    label: "????ng xu???t",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userInfo() {
    return Container(
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_5X,
      ),
      child: Column(
        children: [
          IZIText(
            text: "????? Thanh Nh??n",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H4,
              fontWeight: FontWeight.w500,
            ),
          ),
          IZIText(
            text: "01029999999",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemMenu({required String label, required IconData icon, required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_4X,
        ),
        margin: EdgeInsets.only(
          bottom: IZIDimensions.SPACE_SIZE_4X,
          right: IZIDimensions.SPACE_SIZE_4X,
          left: IZIDimensions.SPACE_SIZE_4X,
        ),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(
            IZIDimensions.BLUR_RADIUS_3X,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: IZIDimensions.ONE_UNIT_SIZE * 40,
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_3X,
            ),
            IZIText(
              text: label,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: IZIDimensions.FONT_SIZE_H5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
