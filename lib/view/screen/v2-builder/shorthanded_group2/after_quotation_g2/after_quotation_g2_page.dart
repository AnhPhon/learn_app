import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/helper/izi_string.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/content_widget.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/component/row_text.dart';
import 'package:template/view/basewidget/widgets/box_shadow_widget.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/screen/v2-builder/shorthanded_group2/after_quotation_g2/after_quotation_g2_controller.dart';

class V2AfterQuotationG2Page extends GetView<V2AfterQuotationG2Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2AfterQuotationG2Controller>(
        init: V2AfterQuotationG2Controller(),
        builder: (controller) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBarWidget(title: controller.title),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    //quotation ifo
                    SearchDropDownButton<String>(
                      isEnable: false,
                      isColorFieldWhite: true,
                      data: controller.quotationInfo,
                      obligatory: true,
                      onChanged: null,
                      value: controller.danhSachBaoGiaDonDichVuRequest.thongTinBaoGia,
                      width: DeviceUtils.getScaledSize(context, 1),
                      label: "Thông tin báo giá:",
                      hint: "Chọn thông tin báo giá",
                      padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
                    ),

                    //title
                    const ContentWidget(
                      label: "Báo giá cạnh tranh và đi kèm chất lượng tốt cho khách",
                      content: "(Bạn có thể nhập  công việc hoặc thêm file/ hình ảnh báo giá)",
                      colorLabel: ColorResources.RED,
                      center: true,
                      centerLabel: true,
                      centerContent: true,
                    ),

                    //infomation
                    buildListViewVatTu(controller),

                    //add more
                    // _addMore(),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //file
                    _file(),

                    // const SizedBox(
                    //   height: Dimensions.MARGIN_SIZE_DEFAULT,
                    // ),

                    //quotation image
                    ImageListHorizontalAdd(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      label: "Hình ảnh báo giá (nếu có)",
                      labelBold: true,
                      pickImage: null,
                      isAddImage: false,
                      imageFileList: controller.danhSachBaoGiaDonDichVuRequest.hinhAnhBaoGias ?? [],
                    ),

                    // const SizedBox(
                    //   height: Dimensions.MARGIN_SIZE_DEFAULT,
                    // ),
                    //
                    // InputWidget(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    //     vertical: Dimensions.PADDING_SIZE_SMALL,
                    //   ),
                    //   label: "Giá trị đơn hàng (nếu báo giá bằng file/ hình ảnh)",
                    //   hintText: "Nhập giá trị đơn hàng",
                    //   textEditingController: TextEditingController(),
                    //   width: MediaQuery
                    //       .of(context)
                    //       .size
                    //       .width - 10 * Dimensions.MARGIN_SIZE_LARGE,
                    //   // isColorFieldWhite: true,
                    //   allowEdit: false,
                    //   isColorFieldWhite: false,
                    //   textInputType: TextInputType.number,
                    //   labelBold: true,
                    //   onChanged: null,
                    // ),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //order value
                    RowText(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      text1: "Giá trị đơn hàng",
                      text2: "${CurrencyConverter.currencyConverterVND(int.parse(controller.danhSachBaoGiaDonDichVuRequest.tongTien.toString()) * 1.0)} VNĐ",
                      colorRed: true,
                    ),

                    //btn
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),
                        //btn cancel
                        BtnCustom(
                          onTap: () {
                            Get.back();
                            // controller.onCancleClick();
                          },
                          color: ColorResources.GREY,
                          text: "Chỉnh sửa",
                          width: DeviceUtils.getScaledWidth(Get.context!, 0.35),
                          // height: 0.085,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                            vertical: Dimensions.PADDING_SIZE_SMALL,
                          ),
                        ),

                        const Flexible(
                          fit: FlexFit.tight,
                          child: SizedBox(),
                        ),

                        //btn accept
                        BtnCustom(
                          onTap: () {
                            controller.onBtnSendClick();
                          },
                          text: "Gửi báo giá",
                          color: ColorResources.PRIMARY,
                          width: DeviceUtils.getScaledWidth(Get.context!, 0.35),
                          // height: 0.085,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                            vertical: Dimensions.PADDING_SIZE_SMALL,
                          ),
                        ),
                        const SizedBox(
                          width: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                    ),

                    //btn
                    // BtnCustom(
                    //   onTap: () => controller.onAfterQuotationG2PageClick(),
                    //   margin: const EdgeInsets.symmetric(
                    //     vertical: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                    //     horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                    //   ),
                    //   color: ColorResources.PRIMARY,
                    //   text: "Xem báo giá",
                    //   width: double.infinity,
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ListView buildListViewVatTu(V2AfterQuotationG2Controller controller) {
    return ListView.builder(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
        // bottom: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Validate.nullOrEmpty(controller.chiTietCongViecRequest) == false ? controller.chiTietCongViecRequest.length : 0,
      itemBuilder: (BuildContext ctx, int index) {
        return Container(
          margin: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: Validate.nullOrEmpty(controller.chiTietCongViecRequest[index].tenCongViec) == false ? BoxShadowWidget(
            child: Column(
              children: [
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                _rowtext(
                  text1: "Tên công việc:",
                  text2: controller.chiTietCongViecRequest[index].tenCongViec.toString(),
                ),
                _rowtext(
                  text1: "Quy cách:",
                  text2: controller.chiTietCongViecRequest[index].quyCach.toString(),
                ),
                _rowtext(
                  text1: "Khối lượng:",
                  text2: controller.chiTietCongViecRequest[index].soLuong.toString(),
                ),
                _rowtext(
                  text1: "Đơn vị",
                  text2: controller.chiTietCongViecRequest[index].donVi.toString(),
                ),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
              ],
            ),
          ) : Container(),
        );
      },
    );
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
        vertical: Dimensions.PADDING_SIZE_SMALL,
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
              ),
            ),
          ],
        ),
      ),
    );
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
        // onTap: controller.addChiTietCongViecForm,
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
        if (Validate.nullOrEmpty(controller.getFileNameBaoGia()) == false) fileWidget() else const SizedBox(),

        //working address
        // const SizedBox(
        //   height: Dimensions.MARGIN_SIZE_SMALL,
        // ),

        //add file
        // GestureDetector(
        //   // onTap: controller.pickFiles,
        //   child: BoxShadowWidget(
        //       padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_LARGE, horizontal: Dimensions.PADDING_SIZE_EXTRA_LARGE),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: const [
        //           Icon(Icons.add, size: Dimensions.ICON_SIZE_EXTRA_LARGE),
        //           Text("Cập nhật file báo giá"),
        //         ],
        //       )),
        // ),
      ],
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
              // color: ColorResources.RED,
              fontSize: Dimensions.FONT_SIZE_LARGE,
              // fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
