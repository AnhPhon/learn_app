import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/my_order/detail_my_order/detail_my_order_controller.dart';

class DetailMyOrderPage extends GetView<DetailMyOrderController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
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
        title: "Đơn hàng của tôi",
      ),
      body: GetBuilder(
        init: DetailMyOrderController(),
        builder: (DetailMyOrderController controller) {
          return Container(
            constraints: BoxConstraints(
              minWidth: IZIDimensions.iziSize.width,
              minHeight: IZIDimensions.iziSize.height,
            ),
            color: ColorResources.BACKGROUND,
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_3X,
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thông tin chung",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H5,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                  ),
                ),

                //Thông tin chung
                _generalInformation(),

                //Lịch sử
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Lịch sử",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H5,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.BLACK,
                      ),
                    ),
                    Text(
                      "Chi tiết >",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        fontWeight: FontWeight.w600,
                        color: ColorResources.LABEL_ORDER_DANG_GIAO,
                      ),
                    ),
                  ],
                ),

                //Lịch sử
                _orderHistory(),

                //Label thông tin sản phẩm
                Text(
                  "Thông tin sản phẩm",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H5,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                  ),
                ),

                //Thông tin sản phẩm
                Container(
                  margin: EdgeInsets.fromLTRB(
                    0,
                    IZIDimensions.SPACE_SIZE_2X,
                    0,
                    IZIDimensions.SPACE_SIZE_3X,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                    horizontal: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    boxShadow: IZIOther().boxShadow,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_3X,
                    ),
                  ),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return _productCard();
                    },
                  ),
                ),

                //Label chi tiết thanh toán
                Text(
                  "Chi tiết thanh toán",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H5,
                    fontWeight: FontWeight.w600,
                    color: ColorResources.BLACK,
                  ),
                ),

                //Chi tiết thanh Toán
                _paymentDetails(),
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  ///Chi tiết thanh toán
  ///
  Widget _paymentDetails() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        0,
        IZIDimensions.SPACE_SIZE_2X,
        0,
        IZIDimensions.SPACE_SIZE_3X,
      ),
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_2X,
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        boxShadow: IZIOther().boxShadow,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_3X,
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      "Giá tiền",
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
                  flex: 3,
                  child: Container(
                    child: Text(
                      "150.000 ₫",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.BLACK,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Text(
                      "Phí ship",
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
                  flex: 3,
                  child: Container(
                    child: Text(
                      "Miễn phí",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.BLACK,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    "Tổng",
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
                flex: 3,
                child: Container(
                  child: Text(
                    "115.000 ₫",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      color: ColorResources.BLACK,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///Product card
  ///
  Widget _productCard() {
    return Container(
      width: IZIDimensions.iziSize.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIImage(
                    ImagesPath.logoMomo,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sản phẩm 1",
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                      Container(
                        height: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      Text(
                        "100.000 ₫ x 1",
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          color: ColorResources.BLACK.withOpacity(.7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Divider(
              color: ColorResources.BLACK.withOpacity(.8),
              thickness: IZIDimensions.ONE_UNIT_SIZE * .3,
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///Lịch sử
  ///
  Widget _orderHistory() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        0,
        IZIDimensions.SPACE_SIZE_2X,
        0,
        IZIDimensions.SPACE_SIZE_3X,
      ),
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_2X,
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        boxShadow: IZIOther().boxShadow,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_3X,
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_1X,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    Icons.location_on_outlined,
                    size: IZIDimensions.ONE_UNIT_SIZE * 45,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: Text(
                      "Địa chỉ nhận hàng",
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
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: Text(
                      "183 Quách Thị Trang",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.BLACK,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  child: Text(
                    "Liên hệ • 0969696969",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      color: ColorResources.BLACK.withOpacity(.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Divider(
              color: ColorResources.BLACK.withOpacity(.8),
              thickness: IZIDimensions.ONE_UNIT_SIZE * .3,
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(
                      IZIDimensions.SPACE_SIZE_1X,
                    ),
                    child: IZIImage(
                      ImagesPath.logo_tiki,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: Text(
                      "Dịch vụ vận chuyển",
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
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: Text(
                      "Tên dịch vụ",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.BLACK,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  child: Text(
                    "Trong ngày 2h - 3h",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      color: ColorResources.BLACK.withOpacity(.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///Thông tin chung
  ///
  Widget _generalInformation() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        0,
        IZIDimensions.SPACE_SIZE_2X,
        0,
        IZIDimensions.SPACE_SIZE_3X,
      ),
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_2X,
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        boxShadow: IZIOther().boxShadow,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_3X,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    "Ngày order",
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
                flex: 3,
                child: Container(
                  child: Text(
                    " 22/07/2021",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      color: ColorResources.BLACK,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Divider(
              color: ColorResources.BLACK.withOpacity(.8),
              thickness: IZIDimensions.ONE_UNIT_SIZE * .3,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Text(
                    "Trạng thái",
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
                flex: 3,
                child: Container(
                  child: Text(
                    "Đã giao hàng",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      color: ColorResources.BLACK,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
