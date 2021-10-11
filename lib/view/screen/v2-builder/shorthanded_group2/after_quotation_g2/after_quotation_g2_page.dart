import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/content_widget.dart';
import 'package:template/view/screen/v1-customer/component_customer/image_list_horizontal_add.dart';
import 'package:template/view/screen/v1-customer/component_customer/row_text.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group2/after_quotation_g2/after_quotation_g2_controller.dart';

class V2AfterQuotationG2Page extends GetView<V2AfterQuotationG2Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2AfterQuotationG2Controller>(
        init: V2AfterQuotationG2Controller(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  const ContentWidget(
                    label: "Tiêu đề : Đập phá,sửa chữa,  cải tạo nhà cấp 4",
                    center: true,
                  ),

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
                    colorLabel: ColorResources.RED,
                    center: true,
                    centerLabel: true,
                    centerContent: true,
                  ),

                  //job info
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (BuildContext ctx, int index) {
                      return //infomation
                          Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                          vertical: Dimensions.PADDING_SIZE_DEFAULT,
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
                              text2: "20",
                            ),
                            _rowtext(
                              text1: "Đơn vị",
                              text2: "m2",
                            ),
                            _rowtext(
                              text1: "Đơn giá",
                              text2: "100.000 vnđ",
                            ),
                            const SizedBox(
                              height: Dimensions.MARGIN_SIZE_DEFAULT,
                            ),
                          ],
                        )),
                      );
                    },
                  ),

                  //show more
                  _showMore(),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //show file
                  const RowText(
                    text1: "File báo giá (nếu có)",
                    text2: "baogia.pdf",
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //quotation image
                  ImageListHorizontalAdd(
                    label: "Hình ảnh báo giá (nếu có)",
                    pickImage: () => controller.pickImage(),
                    imageFileList: controller.imageList,
                  ),

                  //order value
                  const RowText(
                    text1: "Giá trị đơn hàng",
                    text2: "11.000.000 vnđ",
                    colorRed: true,
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  //btn
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BtnCustom(
                          onTap: () => controller.onBtnEditClick(),
                          color: ColorResources.GREY,
                          text: "Chỉnh sửa",
                          width: DeviceUtils.getScaledWidth(context, .4),
                        ),
                        BtnCustom(
                          onTap: () => controller.onBtnSendClick(),
                          color: ColorResources.PRIMARY,
                          text: "Gửi báo giá",
                          width: DeviceUtils.getScaledWidth(context, .4),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
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
  Widget _rowtext({
    required String text1,
    required String text2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      ),
      child: DefaultTextStyle(
        textAlign: TextAlign.left,
        style: Dimensions.fontSizeStyle18().copyWith(
          color: ColorResources.BLACK,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                text1,
              ),
            ),
            Expanded(
                flex: 5,
                child: Text(
                  text2,
                )),
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
}
