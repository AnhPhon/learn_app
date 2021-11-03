import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group1/quotation_g1/quotation_g1_controller.dart';

class V2QuotationG1Page extends GetView<V2QuotationG1Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2QuotationG1Controller>(
        init: V2QuotationG1Controller(),
        builder: (controller) {
          return Scaffold(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: BoxShadowWidget(
                        child: Column(
                      children: [
                        const SizedBox(
                          height: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),
                        _rowtext(
                          text1: "Tên công việc",
                          text2: "Lát gạch phòng ngủ 600*600",
                        ),
                        _rowtext(
                          text1: "Quy cách",
                          text2: "Dùng keo, gạch thạch bàn mã TB123",
                        ),
                        _rowtext(
                          text1: "Khối lượng",
                          text2: controller.weight,
                        ),
                        _rowtext(
                          text1: "Đơn vị",
                          text2: "m2",
                        ),
                        _rowtext(
                          text1: "Đơn giá",
                          textController: controller.unitPriceController,
                        ),
                        const SizedBox(
                          height: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),
                      ],
                    )),
                  ),

                  //show more
                  _showMore(),

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

                  //order value
                  RowText(
                    text1: "Giá trị đơn hàng",
                    text2: controller.orderValue,
                    colorRed: true,
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                      vertical: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: BtnCustom(
                      onTap: () {},
                      color: ColorResources.PRIMARY,
                      text: "Gửi báo giá và chờ nhận kết quả",
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///row text
  ///
  Widget _rowtext({required String text1, String? text2, TextEditingController? textController}) {
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

  ///
  ///show more
  ///
  Widget _showMore() {
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
              "Xem thêm",
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
              padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE, horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
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
