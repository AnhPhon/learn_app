import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v2-builder/project/project_dang_ky_trien_khai/project_dang_ky_trien_khai_controller.dart';

class V2ProjectDangKyTrienKhaiPage extends GetView<V2ProjectDangKyTrienKhaiController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ProjectDangKyTrienKhaiController>(
      init: V2ProjectDangKyTrienKhaiController(),
      builder: (controller) {
        return controller.duAnKhachHangResponse == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Scaffold(
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
                        _textTitle(),

                        //content
                        _content(),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  ///
  ///img product
  ///
  Widget _imgProject(BuildContext context, V2ProjectDangKyTrienKhaiController controller) {
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
          Text(
            "Địa điểm:",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),

          Text(
            controller.duAnKhachHangResponse!.diaDiem.toString(),
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
                print("V2ProjectDangKyTrienKhaiPage that errored: $css");
                print("V2ProjectDangKyTrienKhaiPage messages:");
                for (final element in messages) {
                  print(element);
                }
              },
            )
          else
            Text(
              "Không có",
              textAlign: TextAlign.center,
              style: Dimensions.fontSizeStyle16(),
            ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),

          Row(
            children: [
              Text(
                "Dự kiến kết thúc: ",
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18w600(),
              ),
              Text(
                DateConverter.isoStringToddMMYYYY(controller.duAnKhachHangResponse!.ngayKetThuc.toString()),
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18(),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),

          Text(
            "Thợ thầu đăng ký hạng mục tham gia báo giá",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),

          // nhom cong viec
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          SearchDropDownButton<NhomDichVuResponse?>(
            isColorFieldWhite: true,
            data: Validate.nullOrEmpty(controller.nhomDichVuResponse) == true ? [] : controller.nhomDichVuResponse!,
            obligatory: true,
            onChanged: (NhomDichVuResponse? val) {
              controller.selectedNhomCongViec(val);
            },
            value: controller.currentNhomDichVuResponse,
            width: DeviceUtils.getScaledSize(Get.context!, 1),
            label: "Nhóm công việc",
            hint: "Chọn nhóm công việc phù hợp",
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),

          // cong viec phu hop
          SearchDropDownButton<LoaiCongViecResponse?>(
            isColorFieldWhite: true,
            data: Validate.nullOrEmpty(controller.loaiCongViecResponse) == true ? [] : controller.loaiCongViecResponse!,
            obligatory: true,
            onChanged: (LoaiCongViecResponse? val) {
              controller.selectedCongViecPhuHop(val);
            },
            value: controller.currentLoaiCongViecResponseList,
            width: DeviceUtils.getScaledSize(Get.context!, 1),
            label: "Công việc phù hợp",
            hint: "Chọn công việc phù hợp",
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),

          const Label(
            label: "Thời gian bắt đầu làm",
            obligatory: true,
            horizontalPadding: 0,
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFieldDate(
            paddingTop: 0,
            allowEdit: false,
            controller: controller.textDateController,
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            holdplacer: 'Chọn ngày',
            obligatory: false,
            typeInput: TextInputType.datetime,
            width: DeviceUtils.getScaledWidth(Get.context!, 1),
            onDateTimeChanged: (val) {
              controller.updateNgayBatDau(val);
            },
            isDate: true,
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          const Label(
            label: "Số lượng người",
            obligatory: true,
            horizontalPadding: 0,
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextField(
            textInputAction: TextInputAction.next,
            textAlignVertical: TextAlignVertical.center,
            controller: controller.soLuongNguoiLamController,
            keyboardType: TextInputType.number,
            cursorColor: ColorResources.PRIMARY,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_SMALL,
                vertical: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                borderSide: const BorderSide(
                  color: ColorResources.PRIMARY,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                borderSide: const BorderSide(
                  color: ColorResources.PRIMARY,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                borderSide: const BorderSide(
                  color: ColorResources.PRIMARY,
                ),
              ),
              hintText: "Nhập số lượng người tham gia",
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (val) {
              if (val.isNotEmpty && val.isNumericOnly) {
                controller.danhSachThoThauBaoGiaRequest.soLuongNguoi = int.parse(val);
              }
            },
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          BtnCustom(
            onTap: () {
              controller.moViewDangKyViecMoi();
            },
            color: ColorResources.PRIMARY,
            text: "Đăng ký",
            width: DeviceUtils.getScaledWidth(Get.context!, 1),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
        ],
      ),
    );
  }
}
