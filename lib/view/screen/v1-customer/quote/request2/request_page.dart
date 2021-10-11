import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/widgets/content_whitebox.dart';
import 'package:template/view/basewidget/widgets/file_upload.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/basewidget/widgets/label_dropdown.dart';
import 'package:template/view/basewidget/widgets/label_textarea.dart';
import 'package:template/view/basewidget/widgets/three_image_box.dart';
import 'package:template/view/screen/v1-customer/quote/request2/request_controller.dart';

class V1Request2Page extends GetView<V1Request2Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1Request2Controller>(
      init: V1Request2Controller(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                children: [
                  _noiDungWidget(),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                      context,
                      Dimensions.SCALE_DEFAULT,
                    ),
                  ),

                  // ten vat tu
                  _dropdownWidget(
                    'Tên vật tư',
                    controller.tenVatTuController!,
                    ["Xi măng 1", "Vật tư 1", "Vật tư 2"],
                    controller.onVatTuChange,
                    controller.tenVatTuIndex,
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                      context,
                      Dimensions.SCALE_DEFAULT,
                    ),
                  ),

                  // quy cach
                  _dropdownWidget(
                    'Quy cách',
                    controller.tenVatTuController!,
                    ["Xi măng 1", "Vật tư 1", "Vật tư 2"],
                    controller.onVatTuChange,
                    controller.tenVatTuIndex,
                  ),

                  //
                  _khoiLuongVaDonVi(
                    context,
                    ["Khối lượng", "Đơn vị"],
                    [(value) {}, (value) {}],
                    [[], []],
                  ),

                  // add button
                  _addBtn(context),

                  // vat lieu đã được thêm
                  Column(
                    children: List.generate(2, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: ContentWhiteBox(infoCard: controller.infoCard!),
                      );
                    }),
                  ),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                      context,
                      Dimensions.SCALE_DEFAULT,
                    ),
                  ),

                  // Hình ảnh bảng khối lượng
                  _hinhAnhKhoiLuong(),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                      context,
                      Dimensions.SCALE_DEFAULT,
                    ),
                  ),

                  // file upload
                  _fileUpload(context),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                      context,
                      Dimensions.SCALE_DEFAULT,
                    ),
                  ),

                  // can gap
                  _canGapWidget(context),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                      context,
                      Dimensions.SCALE_DEFAULT,
                    ),
                  ),

                  // next button
                  _nextBtn(context)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  /// nội dung
  ///
  Widget _noiDungWidget() {
    return LabelTextarea(
      label: "Nội dung yêu cầu",
      labelText: "Nội dung yêu cầu",
      controller: controller.tieuDeBaoGiaController!,
      isRequire: true,
    );
  }

  ///
  /// Loại công trình
  ///
  Widget _dropdownWidget(String label, TextEditingController ctrl,
      List<String> currencies, Function(String?) onChanged, String? index) {
    return LabelDropdown(
      label: label,
      labelText: label,
      controller: ctrl,
      isRequire: false,
      currentSelectvalue: index!,
      currencies: currencies,
      onChanged: onChanged,
    );
  }

  ///
  /// khối lượng và đơn vị
  ///
  Widget _khoiLuongVaDonVi(
    BuildContext context,
    List<String> labels,
    List<Function(dynamic)> onChangedList,
    List<List<String>> onList,
  ) {
    return SizedBox(
      height: 120,
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 100,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (BuildContext ctx, index) {
          return LabelContent(
            title: labels[index],
            content: _formField(
              labels[index],
              onChangedList[index],
              onList[index],
            ),
            isRequired: false,
          );
        },
      ),
    );
  }

  ///
  /// form field
  ///
  Widget _formField(
    String label,
    Function(dynamic) onChanged,
    List<String> contentList,
  ) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelStyle: Dimensions.textNormalStyle(),
            errorStyle: const TextStyle(
              color: Colors.redAccent,
              fontSize: Dimensions.FONT_SIZE_DEFAULT,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                Dimensions.BORDER_RADIUS_SMALL,
              ),
            ),
          ),
          isEmpty: label == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: label,
              isDense: true,
              onChanged: onChanged,
              items: contentList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  ///
  /// add button
  ///
  Widget _addBtn(BuildContext context) {
    return GestureDetector(
      onTap: controller.onAddButton,
      child: Container(
        width: DeviceUtils.getScaledWidth(context, 1),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(
          Dimensions.PADDING_SIZE_EXTRA_LARGE,
        ),
        decoration: const BoxDecoration(
            color: ColorResources.THEME_DEFAULT,
            borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.BORDER_RADIUS_SMALL))),
        child: const Text(
          "Thêm vật tư",
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  ///
  /// hinh anh khoi luong
  ///
  Widget _hinhAnhKhoiLuong() {
    return const LabelContent(
      title: "Hình ảnh bảng khối lượng",
      isRequired: false,
      content: ThreeImageBox(
        images: [
          Images.location_example,
          Images.location_example,
          Images.location_example,
        ],
        allowPicker: false,
      ),
    );
  }

  ///
  /// file upload
  ///
  Widget _fileUpload(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const LabelContent(
        title: "Đính kèm file excel hoặc khác:",
        isRequired: false,
        content: FileUploadWidget(label: "Thêm file"),
      ),
    );
  }

  ///
  /// cần gấp
  ///
  Widget _canGapWidget(BuildContext context) {
    final List<String> labels = ["Cần gấp", "Không gấp, giao kết hợp"];
    final List<Function(dynamic)> onChangeList = [(value) {}, (value) {}];
    return GestureDetector(
      onTap: () {},
      child: LabelContent(
        title: "Chọn tiến độ giao hàng:",
        isRequired: true,
        content: Row(
          children: List.generate(
            2,
            (index) => Stack(
              children: [
                Radio(
                  value: labels[index],
                  groupValue: "Cần gấp",
                  onChanged: onChangeList[index],
                  fillColor: MaterialStateProperty.all(
                    ColorResources.THEME_DEFAULT,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: Dimensions.MARGIN_SIZE_EXTRA_LARGE * 2,
                    top: Dimensions.MARGIN_SIZE_SMALL,
                  ),
                  child: Text(labels[index].toString()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// next button
  ///
  Widget _nextBtn(BuildContext context) {
    return GestureDetector(
      onTap: controller.nextPage,
      child: Container(
        width: DeviceUtils.getScaledWidth(context, 1),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(
          Dimensions.PADDING_SIZE_EXTRA_LARGE,
        ),
        decoration: const BoxDecoration(
            color: ColorResources.THEME_DEFAULT,
            borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.BORDER_RADIUS_SMALL))),
        child: const Text(
          "Tiếp tục",
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.FONT_SIZE_LARGE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
