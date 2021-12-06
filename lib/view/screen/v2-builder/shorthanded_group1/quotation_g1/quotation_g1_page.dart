import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/common_helper.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/helper/string_cut.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group1/quotation_g1/quotation_g1_controller.dart';

class V2QuotationG1Page extends GetView<V2QuotationG1Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2QuotationG1Controller>(
        init: V2QuotationG1Controller(),
        builder: (controller) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBarWidget(title: controller.title),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    //title
                    const ContentWidget(
                      label: "Báo giá cạnh tranh và đi kèm chất lượng tốt cho khách",
                      center: true,
                      centerLabel: true,
                      colorLabel: ColorResources.RED,
                    ),

                    //infomation
                    buildListViewVatTu(controller),

                    //file
                    _file(),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //quotation image
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      child: ImageListHorizontalAdd(
                        labelBold: true,
                        label: "Hình ảnh báo giá (nếu có)",
                        pickImage: () => controller.pickImages(),
                        imageFileList: controller.danhSachBaoGiaDonDichVuRequest.hinhAnhBaoGias ?? [],
                      ),
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
                      hintText: "Chỉ nhập khi tải lên file báo giá",
                      textEditingController: controller.giaTriDonHangTextController,
                      width: MediaQuery.of(context).size.width - 10 * Dimensions.MARGIN_SIZE_LARGE,
                      isColorFieldWhite: true,
                      textInputType: TextInputType.number,
                      labelBold: true,
                      onChanged: (val) {
                        controller.setPriceFromInputCustom(val);
                      },
                    ),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //order value
                    RowText(
                      text1: "Giá trị đơn hàng",
                      text2: "${CurrencyConverter.currencyConverterVND(controller.orderValue * 1.0)} VNĐ",
                      colorRed: true,
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      child: BtnCustom(
                        onTap: controller.onDoneClick,
                        color: ColorResources.PRIMARY,
                        text: "Gửi báo giá và chờ nhận kết quả",
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///
  ///row text
  ///
  Widget _rowtext({required String text1, String? text2, TextEditingController? textController, TextInputType? keyboardType, String? hint, bool? isFieldPrice}) {
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
                      hintText: hint,
                      width: double.infinity,
                      fillColor: Colors.white,
                      textInputType: keyboardType ?? TextInputType.text,
                    ),
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
        if (Validate.checkValueIsNullEmpty(controller.getFileNameBaoGia()) == false) fileWidget() else const SizedBox(),

        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),

        //add file
        GestureDetector(
          onTap: controller.pickFiles,
          child: BoxShadowWidget(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE, horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.add, size: Dimensions.ICON_SIZE_EXTRA_LARGE),
                Text("Cập nhật file báo giá"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// Danh sach chi tiet vat tu
  ///
  ListView buildListViewVatTu(V2QuotationG1Controller controller) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
        bottom: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: (controller.chiTietCongViecResponse == null || controller.chiTietCongViecResponse!.isEmpty) ? 0 : controller.chiTietCongViecResponse!.length,
      itemBuilder: (BuildContext ctx, int index) {
        return Container(
          margin: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: BoxShadowWidget(
            child: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                _rowtext(
                  text1: "Tên công việc:",
                  text2: controller.chiTietCongViecResponse![index].tenCongViec.toString(),
                ),
                _rowtext(
                  text1: "Quy cách:",
                  text2: controller.chiTietCongViecResponse![index].quyCach.toString(),
                ),
                _rowtext(
                  text1: "Khối lượng:",
                  text2: controller.chiTietCongViecResponse![index].soLuong.toString(),
                ),
                _rowtext(
                  text1: "Đơn vị",
                  text2: controller.chiTietCongViecResponse![index].donVi.toString(),
                ),
                _rowtext(
                  text1: "Đơn giá",
                  textController: controller.unitPriceControllers[index],
                  keyboardType: TextInputType.number,
                  hint: '0',
                  isFieldPrice: true,
                ),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  /// fileWidget
  ///
  Widget fileWidget() {
    return Container(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
        bottom: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: LabelContent(
        title: "File báo giá(nếu có):",
        isRequired: false,
        content: GestureDetector(
          onTap: () {
            CommonHelper.openLink(url: controller.danhSachBaoGiaDonDichVuRequest.file.toString());
          },
          child: Text(
            StringCut.getFileNameBaoGia(controller.danhSachBaoGiaDonDichVuRequest.file.toString()),
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
            ),
          ),
        ),
      ),
    );
  }
}
