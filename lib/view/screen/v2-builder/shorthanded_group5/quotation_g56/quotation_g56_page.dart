import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group5/quotation_g56/quotation_g56_controller.dart';

class V2QuotationG56Page extends GetView<V2QuotationG56Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2QuotationG56Controller>(
        init: V2QuotationG56Controller(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //title
                  const ContentWidget(
                    label:
                        "Báo giá cạnh tranh và đi kèm chất lượng tốt cho khách",
                    center: true,
                    centerLabel: true,
                    colorLabel: ColorResources.RED,
                  ),

                  //job title
                  const ContentWidget(
                    label: "Tiêu đề công việc ",
                    content: "Dịch vụ nấu nướng (đám cưới hỏi, giỗ,…)",
                  ),

                  //Specification
                  const ContentWidget(
                    label: "Thông số kỹ thuật: ",
                    content: "Thông số 1\nThông số 2",
                  ),

                  //haulage distance
                  const ContentWidget(
                    label: "Cự ly vận chuyển tương đối : ",
                    content: "20Km",
                  ),

                  //quotation by ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: Text(
                          "Báo giá theo",
                          style: Dimensions.fontSizeStyle16w600(),
                        ),
                      ),
                      DropDownButton1<String>(
                        hint: " ",
                        value: "Giờ",
                        onChanged: (val) {},
                        data: const ["Giờ", "Ca", "Chuyến", "Lần"],
                        isColorFieldWhite: true,
                        width: .5,
                      ),
                    ],
                  ),

                  //content
                  const ContentWidget(
                    label: "Nội dung chính kèm theo báo giá",
                  ),
                  //input content
                  InputWidget(
                    hintText:
                        "Nhập nội dung tương ứng với yêu cầu của khách hàng, nêu rõ một số chi tiết cần thiết để nêu rõ với khách hàng",
                    textEditingController: controller.contentController,
                    width: 1,
                    maxLine: 5,
                    isColorFieldWhite: true,
                  ),

                  //input quotation
                  InputWidget(
                    label: "Nhập báo giá gửi khách hàng",
                    obligatory: true,
                    textEditingController: controller.quotationController,
                    width: 1,
                    isColorFieldWhite: true,
                  ),

                  //order value
                  const RowText(
                    text1: "Giá trị đơn hàng",
                    text2: "500.00 vnđ",
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
                    child: BtnCustom(
                      onTap: () {},
                      color: ColorResources.PRIMARY,
                      text: "Gửi báo giá và chờ nhận kết quả",
                      width: DeviceUtils.getScaledWidth(context, 1),
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
}
