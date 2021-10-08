import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/basewidget/widgets/label_dropdown.dart';
import 'package:template/view/basewidget/widgets/label_input.dart';
import 'package:template/view/screen/v1-customer/quote/request1/request_controller.dart';

class V1Request1Page extends GetView<V1Request1Controller> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V1Request1Controller>(
      init: V1Request1Controller(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBarWidget(title: controller.title),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                children: [
                  // tieu de bao gia
                  _inputWidget(
                      "Tiêu đề báo giá", controller.tieuDeBaoGiaController!),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context, Dimensions.SCALE_DEFAULT),
                  ),

                  // tieu de bao gia
                  _dropdownWidget(
                      "Chọn loại công trình", controller.loaiCongTrinh!),

                  // địa điểm nhận
                  _diaDiemNhan(context, "Địa điểm nhận"),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context, Dimensions.SCALE_DEFAULT),
                  ),

                  _inputWidget(
                    "Địa điểm nhận",
                    controller.tieuDeBaoGiaController!,
                  ),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context, Dimensions.SCALE_DEFAULT),
                  ),

                  LabelContent(
                    title: "Thời gian nhận dự kiến",
                    content: _thoiGianDuKien(context),
                    isRequired: true,
                  ),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                        context, Dimensions.SCALE_DEFAULT),
                  ),

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
  /// tiêu đề báo giá
  ///
  Widget _inputWidget(String label, TextEditingController ctrl) {
    return LabelInput(
      label: label,
      labelText: label,
      controller: ctrl,
      isRequire: true,
    );
  }

  ///
  /// Loại công trình
  ///
  Widget _dropdownWidget(String label, TextEditingController ctrl) {
    return LabelDropdown(
      label: label,
      labelText: label,
      controller: ctrl,
      isRequire: true,
      currencies: controller.currencies!,
      currentSelectvalue: ctrl.text,
      onChanged: (value) {
        controller.onLoaiCongTrinhChange(value);
      },
    );
  }

  ///
  /// địa điểm nhận
  ///
  Widget _diaDiemNhan(BuildContext context, String label) {
    return LabelContent(
      title: label,
      content: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text('Tỉnh/TP', style: Dimensions.textNormalStyle()),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(
              context,
              Dimensions.SCALE_DEFAULT,
            ),
          ),
          Column(
            children: List.generate(
              controller.provinceData!.length,
              (index) => Stack(
                children: [
                  Radio(
                    value: controller.provinceData![index].value,
                    groupValue: controller.selectIndex,
                    onChanged: controller.provinceData![index].onChanged,
                    fillColor: MaterialStateProperty.all(
                      ColorResources.THEME_DEFAULT,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: Dimensions.MARGIN_SIZE_EXTRA_LARGE * 2,
                      top: Dimensions.MARGIN_SIZE_SMALL,
                    ),
                    child: LabelContent(
                      title: controller.provinceData![index].value.toString(),
                      content: _labelSelect(
                        context,
                        ["Quận/huyện", "Phường/xã"],
                        [(value) {}, (value) {}],
                        [[], []],
                      ),
                      isRequired: false,
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              Stack(
                children: [
                  Radio(
                    value: "Tỉnh khác",
                    groupValue: controller.selectIndex,
                    onChanged: controller.onChange,
                    fillColor: MaterialStateProperty.all(
                      ColorResources.THEME_DEFAULT,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: Dimensions.MARGIN_SIZE_EXTRA_LARGE * 2,
                      top: Dimensions.MARGIN_SIZE_SMALL,
                    ),
                    child: LabelContent(
                      title: "Tỉnh khác".toString(),
                      content: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: Dimensions.PADDING_SIZE_SMALL,
                              right: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            child: _formField("Chọn tỉnh", (value) {}, []),
                          ),
                          _labelSelect(
                            context,
                            ["Quận/huyện", "Phường/xã"],
                            [(value) {}, (value) {}],
                            [[], []],
                          )
                        ],
                      ),
                      isRequired: false,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
      isRequired: true,
    );
  }

  ///
  /// labelSelect
  ///
  Widget _labelSelect(
    BuildContext context,
    List<String> labels,
    List<Function(dynamic)> onChangedList,
    List<List<String>> onList,
  ) {
    return SizedBox(
      height: 100,
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
            content:
                _formField(labels[index], onChangedList[index], onList[index]),
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
    return Container(
      height: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2,
      child: FormField<String>(
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
      ),
    );
  }

  ///
  /// thoiGianDuKien
  ///
  Widget _thoiGianDuKien(BuildContext context) {
    final List<String> labels = ["Từ", "Đến"];
    final List<Widget> contents = [
      _fromDateTimeWidget(context, "Từ", controller.fromDate!),
      _toDateTimeWidget(context, "Đến", controller.toDate!),
    ];
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
          return contents[index];
        },
      ),
    );
  }

  ///
  /// from date time widget
  ///
  Widget _fromDateTimeWidget(
    BuildContext context,
    String label,
    TextEditingController dateController,
  ) {
    return LabelContent(
      title: label,
      isRequired: false,
      content: SizedBox(
        child: TextField(
          focusNode: AlwaysDisabledFocusNode(),
          controller: dateController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '12/09/2021',
          ),
          onTap: () {
            controller.dateFromPicker(
              context,
              DateTime(2021),
              DateTime(2021, 12, 31),
            );
          },
        ),
      ),
    );
  }

  ///
  /// to date time widget
  ///
  Widget _toDateTimeWidget(
    BuildContext context,
    String label,
    TextEditingController dateController,
  ) {
    return LabelContent(
      title: label,
      isRequired: false,
      content: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: dateController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: '12/09/2021',
        ),
        onTap: () {
          controller.dateToPicker(
            context,
            DateTime(2021),
            DateTime(2021, 12, 31),
          );
        },
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
