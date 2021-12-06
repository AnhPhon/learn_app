import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/screen/v1-customer/project/project_detail/project_detail_controller.dart';

class V1ProjectDetailPage extends GetView<V1ProjectDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1ProjectDetailController>(
      init: V1ProjectDetailController(),
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
                  elevation: 0,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //image
                      _imgProject(context, controller),

                      //title
                      _textTitle(context),

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
  Widget _imgProject(BuildContext context, V1ProjectDetailController controller) {
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
  Widget _textTitle(BuildContext context) {
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
          Text(
            "Giới thiệu:",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          if (Validate.nullOrEmpty(controller.duAnKhachHangResponse) == false && Validate.nullOrEmpty(controller.duAnKhachHangResponse!.gioiThieu) == false)
            Html(
              data: CommonHelper().htmlUnescape(controller.duAnKhachHangResponse!.gioiThieu.toString()),
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
                print("V1ProjectDetailPage that errored: $css");
                print("V1ProjectDetailPage messages:");
                for (final element in messages) {
                  print(element);
                }
              },
            )
          else
            Text(
              "Không có",
              textAlign: TextAlign.center,
              style: Dimensions.fontSizeStyle18w600(),
            ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
        ],
      ),
    );
  }
}
