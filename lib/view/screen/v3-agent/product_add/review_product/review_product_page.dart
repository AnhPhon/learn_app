import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/screen/v3-agent/product_add/review_product/review_product_controlle.dart';

class V3ReviewProductPage extends GetView<V3ReviewProductController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3ReviewProductController>(
      init: V3ReviewProductController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(
            title: controller.title,
            isNotBack: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //upload image
                  _uploadImage(context, controller),

                  //product category
                  InputWidget(
                    label: "Danh mục sản phẩm",
                    labelBold: true,
                    obligatory: true,
                    width: double.infinity,
                    fillColor: ColorResources.WHITE,
                    textEditingController:
                        TextEditingController(text: controller.danhMucSanPham),
                    allowEdit: false,
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
                    textEditingController: TextEditingController(
                        text: controller.sanPhamRequest.ten),
                    allowEdit: false,
                    fillColor: ColorResources.WHITE,
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
                    fillColor: ColorResources.WHITE,
                    textEditingController: TextEditingController(
                        text: controller.sanPhamRequest.thuongHieu),
                    allowEdit: false,
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
                    fillColor: ColorResources.WHITE,
                    textEditingController: TextEditingController(
                      text: PriceConverter.convertPrice(
                        context,
                        double.parse(
                          controller.sanPhamRequest.gia.toString(),
                        ),
                      ),
                    ),
                    allowEdit: false,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),
                  
                  //unit
                  InputWidget(
                    label: "Đơn vị",
                    obligatory: true,
                    width: double.infinity,
                    fillColor: ColorResources.WHITE,
                    textEditingController: TextEditingController(
                        text: controller.sanPhamRequest.donVi),
                    allowEdit: false,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),

                  //Mã sản phẩm
                  InputWidget(
                    label: "Mã sản phẩm (cập nhật tự động)",
                    labelBold: true,
                    width: double.infinity,
                    fillColor: ColorResources.WHITE,
                    textEditingController: TextEditingController(
                        text: controller.sanPhamRequest.maSanPham),
                    allowEdit: false,
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
                    fillColor: ColorResources.WHITE,
                    textEditingController: TextEditingController(
                        text: controller.sanPhamRequest.quyCach),
                    allowEdit: false,
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
                    fillColor: ColorResources.WHITE,
                    textEditingController: TextEditingController(
                        text: controller.sanPhamRequest.moTa),
                    allowEdit: false,
                    maxLine: 5,
                    textInputType: TextInputType.multiline,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),

                  //unit
                  // InputWidget(
                  //   label: "Hình thức vận chuyển",
                  //   obligatory: true,
                  //   width: double.infinity,
                  //   fillColor: ColorResources.WHITE,
                  //   textEditingController: TextEditingController(
                  //       text: KIEU_VAN_CHUYEN[
                  //           controller.sanPhamRequest.kieuVanChuyen]),
                  //   allowEdit: false,
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
        );
      },
    );
  }

  ///
  ///upload image
  ///
  Widget _uploadImage(
      BuildContext context, V3ReviewProductController controller) {
    return ImageListHorizontalAdd(
      label: "Thêm hình ảnh (hoặc video) sản phẩm",
      labelBold: true,
      obligatory: true,
      pickImage: () {},
      imageFileList: controller.sanPhamRequest.hinhAnhSanPhams!,
      isAddImage: false,
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    );
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(BuildContext context,
      {required V3ReviewProductController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BtnCustom(
            onTap: () => controller.onBtnDoneClick(),
            color: ColorResources.PRIMARY,
            text: "Hoàn tất",
            height: .07,
            width: DeviceUtils.getScaledWidth(context, .9),
          ),
        ],
      ),
    );
  }
}
