import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/background/background_detail_voucher.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/voucher/voucher_details/voucher_details_controller.dart';

class DetailVoucherPage extends GetView<DetailVoucherController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundDetailVoucher(),
      appBar: IZIAppBar(
        colorTitle: ColorResources.BLACK,
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.BLACK,
          ),
        ),
        title: "Chi tiết Voucher",
      ),
      body: GetBuilder(
          init: DetailVoucherController(),
          builder: (DetailVoucherController controller) {
            return Container(
              constraints: BoxConstraints(
                minWidth: IZIDimensions.iziSize.width,
                minHeight: IZIDimensions.iziSize.height,
              ),
              width: IZIDimensions.iziSize.width,
              color: ColorResources.BACKGROUND,
              child: Column(
                children: [
                  Container(
                    width: IZIDimensions.iziSize.width,
                    height: IZIDimensions.iziSize.height * .25,
                    color: Colors.transparent,
                    child: _voucher(),
                  ),
                  _detailVoucher(),
                ],
              ),
            );
          }),
      widgetBottomSheet: Container(
        color: ColorResources.BACKGROUND,
        padding: EdgeInsets.symmetric(
          vertical: IZIDimensions.SPACE_SIZE_2X,
          horizontal: IZIDimensions.SPACE_SIZE_2X,
        ),
        child: IZIButton(
          colorBG: ColorResources.RED,
          label: 'Dùng ngay',
          onTap: () {},
        ),
      ),
    );
  }

  ///
  ///Voucher
  ///
  Widget _voucher() {
    return Stack(
      children: [
        Container(
          color: ColorResources.CIRCLE_COLOR_BG,
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height * .15,
        ),
        Positioned(
          top: IZIDimensions.ONE_UNIT_SIZE * 70,
          left: 0,
          right: 0,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: IZICard(
                    cardType: IZICardType.CARD_VOUCHER,
                    row1Left: "Giảm 30% - OFF30",
                    row2Left: "Điều kiện:\nĐơn tối thiểu 5.000.000đ ",
                    row3Left: "Hạn sử dụng: 25/12/2021",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///
  ///Chi tiết Voucher
  ///
  Widget _detailVoucher() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_4X,
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Text(
              "Ưu đãi",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H5,
                fontWeight: FontWeight.w600,
                color: ColorResources.BLACK,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
            child: Text(
              "Lượt sử dụng có hạn. Nhanh tay kẻo lỡ bạn nhé!Giảm 30% Đơn tối thiểu 5.000.000 đ",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.BLACK,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Text(
              "Có hiệu lực",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H5,
                fontWeight: FontWeight.w600,
                color: ColorResources.BLACK,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
            child: Text(
              "20/12/2021 - 25/12/2021",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.BLACK,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Text(
              "Thiết bị",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H5,
                fontWeight: FontWeight.w600,
                color: ColorResources.BLACK,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
            child: Text(
              "Android, IOS",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.BLACK,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Text(
              "Phương thức thanh toán",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H5,
                fontWeight: FontWeight.w600,
                color: ColorResources.BLACK,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
            child: Text(
              "Mọi phương thức thanh toán",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.BLACK,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Text(
              "Điều kiện",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H5,
                fontWeight: FontWeight.w600,
                color: ColorResources.BLACK,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X * 4,
            ),
            child: Text(
              "Sử dụng mã giảm giá .... Lượt sử dụng có hạn. Nhanh tay kẻo lỡ bạn nhé!Giảm 30% Đơn tối thiểu 5.000.000 đ Sử dụng mã giảm giá .... Lượt sử dụng có hạn. Nhanh tay kẻo lỡ bạn nhé!Giảm 30% Đơn tối thiểu 5.000.000 đ Sử dụng mã giảm giá .... Lượt sử dụng có hạn. Nhanh tay kẻo lỡ bạn nhé!Giảm 30% Đơn tối thiểu 5.000.000 đ Sử dụng mã giảm giá .... Lượt sử dụng có hạn. Nhanh tay kẻo lỡ bạn nhé!Giảm 30% Đơn tối thiểu 5.000.000 đ Sử dụng mã giảm giá .... Lượt sử dụng có hạn. Nhanh tay kẻo lỡ bạn nhé!Giảm 30% Đơn tối thiểu 5.000.000 đ ok",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.BLACK,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
