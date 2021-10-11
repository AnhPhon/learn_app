import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
import 'package:template/view/screen/v3-agent/product_add/product_add_controller.dart';

class V3ProductAddPage extends GetView<V3ProductAddController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3ProductAddController>(
        init: V3ProductAddController(),
        builder: (controller) {
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

                    //
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.textControllerList.length - 1,
                      itemBuilder: (BuildContext ctx, int index) {
                        return InputWidget(
                          label: controller.titleList[index],
                          obligatory: true,
                          width: double.infinity,
                          textEditingController:
                              controller.textControllerList[index],
                          isColorFieldWhite: true,
                        );
                      },
                    ),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //product category
                    DropDownButton1<String>(
                      label: "Danh mục sản phẩm",
                      hint: " ",
                      value: "",
                      onChanged: (val) {},
                      data: const ["dropdown"],
                      isColorFieldWhite: true,
                      width: double.infinity,
                    ),

                    //stock
                    InputWidget(
                      label: "Số lượng tồn kho",
                      width: double.infinity,
                      textEditingController: controller.textControllerList.last,
                      isColorFieldWhite: true,
                    ),

                    //product status
                    DropDownButton1<String>(
                      label: "Tình trạng sản phẩm",
                      hint: " ",
                      value: "dropdown",
                      onChanged: (val) {},
                      data: const ["dropdown"],
                      isColorFieldWhite: true,
                      width: double.infinity,
                    ),

                    //shipping method
                    DropDownButton1<String>(
                      label: "Hình thức vận chuyển",
                      hint: " ",
                      value: "dropdown",
                      onChanged: (val) {},
                      data: const ["dropdown"],
                      isColorFieldWhite: true,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: _btnBottom(context, controller),
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
                  itemCount: controller.taxImageList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: Dimensions.PADDING_SIZE_EXTRA_SMALL + 3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        child: Image.file(
                          controller.taxImageList[index],
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
  Widget _btnBottom(BuildContext context, V3ProductAddController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BtnCustom(
            onTap: () {},
            color: ColorResources.GREY,
            text: "Cập nhật và thêm",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
          const SizedBox(
            width: Dimensions.MARGIN_SIZE_LARGE,
          ),
          BtnCustom(
            onTap: () {},
            color: ColorResources.PRIMARY,
            text: "Cập nhật",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
        ],
      ),
    );
  }
}
