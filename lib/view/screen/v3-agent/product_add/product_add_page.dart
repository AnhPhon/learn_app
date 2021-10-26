import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/danh_muc_san_pham_response.dart';
import 'package:template/data/model/response/kho_hang_dai_ly_response.dart';
import 'package:template/data/model/response/loai_van_chuyen_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/btn_component_border.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
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
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //title image
                    _textTitle(context,
                        title: "Thêm hình ảnh (hoặc video) sản phẩm"),

                    _uploadImage(context, controller),

                    //Tên sản phẩm
                    InputWidget(
                      label: "Tên sản phẩm",
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.name,
                      fillColor: ColorResources.WHITE,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //Thương hiệu sản phẩm
                    InputWidget(
                      label: "Thương hiệu sản phẩm",
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.branch,
                      fillColor: ColorResources.WHITE,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //Giá sản phẩm
                    InputWidget(
                      label: "Giá sản phẩm",
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.price,
                      fillColor: ColorResources.WHITE,
                      textInputType: TextInputType.number,
                      thousandsSeparator: true,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //Mã sản phẩm
                    InputWidget(
                      label: "Mã sản phẩm",
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.code,
                      fillColor: ColorResources.WHITE,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //Quy cách
                    InputWidget(
                      label: "Quy cách",
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.quyCach,
                      fillColor: ColorResources.WHITE,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //Chi tiết sản phẩm
                    InputWidget(
                      label: "Chi tiết sản phẩm",
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.detail,
                      fillColor: ColorResources.WHITE,
                      maxLine: 5,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //product category
                    DropDownButton1<DanhMucSanPhamResponse>(
                      label: "Danh mục sản phẩm",
                      labelBold: true,
                      obligatory: true,
                      hint: "",
                      value: controller.danhMucSanPhamResponse,
                      onChanged: controller.onchangedProductCategory,
                      data: controller.danhMucSanPhamList,
                      width: double.infinity,
                      fillColor: ColorResources.WHITE,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //stock
                    InputWidget(
                      label: "Số lượng tồn kho",
                      obligatory: true,
                      width: double.infinity,
                      textEditingController: controller.stock,
                      fillColor: ColorResources.WHITE,
                      textInputType: TextInputType.number,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //shipping method
                    DropDownButton1<LoaiVanChuyenResponse>(
                      label: "Hình thức vận chuyển",
                      labelBold: true,
                      hint: " ",
                      value: controller.loaiVanChuyenResponse,
                      onChanged: controller.onchangedShippingMethod,
                      data: controller.loaiVanChuyenList,
                      width: double.infinity,
                      fillColor: ColorResources.WHITE,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

                    //warehouse name
                    DropDownButton1<KhoHangDaiLyResponse>(
                      label: "Kho hàng",
                      labelBold: true,
                      obligatory: true,
                      hint: " ",
                      value: controller.khoHangDaiLyResponse,
                      onChanged: controller.onchangedkhoHangDaiLy,
                      data: controller.khoHangDaiLyList,
                      width: double.infinity,
                      fillColor: ColorResources.WHITE,
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                    ),

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
          );
        });
  }

  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: title,
            style: Dimensions.fontSizeStyle18().copyWith(
              color: ColorResources.BLACK,
            ),
            children: const [
              TextSpan(
                text: "*",
                style: TextStyle(
                  color: ColorResources.RED,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  ///upload image
  ///
  Widget _uploadImage(BuildContext context, V3ProductAddController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        border: Border.all(color: ColorResources.PRIMARY),
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
      ),
      height: DeviceUtils.getScaledHeight(context, .158),
      child: Align(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.imageList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: Dimensions.PADDING_SIZE_EXTRA_SMALL + 3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        child: Image.file(
                          controller.imageList[index],
                          fit: BoxFit.fill,
                          height: DeviceUtils.getScaledHeight(context, .122),
                          width: DeviceUtils.getScaledWidth(context, .254),
                        ),
                      ),
                    );
                  }),
              GestureDetector(
                onTap: () => controller.pickImage(),
                child: Image.asset(
                  Images.add_image,
                  height: DeviceUtils.getScaledHeight(context, .122),
                  width: DeviceUtils.getScaledWidth(context, .254),
                  fit: BoxFit.fill,
                  color: ColorResources.PRIMARY,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  ///title and textfield
  ///
  Widget titleDropDown(V3ProductAddController controller,
      {required String title}) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(title,
              style: Dimensions.fontSizeStyle16().copyWith(
                color: ColorResources.BLACK,
              )),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),
        DropDownButton1<String>(
          hint: " ",
          value: "dropdown",
          onChanged: (val) {},
          data: const ["dropdown"],
          isColorFieldWhite: true,
          width: double.infinity,
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
      ],
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
            onTap: () => controller.btnUpdateAndAdd(context),
            text: "Cập nhật và thêm",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
          const SizedBox(
            width: Dimensions.MARGIN_SIZE_LARGE,
          ),
          BtnCustom(
            onTap: () => controller.btnAdd(context),
            // onTap: () => controller.printTest(),
            color: ColorResources.PRIMARY,
            text: "Cập nhật",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
        ],
      ),
    );
  }
}
