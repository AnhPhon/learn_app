import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/screen/v2-builder/project/project_detail_trien_khai/project_detail_trien_khai_controller.dart';

class V2ProjectDetailTrienKhaiPage extends GetView<V2ProjectDetailTrienKhaiController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ProjectDetailTrienKhaiController>(
      init: V2ProjectDetailTrienKhaiController(),
      builder: (controller) {
        return controller.duAnKhachHangResponse == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    controller.title.toString(),
                  ),
                  // backgroundColor: Colors.transparent,
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
      },
    );
  }

  ///
  ///img product
  ///
  Widget _imgProject(BuildContext context, V2ProjectDetailTrienKhaiController controller) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return FadeInImage.assetNetwork(
            placeholder: Images.placeholder,
            image: controller.duAnKhachHangResponse!.hinhAnhDaiDien.toString(),
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
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      margin: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
      child: Text(
        controller.duAnKhachHangResponse!.ten.toString(),
        style: Dimensions.fontSizeStyle22w600(),
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
          if (Validate.nullOrEmpty(controller.getDDiaDiemCuTheFull()) == false)
            Text(
              "Địa điểm:",
              textAlign: TextAlign.left,
              style: Dimensions.fontSizeStyle18w600(),
            ),
          if (Validate.nullOrEmpty(controller.getDDiaDiemCuTheFull()) == false)
            Text(
              controller.getDDiaDiemCuTheFull(),
              textAlign: TextAlign.left,
              style: Dimensions.fontSizeStyle16(),
            ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          if (Validate.nullOrEmpty(controller.duAnKhachHangResponse!.ngayBatDau) == false)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.kiemTraIdTrangThaiDuAnDangXayDung() == true ? "Dự kiến kết thúc: " : "Thời gian dự kiến triển khai: ",
                  textAlign: TextAlign.left,
                  style: Dimensions.fontSizeStyle18w600(),
                ),
                Text(
                  DateConverter.isoStringToddMMYYYY(controller.kiemTraIdTrangThaiDuAnDangXayDung() == true ? controller.duAnKhachHangResponse!.ngayKetThuc.toString() : controller.duAnKhachHangResponse!.ngayBatDau.toString()),
                  textAlign: TextAlign.left,
                  style: Dimensions.fontSizeStyle16(),
                ),
              ],
            ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          if (Validate.nullOrEmpty(controller.duAnKhachHangResponse!.gioiThieu) == false)
            Text(
              "Giới thiệu:",
              textAlign: TextAlign.left,
              style: Dimensions.fontSizeStyle18w600(),
            ),
          if (Validate.nullOrEmpty(controller.duAnKhachHangResponse!.gioiThieu) == false)
            Html(
              data: CommonHelper().htmlUnescape(controller.removeHeightImage(controller.duAnKhachHangResponse!.gioiThieu.toString())),
              style: {
                "html": Style(textAlign: TextAlign.justify),
                "table": Style(
                  backgroundColor: const Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                ),
                "img": Style(
                  width: MediaQuery.of(Get.context!).size.width,
                ),
                "tr": Style(
                  border: const Border(bottom: BorderSide(color: Colors.grey)),
                ),
                "th": Style(
                  padding: const EdgeInsets.all(6),
                  backgroundColor: Colors.grey,
                ),
                "td": Style(
                  padding: const EdgeInsets.all(6),
                  alignment: Alignment.topLeft,
                ),
                'p': Style(
                  padding: const EdgeInsets.all(0),
                  fontSize: const FontSize(Dimensions.FONT_SIZE_LARGE),
                ),
                'h5': Style(
                  fontWeight: FontWeight.bold,
                  fontSize: const FontSize(Dimensions.FONT_SIZE_EXTRA_LARGE),
                ),
                'h4': Style(
                  fontWeight: FontWeight.bold,
                  fontSize: const FontSize(Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE),
                ),
                'h3': Style(
                  fontWeight: FontWeight.bold,
                  fontSize: const FontSize(Dimensions.FONT_SIZE_OVER_LARGE),
                ),
                'h2': Style(
                  fontWeight: FontWeight.bold,
                  fontSize: const FontSize(Dimensions.FONT_SIZE_OVER_LARGE_LARGE),
                ),
                'h1': Style(
                  padding: const EdgeInsets.all(0),
                  fontWeight: FontWeight.bold,
                  fontSize: const FontSize(Dimensions.FONT_SIZE_OVER_LARGE_LARGE_LARGE),
                ),
              },
              customRender: {
                "bird": (RenderContext context, Widget child) {
                  return const TextSpan(text: "🐦");
                },
                "flutter": (RenderContext context, Widget child) {
                  return FlutterLogo(
                    style: (context.tree.element!.attributes['horizontal'] != null) ? FlutterLogoStyle.horizontal : FlutterLogoStyle.markOnly,
                    textColor: context.style.color!,
                    size: context.style.fontSize!.size! * 5,
                  );
                },
              },
              onLinkTap: (url, _, __, ___) {
                print("Opening $url...");
              },
              onImageTap: (src, _, __, ___) {
                print(src);
              },
              onImageError: (exception, stackTrace) {
                print(exception);
              },
              onCssParseError: (css, messages) {
                print("css that errored: $css");
                print("error messages:");
                for (final element in messages) {
                  print(element);
                }
              },
            ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Text(
            "Các hạng mục triển khai: ",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(
              0,
              0,
              0,
              Dimensions.PADDING_SIZE_SMALL,
            ),
            decoration: const BoxDecoration(
              color: ColorResources.WHITE,
              borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
              ),
            ),
            width: DeviceUtils.getScaledWidth(Get.context!, 1),
            child: Wrap(
              children: controller.kiemTraIdHangMucXayDungs()
                  ? controller.duAnKhachHangResponse!.idHangMucXayDungs!.map((e) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: ColorResources.HOME_BG,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: Dimensions.PADDING_SIZE_SMALL,
                        ),
                        margin: const EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_SMALL,
                          0,
                        ),
                        child: Text(
                          e.tieuDe.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          ),
                        ),
                      );
                    }).toList()
                  : [
                      Container(
                        margin: const EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_SMALL,
                          0,
                        ),
                        child: const Center(
                          child: Text(
                            'Không có',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                            ),
                          ),
                        ),
                      ),
                    ],
            ),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          const Text(
            "Nếu thầu thợ có thể tham gia dự án này, hãy kích nút “Đăng ký” chúng tôi sẽ liên hệ với bạn nếu dự án cần thêm nhân lực",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: ColorResources.RED,
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          if (controller.coTheBaoGia == true)
            BtnCustom(
              onTap: () {
                controller.moViewDangKyViecMoi();
              },
              color: ColorResources.PRIMARY,
              text: "Đăng ký",
              width: DeviceUtils.getScaledWidth(Get.context!, 1),
            )
          else
            const SizedBox.shrink(),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
        ],
      ),
    );
  }
}
