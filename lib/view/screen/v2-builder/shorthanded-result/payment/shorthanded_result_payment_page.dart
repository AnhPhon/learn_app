import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/helper/common_helper.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/custom_themes.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/btn_component_border.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/component/tab_bar_widget.dart';
import 'package:template/view/basewidget/getx_smart_refresh/getx_smart_refresh_page.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/screen/v2-builder/shorthanded-result/payment/shorthanded_result_payment_controller.dart';
import 'package:template/view/screen/v2-builder/shorthanded-result/shorthanded_result_controller.dart';

class V2ShorthandedPaymentPage extends GetView<V2ShorthandedPaymentController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedPaymentController>(
        init: V2ShorthandedPaymentController(),
        builder: (controller) {
          return controller.danhSachBaoGiaDonDichVu.idDonDichVu == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      controller.title.toString(),
                      style: const TextStyle(
                        shadows: [
                          Shadow(
                              // bottomLeft
                              offset: Offset(-1.5, -1.5),
                              color: ColorResources.BLACK),
                          Shadow(
                              // bottomRight
                              offset: Offset(1.5, -1.5),
                              color: ColorResources.BLACK),
                          Shadow(
                              // topRight
                              offset: Offset(1.5, 1.5),
                              color: ColorResources.BLACK),
                          Shadow(
                              // topLeft
                              offset: Offset(-1.5, 1.5),
                              color: ColorResources.BLACK),
                        ],
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //image
                        _imgProject(context, controller),

                        //title
                        _textTitle(),

                        //content
                        _content(),
                      ],
                    ),
                  ),
                );
        });
  }

  ///
  ///img product
  ///
  Widget _imgProject(
      BuildContext context, V2ShorthandedPaymentController controller) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return FadeInImage.assetNetwork(
            placeholder: Images.placeholder,
            image: controller.danhSachBaoGiaDonDichVu.idDonDichVu!.hinhAnhChiTiets != null &&
                    controller.danhSachBaoGiaDonDichVu.idDonDichVu!.hinhAnhChiTiets!.isNotEmpty
                ? controller.danhSachBaoGiaDonDichVu.idDonDichVu!.hinhAnhChiTiets![itemIndex]
                : '',
            width: double.infinity,
            height: DeviceUtils.getScaledHeight(context, .3),
            fit: BoxFit.fill,
            imageErrorBuilder: (c, o, s) => Image.asset(
              Images.placeholder,
              width: double.infinity,
              height: DeviceUtils.getScaledHeight(context, .3),
            ),
          );
        },
        options: CarouselOptions(
          height: DeviceUtils.getScaledHeight(context, .355),
          autoPlay: true,
          viewportFraction: 1,
        ),
      ),
    );
  }

  ///
  ///text title
  ///
  Widget _textTitle() {
    return Container(
      // color: Colors.red,
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      margin:
          const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
      child: Text(
        'Tên dự án: ' + controller.danhSachBaoGiaDonDichVu.idDonDichVu!.tieuDe.toString(),
        style: Dimensions.fontSizeStyle22w600(),
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Row(
            children: [
              const Icon(
                Icons.location_city,
              ),
              Text(
                controller.danhSachBaoGiaDonDichVu.idDonDichVu!.diaDiemLamViec.toString(),
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18w600(),
              ),
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              const Icon(
                Icons.location_on_outlined,
              ),
              Text(
                controller.danhSachBaoGiaDonDichVu.idDonDichVu!.idQuanHuyen != null
                    ? controller.danhSachBaoGiaDonDichVu.idDonDichVu!.idQuanHuyen!.ten.toString()
                    : '',
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18w600(),
              ),
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              const Icon(
                Icons.access_time,
              ),
              Text(
                controller.danhSachBaoGiaDonDichVu.idDonDichVu!.soNgay.toString(),
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18w600(),
              ),
              // Text(
              //   DateConverter.isoStringToddMMYYYY(controller.kiemTraIdTrangThaiDuAnDangXayDung() == true ?
              //   controller.duAnKhachHangResponse!.ngayKetThuc.toString() : controller.duAnKhachHangResponse!.ngayBatDau.toString()),
              //   textAlign: TextAlign.left,
              //   style: Dimensions.fontSizeStyle18(),
              // ),
            ],
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          fileWidget(controller.danhSachBaoGiaDonDichVu.idDonDichVu!.file.toString()),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Text(
            "Chốt giá trị báo giá cuối cùng (chi tiết theo đơn)",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          Container(
            width: MediaQuery.of(Get.context!).size.width,
            child: Text(
              // "${CurrencyConverter.currencyConverterVND(int.parse((controller.danhSachBaoGiaDonDichVu.tongTien != null && controller.danhSachBaoGiaDonDichVu.tongTien!.isNotEmpty && controller.danhSachBaoGiaDonDichVu.tongTien.toString() != 'null') ? controller.danhSachBaoGiaDonDichVu.tongTien.toString() : '0') * 1.0)} VNĐ",
              "${controller.danhSachBaoGiaDonDichVu.tongTien.toString()} VNĐ",
              // controller.danhSachBaoGiaDonDichVu!.tongTien.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorResources.RED,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Text(
            "Quy định",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          Container(
            width: MediaQuery.of(Get.context!).size.width,
            child: Text(
              "Thầu thợ cần đặt cọc 5% giá trị thi công nếu là công trình nhà ở tư nhân. Nếu thầu thợ bỏ thì mất cọc",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorResources.RED,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                // fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Text(
            "Đồng ý đặt cọc số tiền giữ để thi công đơn hàng ",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          Container(
            width: MediaQuery.of(Get.context!).size.width,
            child: Text(
              "${CurrencyConverter.currencyConverterVND(0.05 * int.parse((controller.danhSachBaoGiaDonDichVu.tongTien != null && controller.danhSachBaoGiaDonDichVu.tongTien!.isNotEmpty) ? controller.danhSachBaoGiaDonDichVu.tongTien.toString() : '0') * 1.0)} VNĐ",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorResources.RED,
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          // Container(
          //   padding: const EdgeInsets.fromLTRB(
          //     0,
          //     0,
          //     0,
          //     Dimensions.PADDING_SIZE_SMALL,
          //   ),
          //   decoration: const BoxDecoration(
          //     color: ColorResources.WHITE,
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
          //     ),
          //   ),
          //   width: DeviceUtils.getScaledWidth(Get.context!, 1),
          //   // child: Wrap(
          //   //   children: controller.kiemTraIdHangMucXayDungs()
          //   //       ? controller.duAnKhachHangResponse!.idHangMucXayDungs!.map((e) {
          //   //     return Container(
          //   //       decoration: const BoxDecoration(
          //   //         color: ColorResources.HOME_BG,
          //   //         borderRadius: BorderRadius.all(
          //   //           Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
          //   //         ),
          //   //       ),
          //   //       padding: const EdgeInsets.symmetric(
          //   //         horizontal: Dimensions.PADDING_SIZE_SMALL,
          //   //         vertical: Dimensions.PADDING_SIZE_SMALL,
          //   //       ),
          //   //       margin: const EdgeInsets.fromLTRB(
          //   //         Dimensions.PADDING_SIZE_SMALL,
          //   //         Dimensions.PADDING_SIZE_SMALL,
          //   //         Dimensions.PADDING_SIZE_SMALL,
          //   //         0,
          //   //       ),
          //   //       child: Text(
          //   //         e.tieuDe.toString(),
          //   //         textAlign: TextAlign.left,
          //   //         style: const TextStyle(
          //   //           fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          //   //         ),
          //   //       ),
          //   //     );
          //   //   }).toList()
          //   //       : [
          //   //     Container(
          //   //       margin: const EdgeInsets.fromLTRB(
          //   //         Dimensions.PADDING_SIZE_SMALL,
          //   //         Dimensions.PADDING_SIZE_SMALL,
          //   //         Dimensions.PADDING_SIZE_SMALL,
          //   //         0,
          //   //       ),
          //   //       child: const Center(
          //   //         child: Text(
          //   //           'Không có',
          //   //           textAlign: TextAlign.center,
          //   //           style: TextStyle(
          //   //             fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
          //   //           ),
          //   //         ),
          //   //       ),
          //   //     ),
          //   //   ],
          //   // ),
          // ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          const Text(
            "Nếu tài khoản của bạn có tiền lớn hơn tiền cọc thi được xem như trích cọc từ số dư tài khoản. Còn thiếu thì bạn phải nạp thêm vào tài khoản",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: ColorResources.RED,
              fontSize: Dimensions.FONT_SIZE_LARGE,
              // fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          //btn
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //cancel
              BtnCustom(
                onTap: () {
                  controller.khongDongY();
                },
                color: ColorResources.RED,
                text: "Không đồng ý và từ chối việc",
                width: DeviceUtils.getScaledWidth(Get.context!, 0.35),
              ),

              const SizedBox(
                width: Dimensions.MARGIN_SIZE_SMALL,
              ),

              //accept
              BtnCustom(
                onTap: () {
                  controller.dongY();
                },
                text: "Đồng ý và nhận việc",
                color: ColorResources.PRIMARY,
                width: DeviceUtils.getScaledWidth(Get.context!, 0.35),
              ),

            ],
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
        ],
      ),
    );
  }

  ///
  /// fileWidget
  ///
  Widget fileWidget(String filepath) {
    return LabelContent(
      title: "File báo giá",
      isRequired: false,
      content: GestureDetector(
        onTap: () {
          CommonHelper.openLink(
              url: controller.danhSachBaoGiaDonDichVu.file.toString());
        },
        child: Text(
          controller.danhSachBaoGiaDonDichVu.file.toString(),
          textAlign: TextAlign.left,
          style: const TextStyle(
            // color: ColorResources.RED,
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
