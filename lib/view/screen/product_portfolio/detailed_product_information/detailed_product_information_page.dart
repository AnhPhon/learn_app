import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_home.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_card.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/product_portfolio/detailed_product_information/detailed_product_information_controller.dart';

class DetailedProductInformationPage extends GetView<DetailedProductInformationController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundHome(),
      appBar: IZIAppBar(
        colorBG: ColorResources.WHITE,
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
        title: "Chi tiết sản phẩm",
      ),
      body: GetBuilder(
        init: DetailedProductInformationController(),
        builder: (DetailedProductInformationController controller) {
          return Container(
            constraints: BoxConstraints(
              minWidth: IZIDimensions.iziSize.width,
              minHeight: IZIDimensions.iziSize.height,
            ),
            color: ColorResources.BACKGROUND,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: ColorResources.WHITE,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.red,
                        width: IZIDimensions.iziSize.width,
                        height: IZIDimensions.iziSize.height * .2,
                        child: IZIImage(
                          "https://image.thanhnien.vn/w1024/Uploaded/2021/wsxrxqeiod/2019_09_18/sam-ngoc-linh1_eixt.jpg",
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                          vertical: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Các Loại Rượu Sâm Thượng Hạng",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: ColorResources.BLACK,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "đ 100.000 ",
                                            style: TextStyle(
                                              color: ColorResources.GREY,
                                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                              decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "đ50.000",
                                            style: TextStyle(
                                              color: ColorResources.RED,
                                              fontSize: IZIDimensions.FONT_SIZE_H6,
                                            ),
                                          ),
                                        ],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Đã bán 800",
                                      style: TextStyle(
                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                        color: ColorResources.BLACK,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Voucher của Shop
                Container(
                  color: ColorResources.WHITE,
                  margin: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_4X,
                    vertical: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Voucher của shop",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                            fontWeight: FontWeight.w400,
                            color: ColorResources.BLACK,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        width: IZIDimensions.iziSize.width * .33,
                        height: IZIDimensions.iziSize.height * .07,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              ImagesPath.voucher,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Giảm giá 100k",
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              color: ColorResources.WHITE,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Thông tin sản phẩm
                Container(
                  width: IZIDimensions.iziSize.width,
                  color: ColorResources.WHITE,
                  margin: EdgeInsets.only(
                    bottom: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  padding: EdgeInsets.all(
                    IZIDimensions.SPACE_SIZE_4X,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Thông tin sản phẩm",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H5,
                          color: ColorResources.BLACK,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Sản xuất",
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      color: ColorResources.BLACK,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Việt nam",
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
                              ],
                            ),
                            Divider(
                              thickness: IZIDimensions.ONE_UNIT_SIZE * .5,
                              color: ColorResources.BLACK.withOpacity(.3),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Kích cỡ sản phẩm",
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      color: ColorResources.BLACK,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Nhỏ",
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
                              ],
                            ),
                            Divider(
                              thickness: IZIDimensions.ONE_UNIT_SIZE * .5,
                              color: ColorResources.BLACK.withOpacity(.3),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Vật liệu",
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      color: ColorResources.BLACK,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Không rõ",
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
                              ],
                            ),
                            Divider(
                              thickness: IZIDimensions.ONE_UNIT_SIZE * .5,
                              color: ColorResources.BLACK.withOpacity(.3),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: IZIDimensions.iziSize.width,
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing augue nisl, gravida a, sapien leo. Morbi vulputate fermentum porta nunc. Viverra laoreet convallis massa elementum vel. Eget tincidunt massa sodales non massa euismod. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Adipiscing augue nisl, gravida a, sapien leo. Morbi vulputate fermentum porta nunc. Viverra laoreet convallis massa elementum vel. Eget tincidunt massa sodales non massa euismod.",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  color: ColorResources.BLACK,
                                ),
                                maxLines: controller.isReadMore == false ? 4 : null,
                                overflow: controller.isReadMore == true ? null : TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              width: IZIDimensions.iziSize.width,
                              height: IZIDimensions.iziSize.height * .25,
                              child: Stack(
                                children: [
                                  Container(
                                    width: IZIDimensions.iziSize.width,
                                    height: IZIDimensions.iziSize.height * .25,
                                    child: IZIImage(
                                      "https://suckhoedoisong.qltns.mediacdn.vn/Images/hahien/2016/12/29/hinh_anh_sam_ngoc_linh_viet_nam.jpg",
                                    ),
                                  ),
                                  Container(
                                    width: IZIDimensions.iziSize.width,
                                    height: IZIDimensions.iziSize.height * .25,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          ColorResources.WHITE.withOpacity(0),
                                          ColorResources.WHITE,
                                        ],
                                        stops: const [0.2, 1],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.isReadMore == true ? controller.rutGon() : controller.xemThem();
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.isReadMore == true ? "Rút gọn" : "Xem tất cả",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: ColorResources.CIRCLE_COLOR_BG,
                                              fontSize: IZIDimensions.FONT_SIZE_H6 * .8,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            controller.isReadMore == true ? ImagesPath.icon_keyboard_double_arrow_up_outlined : ImagesPath.icon_keyboard_double_arrow_down_outlined,
                                            color: ColorResources.CIRCLE_COLOR_BG,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Sản phẩm tương tự
                Container(
                  width: IZIDimensions.iziSize.width,
                  color: ColorResources.WHITE,
                  padding: EdgeInsets.symmetric(
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        child: Text(
                          "Sản phẩm tương tự",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: ColorResources.BLACK,
                            fontSize: IZIDimensions.FONT_SIZE_H5,
                          ),
                        ),
                      ),
                      IZIListView(
                        mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 425,
                        mainAxisSpacing: IZIDimensions.SPACE_SIZE_1X,
                        crossAxisSpacing: IZIDimensions.SPACE_SIZE_1X,
                        type: IZIListViewType.GRIDVIEW,
                        itemCount: 4,
                        builder: (index) {
                          return IZICard(
                            marginCard: EdgeInsets.all(
                              IZIDimensions.SPACE_SIZE_2X,
                            ),
                            urlImage: "https://samviet.vn/uploads/posts/2018/08/Dac-diem-nhan-biet-sam-ngoc-linh-ve-hinh-thai-cay.png",
                            row1Left: "Sâm Dây Ngọc Linh Tươi/Khô",
                            row2Left: "đ 100.000",
                            row3Left: "đ 50.000",
                            row3Right: "Đã bán 800",
                          );
                        },
                      ),
                      Container(
                        width: IZIDimensions.iziSize.width,
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                              fit: FlexFit.tight,
                              child: SizedBox(),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const CircleAvatar(
                                radius: 27,
                                backgroundColor: ColorResources.RED,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: ColorResources.WHITE,
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: ColorResources.RED,
                                  ),
                                ),
                              ),
                            ),
                            const Flexible(
                              fit: FlexFit.tight,
                              child: SizedBox(),
                            ),
                            IZIButton(
                              width: IZIDimensions.iziSize.width * .7,
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: ColorResources.WHITE,
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      width: IZIDimensions.iziSize.width,
                                      height: IZIDimensions.iziSize.height * .33,
                                      padding: EdgeInsets.all(
                                        IZIDimensions.SPACE_SIZE_4X,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                  IZIDimensions.BORDER_RADIUS_3X,
                                                ),
                                                child: IZIImage(
                                                  "https://nhansamlinhchi.net.vn/wp-content/uploads/2015/11/thumb-15.jpg",
                                                  height: IZIDimensions.ONE_UNIT_SIZE * 190,
                                                  width: IZIDimensions.ONE_UNIT_SIZE * 190,
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    left: IZIDimensions.SPACE_SIZE_2X,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                          bottom: IZIDimensions.SPACE_SIZE_2X,
                                                        ),
                                                        child: Text(
                                                          "Các Loại Rượu Sâm Thượng Hạng",
                                                          style: TextStyle(
                                                            color: ColorResources.BLACK,
                                                            fontSize: IZIDimensions.FONT_SIZE_H6,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.start,
                                                        ),
                                                      ),
                                                      Text(
                                                        "đ 50.000",
                                                        style: TextStyle(
                                                          color: ColorResources.RED,
                                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.start,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: IZIDimensions.ONE_UNIT_SIZE,
                                            color: ColorResources.BLACK.withOpacity(.8),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Số lượng",
                                                style: TextStyle(
                                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                                  color: ColorResources.BLACK,
                                                ),
                                              ),
                                              IZIInput(
                                                width: IZIDimensions.iziSize.width * .4,
                                                type: IZIInputType.INCREMENT,
                                                disbleError: true,
                                                isBorder: true,
                                                height: IZIDimensions.ONE_UNIT_SIZE * 50,
                                                widthIncrement: IZIDimensions.ONE_UNIT_SIZE * 50,
                                                contentPaddingIncrement: EdgeInsets.all(
                                                  IZIDimensions.ONE_UNIT_SIZE * 17,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              label: "Thêm vào giỏ hàng",
                              colorBG: ColorResources.RED,
                            ),
                            const Flexible(
                              fit: FlexFit.tight,
                              child: SizedBox(),
                            ),
                          ],
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
}

enum Sides {
  BOTTOM,
  VERTICAL,
}

class Voucher extends CustomClipper<Path> {
  final double heightOfPoint;
  final int numberOfPoints;
  final Sides side;

  Voucher(this.side, {this.heightOfPoint = 12, this.numberOfPoints = 16}); // final Sides side;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    double x = 0;
    double y = size.height;
    double yControlPoint = size.height - heightOfPoint;
    double increment = size.width / numberOfPoints;

    if (side == Sides.BOTTOM || side == Sides.VERTICAL)
      while (x < size.width) {
        path.quadraticBezierTo(x + increment / 2, yControlPoint, x + increment, y);
        x += increment;
      }

    path.lineTo(size.width, 0.0);

    if (side == Sides.VERTICAL)
      while (x > 0) {
        path.quadraticBezierTo(x - increment / 2, heightOfPoint, x - increment, 0);
        x -= increment;
      }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) => old != this;
}
