import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/basewidget/cupertino_supreme/select_box_supreme.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
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
                  SelectBoxSupreme<String?>(
                    obligatory: true,
                    label: "Thông tin báo giá:",
                    items: controller.quotationInfo,
                    onChanged: (val) {
                      controller.quotationInfoSelected = val.toString();
                    },
                    hint: "Chọn thông tin báo giá",
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

                  //infomation
                  buildListViewVatTu(controller),

                  //add more
                  _addMore(),

                  //file
                  _file(),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //quotation image
                  ImageListHorizontalAdd(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      vertical: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    label: "Hình ảnh báo giá (nếu có)",
                    pickImage: () => controller.pickImages(),
                    imageFileList: controller.danhSachBaoGiaDonDichVuRequest.hinhAnhBaoGias ?? [],
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  InputWidget(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      vertical: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    label: "Giá trị đơn hàng (nếu báo giá bằng file/ hình ảnh)",
                    textEditingController: controller.orderValueController,
                    width: double.infinity,
                    isColorFieldWhite: true,
                    allowEdit: controller.allowEdit,
                    textInputType: TextInputType.number,
                    onChanged: (val){
                      controller.setPriceFromInputCustom(val);
                    },
                  ),

                  //order value
                  RowText(
                    text1: "Giá trị đơn hàng",
                    text2: "${CurrencyConverter.currencyConverterVND(controller.orderValue * 1.0)} VNĐ",
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

  ListView buildListViewVatTu(V2QuotationG2Controller controller) {
    return ListView.builder(
        padding: const EdgeInsets.only(
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT,
          bottom: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (controller.chiTietCongViecRequest == null ||
                controller.chiTietCongViecRequest.isEmpty)
            ? 0
            : controller.chiTietCongViecRequest.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Container(
            child: BoxShadowWidget(
              padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              margin: const EdgeInsets.only(
                bottom: Dimensions.PADDING_SIZE_DEFAULT,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  const Label(
                    label: "Tên công việc:",
                    obligatory: true,
                    horizontalPadding: 0,
                    style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      textAlignVertical: TextAlignVertical.center,
                      controller: controller.jobNameControllers[index],
                      keyboardType: TextInputType.text,
                      cursorColor: ColorResources.PRIMARY,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_DEFAULT),
                            borderSide: const BorderSide(
                                color: ColorResources.PRIMARY)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_DEFAULT),
                            borderSide:
                                const BorderSide(color: ColorResources.GREY)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_DEFAULT),
                            borderSide:
                                const BorderSide(color: ColorResources.GREY)),
                        hintText: "Nhập Tên công việc",
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          controller.chiTietCongViecRequest[index].tenCongViec =
                              val.toString();
                        }
                      },
                    ),
                  ),

                  const Label(
                    label: "Quy cách:",
                    obligatory: true,
                    horizontalPadding: 0,
                    style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      textAlignVertical: TextAlignVertical.center,
                      controller: controller.specificationsControllers[index],
                      keyboardType: TextInputType.text,
                      cursorColor: ColorResources.PRIMARY,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_DEFAULT),
                            borderSide: const BorderSide(
                                color: ColorResources.PRIMARY)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_DEFAULT),
                            borderSide:
                                const BorderSide(color: ColorResources.GREY)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_DEFAULT),
                            borderSide:
                                const BorderSide(color: ColorResources.GREY)),
                        hintText: "Nhập Quy cách",
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          controller.chiTietCongViecRequest[index].quyCach =
                              val.toString();
                        }
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            const Label(
                              label: "Khối lượng:",
                              obligatory: true,
                              horizontalPadding: 0,
                              style: TextStyle(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              child: TextField(
                                textInputAction: TextInputAction.next,
                                textAlignVertical: TextAlignVertical.center,
                                controller: controller.weightControllers[index],
                                keyboardType: TextInputType.number,
                                cursorColor: ColorResources.PRIMARY,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding:
                                      const EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_SMALL,
                                    vertical:
                                        Dimensions.PADDING_SIZE_DEFAULT,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions
                                            .BORDER_RADIUS_EXTRA_SMALL),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.BORDER_RADIUS_DEFAULT),
                                      borderSide: const BorderSide(
                                          color: ColorResources.PRIMARY)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.BORDER_RADIUS_DEFAULT),
                                      borderSide: const BorderSide(
                                          color: ColorResources.GREY)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.BORDER_RADIUS_DEFAULT),
                                      borderSide: const BorderSide(
                                          color: ColorResources.GREY)),
                                  hintText: "Nhập Khối lượng:",
                                  filled: true,
                                  fillColor: Colors.transparent,
                                ),
                                onChanged: (val) {
                                  if (val.isNotEmpty && val.isNumericOnly) {
                                    controller.chiTietCongViecRequest[index].soLuong =
                                        val.toString();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            SelectBoxSupreme<String?>(
                              obligatory: true,
                              margin: EdgeInsets.all(0),
                              label: "Đơn vị",
                              items: controller.unitArray,
                              onChanged: (val) {
                                controller.chiTietCongViecRequest[index]
                                    .donVi = val.toString();
                              },
                              hint: "Chọn Đơn vị",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Label(
                    label: "Đơn giá",
                    obligatory: true,
                    horizontalPadding: 0,
                    style: TextStyle(
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      textAlignVertical: TextAlignVertical.center,
                      controller: controller.unitPriceControllers[index],
                      keyboardType: TextInputType.number,
                      cursorColor: ColorResources.PRIMARY,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_DEFAULT),
                            borderSide: const BorderSide(
                                color: ColorResources.PRIMARY)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_DEFAULT),
                            borderSide:
                                const BorderSide(color: ColorResources.GREY)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                Dimensions.BORDER_RADIUS_DEFAULT),
                            borderSide:
                                const BorderSide(color: ColorResources.GREY)),
                        hintText: "Nhập Đơn giá",
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty && val.isNumericOnly) {
                          controller.unitPrices[index] = val.toString();
                        }
                      },
                    ),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
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
        onTap: controller.addChiTietCongViecForm,
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
        RowText(text1: "File báo giá (nếu có)", text2: controller.getFileNameBaoGia()),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),

        //add file
        GestureDetector(
          onTap: controller.pickFiles,
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

  ///
  ///row text
  ///
  Widget _rowtext(
      {required String text1,
      String? text2,
      TextEditingController? textController}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: DefaultTextStyle(
        textAlign: TextAlign.left,
        style: Dimensions.fontSizeStyle16().copyWith(
          color: ColorResources.BLACK,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                text1,
              ),
            ),
            Expanded(
              flex: 5,
              child: text2 != null
                  ? Text(
                      text2,
                    )
                  : InputWidget(
                      textEditingController: textController!,
                      hintText: "",
                      width: double.infinity,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
