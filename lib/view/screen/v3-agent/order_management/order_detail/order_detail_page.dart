import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v3-agent/order_management/order_detail/order_detail_controller.dart';

class V3OrderDetailPage extends GetView<V3OrderDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3OrderDetailController>(
        init: V3OrderDetailController(),
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //thong tin chung
                  const Label(
                    label: "Thông tin chung",
                    obligatory: false,
                  ),
                  _thongTinChung(context, controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  //shipping
                  const Label(
                    label: "Thông tin shipping",
                    obligatory: false,
                  ),
                  _shipping(context, controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  //product info
                  const Label(
                    label: "Thông tin sản phẩm",
                    obligatory: false,
                  ),
                  _productInfo(context, controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  //payment detail
                  const Label(
                    label: "Chi tiết thanh toán",
                    obligatory: false,
                  ),
                  _paymentDetail(context, controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///row text info
  ///
  Row rowText({required String text1, required String text2, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: Dimensions.fontSizeStyle16(),
        ),
        Text(
          text2,
          style: Dimensions.fontSizeStyle16w600()
              .copyWith(color: color ?? ColorResources.BLACK),
        ),
      ],
    );
  }

  ///
  ///thong tin chung
  ///
  Widget _thongTinChung(
      BuildContext context, V3OrderDetailController controller) {
    return BoxShadowWidget(
      padding: const EdgeInsets.all(
        Dimensions.PADDING_SIZE_DEFAULT,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      boxShadowCustom: boxShadowALitle,
      child: Column(
        children: [
          rowText(
            text1: "ID",
            text2: controller.donHangResponse.id.toString(),
          ),
          Dimensions().paddingDivider(context),
          rowText(
            text1: "Ngày đặt hàng",
            text2: DateConverter.formatDateTime(
              controller.donHangResponse.createdAt.toString(),
            ),
          ),
          Dimensions().paddingDivider(context),
          rowText(
            text1: "Trạng thái",
            text2: controller.donHangResponse.idTrangThaiDonHang!.tieuDe
                .toString(),
          ),
        ],
      ),
    );
  }

  ///
  ///shipping widget
  ///
  Row _shippingWidget(BuildContext context,
      {Image? image,
      Icon? icon,
      required String text1,
      required String text2,
      String? text3}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //iamge
        if (image != null)
          Container(
              height: DeviceUtils.getScaledSize(context, 0.063),
              width: DeviceUtils.getScaledSize(context, 0.063),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: image)
        else
          icon!,

        const SizedBox(
          width: Dimensions.MARGIN_SIZE_SMALL,
        ),

        //content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //text 1
              Text(
                text1,
                style: Dimensions.fontSizeStyle16(),
              ),

              //text2
              Text(
                text2,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Dimensions.fontSizeStyle16w600(),
              ),

              //text3
              if (text3 == null)
                const SizedBox.shrink()
              else
                Text(
                  text3,
                  style:
                      Dimensions.fontSizeStyle16().copyWith(color: Colors.grey),
                ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///shipping
  ///
  Widget _shipping(BuildContext context, V3OrderDetailController controller) {
    return BoxShadowWidget(
      padding: const EdgeInsets.all(
        Dimensions.PADDING_SIZE_DEFAULT,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      boxShadowCustom: boxShadowALitle,
      child: Column(
        children: [
          _shippingWidget(
            context,
            icon: const Icon(
              Icons.location_on_outlined,
              color: ColorResources.PRIMARY,
            ),
            text1: "Địa chỉ ship",
            text2:
                "${controller.donHangResponse.diaChi}, ${controller.donHangResponse.idPhuongXa}, ${controller.donHangResponse.idQuanHuyen}, ${controller.donHangResponse.idTinhTp}",
          ),
          Dimensions().paddingDivider(context),
          _shippingWidget(
            context,
            image: Image.asset("assets/images/logo.png"),
            text1: "Dịch vụ shipping",
            text2: "Tên dịch vụ",
            text3: "Trong ngày 2h - 3h",
          ),
        ],
      ),
    );
  }

  ///
  ///product info
  ///
  Widget _productInfo(
      BuildContext context, V3OrderDetailController controller) {
    return BoxShadowWidget(
        padding: const EdgeInsets.all(
          Dimensions.PADDING_SIZE_DEFAULT,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
        boxShadowCustom: boxShadowALitle,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.chiTietDonHangList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //image
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_DEFAULT,
                          ),
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder,
                            image: controller.chiTietDonHangList[index]
                                .idSanPham!.hinhAnhDaiDien
                                .toString(),
                            height: DeviceUtils.getScaledSize(context, .18),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageErrorBuilder: (c, o, s) => Image.asset(
                              Images.placeholder,
                              height: DeviceUtils.getScaledSize(context, .18),
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      //infomation product
                      Expanded(
                        flex: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //name
                            Text(
                              controller
                                  .chiTietDonHangList[index].idSanPham!.ten
                                  .toString(),
                              maxLines: 2,
                              style: titilliumSemiBold.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                              ),
                            ),

                            //quality & price
                            Row(
                              children: [
                                //price
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    "${PriceConverter.convertPrice(context, double.parse(controller.chiTietDonHangList[index].idSanPham!.gia.toString()))} vnđ",
                                    style: titilliumSemiBold.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),

                                //quality
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "x${controller.chiTietDonHangList[index].soLuong}",
                                    style: titilliumSemiBold.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  //divider
                  if (index == controller.chiTietDonHangList.length - 1)
                    const SizedBox.shrink()
                  else
                    Dimensions().paddingDivider(context),
                ],
              );
            }));
  }

  ///
  ///payment detail
  ///
  Widget _paymentDetail(
      BuildContext context, V3OrderDetailController controller) {
    return BoxShadowWidget(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_LARGE,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
      ),
      boxShadowCustom: boxShadowALitle,
      child: Column(
        children: [
          //Giá tiền
          rowText(
            text1: "Giá tiền",
            text2:
                "${PriceConverter.convertPrice(context, double.parse(controller.donHangResponse.soTien.toString()))} vnđ",
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),

          //Phí ship
          rowText(
            text1: "Phí ship",
            text2:
                "${PriceConverter.convertPrice(context, double.parse(controller.donHangResponse.phiVanChuyen.toString()))} vnđ",
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),

          //Phí dịch vụ
          rowText(
            text1: "Phí dịch vụ",
            text2:
                "${PriceConverter.convertPrice(context, double.parse(controller.donHangResponse.phiDichVu.toString()))} vnđ",
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),

          //Tổng tiền
          rowText(
            text1: "Tổng tiền",
            text2:
                "${PriceConverter.convertPrice(context, double.parse(controller.donHangResponse.tongTien.toString()))} vnđ",
          ),
        ],
      ),
    );
  }
}
