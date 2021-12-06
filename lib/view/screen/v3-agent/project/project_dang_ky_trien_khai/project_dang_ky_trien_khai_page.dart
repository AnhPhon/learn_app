import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:template/data/model/response/mat_hang_dac_trung_response.dart';
import 'package:template/data/model/response/nhom_cua_hang_response.dart';
import 'package:template/helper/common_helper.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v3-agent/project/project_dang_ky_trien_khai/project_dang_ky_trien_khai_controller.dart';

class V3ProjectDangKyTrienKhaiPage extends GetView<V3ProjectDangKyTrienKhaiController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3ProjectDangKyTrienKhaiController>(
      init: V3ProjectDangKyTrienKhaiController(),
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
                        _content(context),
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
  Widget _imgProject(BuildContext context, V3ProjectDangKyTrienKhaiController controller) {
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
  Widget _content(BuildContext context) {
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
            style: Dimensions.fontSizeStyle18(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Row(
            children: [
              Text(
                controller.kiemTraIdTrangThaiDuAnDangXayDung() == true ? "Dự kiến kết thúc: " : "Thời gian dự kiến triển khai: ",
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18w600(),
              ),
              Text(
                DateConverter.isoStringToddMMYYYY(controller.kiemTraIdTrangThaiDuAnDangXayDung() == true ? controller.duAnKhachHangResponse!.ngayKetThuc.toString() : controller.duAnKhachHangResponse!.ngayBatDau.toString()),
                textAlign: TextAlign.left,
                style: Dimensions.fontSizeStyle18(),
              ),
            ],
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          Text(
            "Giới thiệu:",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          if (Validate.checkValueIsNullEmpty(controller.duAnKhachHangResponse) == false && Validate.checkValueIsNullEmpty(controller.duAnKhachHangResponse!.gioiThieu) == false)
            Html(
              data: CommonHelper().htmlUnescape(controller.duAnKhachHangResponse!.gioiThieu.toString()),
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
          Text(
            "Thợ thầu đăng ký hạng mục tham gia báo giá",
            textAlign: TextAlign.left,
            style: Dimensions.fontSizeStyle18w600(),
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),

          // nhom cong viec
          if (controller.taiKhoanResponse != null && controller.taiKhoanResponse!.idNhomCuaHang != null)
            DropDownButton<NhomCuaHangResponse>(
              data: [controller.taiKhoanResponse!.idNhomCuaHang!],
              width: DeviceUtils.getScaledWidth(Get.context!, 1),
              value: controller.taiKhoanResponse!.idNhomCuaHang,
              obligatory: true,
              label: "Nhóm cửa hàng",
              hint: controller.taiKhoanResponse!.idNhomCuaHang!.tieuDe.toString(),
            )
          else
            const SizedBox(),

          const Label(
            label: "Mặt hàng đặc trưng",
            obligatory: true,
            horizontalPadding: 0,
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w600,
            ),
          ),

          // cong viec phu hop
          if (controller.taiKhoanResponse != null && controller.taiKhoanResponse!.idMatHangDacTrungs!.length > 1)
            MultiSelectDialogField(
              listType: MultiSelectListType.CHIP,
              items: controller.matHangDacTrungMultiSelectItem,
              title: const Text("Hãy chọn các mặt hàng đặc trưng"),
              selectedColor: Colors.blue,
              selectedItemsTextStyle: const TextStyle(color: ColorResources.WHITE),
              checkColor: ColorResources.WHITE,
              buttonText: const Text(
                "Mặt hàng đặc trưng",
                style: TextStyle(
                  color: ColorResources.GREY,
                  fontSize: 16,
                ),
              ),
              onConfirm: (List<MatHangDacTrungResponse?> results) {
                controller.selectedMatHangDacTrung(results);
                FocusScope.of(context).requestFocus(FocusNode());
              },
            )
          else
            const SizedBox(),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_LARGE,
          ),
          const Label(
            label: "Nội dung mô tả thêm",
            obligatory: false,
            horizontalPadding: 0,
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextField(
            textInputAction: TextInputAction.next,
            textAlignVertical: TextAlignVertical.center,
            controller: controller.noiDungMoTaThemController,
            keyboardType: TextInputType.text,
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
              hintText: "Nhập nội dung mô tả thêm",
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (val) {
              controller.danhSachThoThauBaoGiaRequest.noiDungMoTa = val.toString().trim();
            },
            maxLines: 5,
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
