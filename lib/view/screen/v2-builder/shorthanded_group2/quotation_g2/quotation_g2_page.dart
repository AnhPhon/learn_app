import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/content_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/image_list_horizontal_add.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/row_text.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group2/quotation_g2/quotation_g2_controller.dart';

class V2QuotationG2Page extends GetView<V2QuotationG2Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2QuotationG2Controller>(
        init: V2QuotationG2Controller(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //quotation ifo
                  DropDownButton1<String>(
                    label: "Thông tin báo giá:",
                    labelBold: true,
                    hint: "Chọn thông tin báo giá",
                    onChanged: (val) {},
                    data: controller.quotationInfo,
                    isColorFieldWhite: true,
                    width: double.infinity,
                  ),

                  //title
                  const ContentWidget(
                    label:
                        "Báo giá cạnh tranh và đi kèm chất lượng tốt cho khách",
                    content:
                        "(Bạn có thể nhập  công việc hoặc thêm file/ hình ảnh báo giá)",
                    colorLabel: ColorResources.RED,
                    center: true,
                    centerLabel: true,
                    centerContent: true,
                  ),

                  //job name
                  InputWidget(
                    label: "Tên công việc:",
                    textEditingController: controller.jobNameController,
                    width: double.infinity,
                    isColorFieldWhite: true,
                  ),

                  //specifications
                  InputWidget(
                    label: "Quy cách:",
                    textEditingController: controller.specificationsController,
                    width: double.infinity,
                    isColorFieldWhite: true,
                  ),

                  // weight and unit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //weight
                      InputWidget(
                        label: "Khối lượng:",
                        textEditingController: controller.weightController,
                        width: .35,
                        isColorFieldWhite: true,
                      ),
                      //unit
                      DropDownButton1<String>(
                        label: "Đơn vị",
                        labelBold: true,
                        hint: " ",
                        onChanged: (val) {},
                        data: const ["m2", "km2"],
                        isColorFieldWhite: true,
                        width: .35,
                      ),
                    ],
                  ),

                  //unit price
                  InputWidget(
                    label: "Đơn giá (vnđ):",
                    textEditingController: controller.unitPriceController,
                    width: double.infinity,
                    isColorFieldWhite: true,
                  ),

                  //add more
                  _addMore(),

                  //file
                  _file(),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //quotation image
                  ImageListHorizontalAdd(
                    label: "Hình ảnh báo giá (nếu có)",
                    pickImage: () => controller.pickImage(),
                    imageFileList: controller.imageList,
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  InputWidget(
                    label: "Giá trị đơn hàng (nếu báo giá bằng file/ hình ảnh)",
                    textEditingController: controller.orderValueController,
                    width: double.infinity,
                    isColorFieldWhite: true,
                    allowEdit: controller.allowEdit,
                  ),

                  //order value
                  RowText(
                    text1: "Giá trị đơn hàng",
                    text2: controller.orderValue,
                    colorRed: true,
                  ),

                  //btn
                  BtnCustom(
                    onTap: () => controller.onAfterQuotationG2PageClick(),
                    margin: const EdgeInsets.symmetric(
                      vertical: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                      horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),
                    color: ColorResources.PRIMARY,
                    text: "Xem báo giá",
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///add more
  ///
  Widget _addMore() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Nhập thêm",
              style: Dimensions.fontSizeStyle16w600().copyWith(
                color: ColorResources.PRIMARY,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: ColorResources.PRIMARY,
              size: Dimensions.ICON_SIZE_SMALL,
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///file
  ///
  Widget _file() {
    return Column(
      children: [
        //show file
        const RowText(text1: "File báo giá (nếu có)", text2: "baogia.pdf"),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),

        //add file
        GestureDetector(
          onTap: () {},
          child: BoxShadowWidget(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_LARGE,
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, size: Dimensions.ICON_SIZE_EXTRA_LARGE),
                  Text("Cập nhật file báo giá"),
                ],
              )),
        ),
      ],
    );
  }
}
