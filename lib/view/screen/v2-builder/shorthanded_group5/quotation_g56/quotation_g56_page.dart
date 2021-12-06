import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
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

                  //job title
                  if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idThongSoKyThuats) == false)
                    ContentWidget(
                      label: "Tiêu đề công việc ",
                      content: controller.donDichVuResponse.tieuDe.toString(),
                    )
                  else
                    const SizedBox(),

                  //Specification
                  if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.idThongSoKyThuats) == false)
                    ContentWidget(
                      label: "Thông số kỹ thuật: ",
                      content: controller.donDichVuResponse.idThongSoKyThuats!.map((e) => e.tieuDe.toString()).join('\n'),
                    )
                  else
                    const SizedBox(),

                  //haulage distance
                  if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.cuLyVanChuyen) == false)
                    ContentWidget(
                      label: "Cự ly vận chuyển tương đối : ",
                      content: '${controller.donDichVuResponse.cuLyVanChuyen} m',
                    )
                  else
                    const SizedBox(),

                  //The amount of people
                  if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.soLuongYeuCau) == false)
                    ContentWidget(
                      label: "Số lượng yêu cầu:",
                      content: controller.donDichVuResponse.soLuongYeuCau.toString(),
                    )
                  else
                    const SizedBox(),

                  //The amount of people
                  if (Validate.checkValueIsNullEmpty(controller.donDichVuResponse.donVi) == false)
                    ContentWidget(
                      label: "Báo giá theo:",
                      content: controller.donDichVuResponse.donVi.toString(),
                    )
                  else
                    const SizedBox(),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //input content
                  InputWidget(
                    padding: const EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_DEFAULT,
                      right: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    label: "Nội dung đính kèm theo báo giá",
                    hintText: "Nhập nội dung tương ứng với yêu cầu của khách hàng, nêu rõ một số chi tiết cần thiết để nêu rõ với khách hàng",
                    textEditingController: controller.contentController,
                    width: 1,
                    maxLine: 5,
                    isColorFieldWhite: true,
                    labelBold: true,
                    onChanged: (val) {
                      controller.danhSachBaoGiaDonDichVuRequest.ghiChu = val.toString();
                    },
                    obligatory: true,
                  ),

                  //input quotation
                  InputWidget(
                    padding: const EdgeInsets.all(
                      Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    label: "Nhập báo giá gửi khách hàng",
                    labelBold: true,
                    obligatory: true,
                    textEditingController: controller.quotationController,
                    width: 1,
                    isColorFieldWhite: true,
                    textInputType: TextInputType.number,
                    onChanged: (val) {
                      controller.danhSachBaoGiaDonDichVuRequest.tongTien = val.toString();
                    },
                  ),

                  //order value
                  RowText(
                    text1: "Giá trị đơn hàng",
                    text2: "${CurrencyConverter.currencyConverterVND(int.parse(controller.getPriceValue()) * 1.0)} VNĐ",
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
                      onTap: controller.onDoneClick,
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
          ),
        );
      },
    );
  }
}
