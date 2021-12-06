import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/helper/izi_string.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/screen/v2-builder/shorthanded-result/payment/shorthanded_result_payment_controller.dart';

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
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    controller.title.toString(),
                  ),
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //image
                      _imgProject(context, controller),

                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),

                      //title
                      _textTitle(),

                      //content
                      _content(),
                    ],
                  ),
                ),
              );
      },
    );
  }

  ///
  ///img product
  ///
  Widget _imgProject(BuildContext context, V2ShorthandedPaymentController controller) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return FadeInImage.assetNetwork(
            placeholder: Images.placeholder,
            image: Validate.nullOrEmpty(controller.danhSachBaoGiaDonDichVu.idDonDichVu!.idNhomDichVu) == false && Validate.nullOrEmpty(controller.danhSachBaoGiaDonDichVu.idDonDichVu!.idNhomDichVu!.hinhAnhDaiDien) == false ? controller.danhSachBaoGiaDonDichVu.idDonDichVu!.idNhomDichVu!.hinhAnhDaiDien.toString() : '',
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
      width: MediaQuery.of(Get.context!).size.width,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Text(
        controller.danhSachBaoGiaDonDichVu.idDonDichVu!.tieuDe.toString(),
        style: Dimensions.fontSizeStyle20w600(),
        textAlign: TextAlign.center,
      ),
    );
  }

  ///
  ///content
  ///
  Widget _content() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
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
                size: Dimensions.FONT_SIZE_EXTRA_LARGE,
              ),

              Text(
                (Validate.nullOrEmpty(controller.danhSachBaoGiaDonDichVu.idDonDichVu) == false && Validate.nullOrEmpty(controller.danhSachBaoGiaDonDichVu.idDonDichVu!.idTinhTp) == false) ? ' ${controller.danhSachBaoGiaDonDichVu.idDonDichVu!.idTinhTp!.ten}' : 'Không có',
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18w600(),
              ),
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),

              const Icon(
                Icons.location_on,
                size: Dimensions.FONT_SIZE_EXTRA_LARGE,
              ),

              Text(
                (Validate.nullOrEmpty(controller.danhSachBaoGiaDonDichVu.idDonDichVu) == false && Validate.nullOrEmpty(controller.danhSachBaoGiaDonDichVu.idDonDichVu!.idQuanHuyen) == false) ? ' ${controller.danhSachBaoGiaDonDichVu.idDonDichVu!.idQuanHuyen}' : 'Không có',
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18w600(),
              ),
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              const Icon(
                Icons.access_time,
                size: Dimensions.FONT_SIZE_EXTRA_LARGE,
              ),
              Text(
                controller.getTimeLamViec(),
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18w600(),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          if (Validate.nullOrEmpty(controller.danhSachBaoGiaDonDichVu.file) == false) fileWidget(),
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
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width,
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                      vertical: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
                      color: Color(0xa0ffffff),
                    ),
                    child: Text(
                      CurrencyConverter.currencyConverterVND(int.parse((controller.danhSachBaoGiaDonDichVu.tongTien != null && controller.danhSachBaoGiaDonDichVu.tongTien!.isNotEmpty && controller.danhSachBaoGiaDonDichVu.tongTien.toString() != 'null') ? controller.danhSachBaoGiaDonDichVu.tongTien.toString() : '0') * 1.0),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ColorResources.RED,
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    "VNĐ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // color: ColorResources.RED,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
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
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width,
            child: const Text(
              "Thầu thợ cần đặt cọc 5% giá trị thi công nếu là công trình nhà ở tư nhân. Nếu thầu thợ bỏ thì mất cọc",
              textAlign: TextAlign.center,
              style: TextStyle(
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
          SizedBox(
            width: MediaQuery.of(Get.context!).size.width,
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                      vertical: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
                      color: Color(0xa0ffffff),
                    ),
                    child: Text(
                      CurrencyConverter.currencyConverterVND(0.05 * int.parse((controller.danhSachBaoGiaDonDichVu.tongTien != null && controller.danhSachBaoGiaDonDichVu.tongTien!.isNotEmpty) ? controller.danhSachBaoGiaDonDichVu.tongTien.toString() : '0') * 1.0),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ColorResources.RED,
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    "VNĐ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          const Text(
            "Nếu tài khoản của bạn có tiền lớn hơn tiền cọc thì được xem như trích cọc từ số dư tài khoản. Còn thiếu thì bạn phải nạp thêm vào tài khoản",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: ColorResources.GREY,
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          //btn
          if (controller.showButton == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //btn cancel
                BtnCustom(
                  onTap: () {
                    controller.onCancleClick();
                  },
                  color: ColorResources.RED,
                  text: "Không đồng ý và từ chối việc",
                  width: DeviceUtils.getScaledWidth(Get.context!, 0.35),
                  height: 0.085,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_SMALL,
                  ),
                ),

                const SizedBox(
                  width: Dimensions.MARGIN_SIZE_SMALL,
                ),

                //btn accept
                BtnCustom(
                  onTap: () {
                    controller.dongY();
                  },
                  text: "Đồng ý và nhận việc",
                  color: ColorResources.PRIMARY,
                  width: DeviceUtils.getScaledWidth(Get.context!, 0.35),
                  height: 0.085,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    vertical: Dimensions.PADDING_SIZE_SMALL,
                  ),
                ),
              ],
            )
          else
            const SizedBox(),
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
  Widget fileWidget() {
    return LabelContent(
      title: "File báo giá",
      isRequired: false,
      content: GestureDetector(
        onTap: () {
          CommonHelper.openLink(url: controller.danhSachBaoGiaDonDichVu.file.toString());
        },
        child: Text(
          StringCut.getFileNameBaoGia(controller.danhSachBaoGiaDonDichVu.file.toString()),
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
