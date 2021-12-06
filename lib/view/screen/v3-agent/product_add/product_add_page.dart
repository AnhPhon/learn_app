import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_map_data_button.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/btn_component_border.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/screen/v3-agent/product_add/product_add_controller.dart';

class V3ProductAddPage extends GetView<V3ProductAddController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3ProductAddController>(
      init: V3ProductAddController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return UnFocusTextField(
          widget: Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //upload image
                    _uploadImage(context, controller),

                    //danh muc san pham
                    SearchDropDownButton<DanhMucSanPhamResponse>(
                      label: "Danh mục sản phẩm",
                      data: controller.danhMucSanPhamList,
                      width: double.infinity,
                      value: controller.danhMucSanPhamResponse,
                      obligatory: true,
                      fillColor: ColorResources.WHITE,
                      isEnable: controller.danhMucSanPhamList.isNotEmpty,
                      highLightHint: controller.danhMucSanPhamList.isNotEmpty,
                      onChanged: controller.danhMucSanPhamList.isNotEmpty
                          ? controller.onchangedProductCategory
                          : null,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //Tên sản phẩm
                    InputWidget(
                      label: "Tên sản phẩm",
                      labelBold: true,
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.name,
                      fillColor: ColorResources.WHITE,
                      textInputAction: TextInputAction.next,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //Thương hiệu sản phẩm
                    InputWidget(
                      label: "Thương hiệu sản phẩm",
                      labelBold: true,
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.branch,
                      fillColor: ColorResources.WHITE,
                      textInputAction: TextInputAction.next,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //Giá sản phẩm
                    InputWidget(
                      label: "Giá sản phẩm (vnđ)",
                      labelBold: true,
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.price,
                      fillColor: ColorResources.WHITE,
                      textInputType: TextInputType.number,
                      thousandsSeparator: true,
                      textInputAction: TextInputAction.next,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //unit
                    InputWidget(
                      label: "Đơn vị",
                      labelBold: true,
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.unit,
                      fillColor: ColorResources.WHITE,
                      textInputAction: TextInputAction.next,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //Quy cách
                    InputWidget(
                      label: "Quy cách",
                      labelBold: true,
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.quyCach,
                      fillColor: ColorResources.WHITE,
                      textInputAction: TextInputAction.next,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //Chi tiết sản phẩm
                    InputWidget(
                      label: "Chi tiết sản phẩm",
                      labelBold: true,
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.detail,
                      fillColor: ColorResources.WHITE,
                      maxLine: 5,
                      textInputAction: TextInputAction.newline,
                      textInputType: TextInputType.multiline,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //tinh trang san pham
                    DropDownMapButton(
                      label: "Tình trạng sản phẩm",
                      labelBold: true,
                      obligatory: true,
                      value: controller.sanPhamRequest.tinhTrangSanPham,
                      onChanged: controller.onchangedTinhTrangSanPham,
                      data: TINH_TRANG_SAN_PHAM,
                      width: double.infinity,
                      fillColor: ColorResources.WHITE,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //Mã sản phẩm
                    InputWidget(
                      label: "Mã sản phẩm (cập nhật tự động)",
                      labelBold: true,
                      width: double.infinity,
                      textEditingController: controller.code,
                      fillColor: ColorResources.GREY.withOpacity(.3),
                      isBorder: false,
                      allowEdit: false,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //shipping method
                    // DropDownMapButton(
                    //   label: "Hình thức vận chuyển",
                    //   labelBold: true,
                    //   hint: " ",
                    //   value: controller.sanPhamRequest.kieuVanChuyen,
                    //   onChanged: controller.onchangedShippingMethod,
                    //   data: KIEU_VAN_CHUYEN,
                    //   width: double.infinity,
                    //   fillColor: ColorResources.WHITE,
                    //   padding: const EdgeInsets.only(
                    //     top: Dimensions.PADDING_SIZE_DEFAULT,
                    //   ),
                    // ),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_EXTRA_LARGE * 2,
                    ),

                    //btn
                    _btnBottom(context, controller: controller),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  ///upload image
  ///
  Widget _uploadImage(BuildContext context, V3ProductAddController controller) {
    return ImageListHorizontalAdd(
      label: "Thêm hình ảnh (hoặc video) sản phẩm",
      labelBold: true,
      obligatory: true,
      pickImage: () => controller.pickImages(),
      imageFileList: controller.urlImage,
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(BuildContext context,
      {required V3ProductAddController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BtnCustomBorder(
            onTap: () => controller.btnAdd(context, isUpdateAndAdd: true),
            text: "Cập nhật và thêm sản phẩm",
            height: .07,
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
          const SizedBox(
            width: Dimensions.MARGIN_SIZE_LARGE,
          ),
          BtnCustom(
            onTap: () => controller.btnAdd(context),
            color: ColorResources.PRIMARY,
            text: "Cập nhật",
            height: .07,
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
        ],
      ),
    );
  }
}
