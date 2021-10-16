import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/basewidget/widgets/label_dropdown.dart';
import 'package:template/view/basewidget/widgets/label_input.dart';
import 'package:template/view/screen/v2-builder/work_register/work_register_controller.dart';

class V2WorkRegisterPage extends GetView<V2WorkRegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBarWidget(title: controller.title),
        body: GetBuilder<V2WorkRegisterController>(
            init: V2WorkRegisterController(),
            builder: (V2WorkRegisterController controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Column(
                    children: [
                      // nhóm công việc phù hợp
                      _dropdownWidget(
                        "Nhóm công việc phù hợp",
                        controller.nhomCongViec,
                        true,
                        context,
                        controller.tenNhomCongViec,
                        controller.nhomDichVu.map((e) => e.tenDichVu!).toList(),
                        controller.onNhomCongViecChange,
                      ),

                      SizedBox(
                        height: DeviceUtils.getScaledHeight(
                          context,
                          Dimensions.SCALE_DEFAULT,
                        ),
                      ),

                      // Công việc phù hợp
                      _dropdownWidget(
                        "Chọn công việc phù hợp",
                        controller.congViecPhuHop,
                        false,
                        context,
                        "",
                        [""],
                        (value) {},
                      ),

                      SizedBox(
                        height: DeviceUtils.getScaledHeight(
                          context,
                          Dimensions.SCALE_DEFAULT,
                        ),
                      ),

                      // thời gian bắt đầu
                      _timeStart(context),

                      SizedBox(
                        height: DeviceUtils.getScaledHeight(
                          context,
                          Dimensions.SCALE_DEFAULT,
                        ),
                      ),

                      // thời gian bắt đầu
                      _timeEnd(context),

                      SizedBox(
                        height: DeviceUtils.getScaledHeight(
                          context,
                          Dimensions.SCALE_DEFAULT,
                        ),
                      ),

                      LabelInput(
                        label: "Số lượng",
                        labelText: "Số lượng",
                        controller: controller.soLuongController,
                        isRequire: true,
                      ),

                      SizedBox(
                        height: DeviceUtils.getScaledHeight(
                          context,
                          Dimensions.SCALE_DEFAULT,
                        ),
                      ),

                      // điểm đăng ký làm việc
                      _diemDangKy(context, "Điểm đăng ký làm việc"),
                      SizedBox(
                        height: DeviceUtils.getScaledHeight(
                          context,
                          Dimensions.SCALE_DEFAULT,
                        ),
                      ),

                      // Thêm địa điểm khác
                      _dropdownWidget(
                        "Thêm địa điểm khác \n(chọn được nhiều địa điểm)",
                        controller.diaDiemKhacController,
                        false,
                        context,
                        "",
                        [""],
                        (value) {},
                      ),
                      SizedBox(
                        height: DeviceUtils.getScaledHeight(
                          context,
                          Dimensions.SCALE_DEFAULT,
                        ),
                      ),

                      // nut đăng ký
                      _dangKyButton(context),
                    ],
                  ),
                ),
              );
            }));
  }

  ///
  /// địa điểm nhận
  ///
  Widget _diemDangKy(BuildContext context, String label) {
    return LabelContent(
      title: label,
      content: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text('Tỉnh/TP', style: Dimensions.textNormalStyle()),
                const Text(
                  '*',
                  style: TextStyle(
                    color: ColorResources.RED,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(
              context,
              Dimensions.SCALE_DEFAULT,
            ),
          ),
          _tinhThanhCheckBox(
            context,
            controller.tphcmCheck,
            "TP.HCM",
            (value) => controller.onCheckBoxChange(0, value: value!),
            [
              (value) {},
              (value) {},
            ],
            [[], []],
          ),
          _tinhThanhCheckBox(
            context,
            controller.hanoiCheck,
            "Hà Nội",
            (value) => controller.onCheckBoxChange(1, value: value!),
            [
              (value) {},
              (value) {},
            ],
            [[], []],
          ),
          _tinhThanhCheckBox(
            context,
            controller.danangCheck,
            "Đà Nẵng",
            (value) => controller.onCheckBoxChange(2, value: value!),
            [
              (value) {},
              (value) {},
            ],
            [[], []],
          ),
          _tinhThanhKhacCheckBox(
            context,
            controller.tinhKhacCheck,
            "Tỉnh khác",
            (value) => controller.onCheckBoxChange(3, value: value!),
            [(value) {}, (value) {}, (value) {}],
            [[], [], []],
          ),
        ],
      ),
      isRequired: false,
    );
  }

  ///
  /// Loại công trình
  ///
  Widget _dropdownWidget(
    String label,
    TextEditingController ctrl,
    bool require,
    BuildContext context,
    String selectValue,
    List<String> data,
    Function(String?) onChanged,
  ) {
    return LabelDropdown(
      label: label,
      labelText: label,
      controller: ctrl,
      isRequire: require,
      currencies: data,
      currentSelectvalue: selectValue,
      onChanged: onChanged,
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: onList.length,
          mainAxisExtent: 100,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: onList.length,
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
  /// time start
  ///
  Widget _timeStart(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Thời gian bắt đầu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
            Text("*", style: TextStyle(color: ColorResources.RED)),
          ],
        ),
        TextFieldDate(
          holdplacer: "16/10/2021",
          controller: controller.timeStartController,
          allowEdit: true,
          isDate: true,
          typeInput: TextInputType.datetime,
          width: DeviceUtils.getScaledWidth(context, 1),
          obligatory: true,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          paddingTop: Dimensions.FONT_SIZE_SMALL,
        )
      ],
    );
  }

  ///
  /// time end
  ///
  Widget _timeEnd(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              "Thời gian kết thúc",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
            Text("*", style: TextStyle(color: ColorResources.RED)),
          ],
        ),
        TextFieldDate(
          holdplacer: "16/10/2021",
          controller: controller.timeEndController,
          allowEdit: true,
          isDate: true,
          typeInput: TextInputType.datetime,
          width: DeviceUtils.getScaledWidth(context, 1),
          obligatory: true,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          paddingTop: Dimensions.FONT_SIZE_SMALL,
        )
      ],
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
    return SizedBox(
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
  /// check box tỉnh thành
  ///
  Widget _tinhThanhCheckBox(
    BuildContext context,
    bool firstValue,
    String label,
    Function(bool?) onchange,
    List<Function(dynamic)> selectFunctionList,
    List<List<String>> dataList,
  ) {
    return Stack(
      children: [
        Checkbox(
          value: firstValue,
          onChanged: onchange,
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
            title: label,
            content: _labelSelect(
              context,
              ["Quận/huyện", "Phường/xã"],
              selectFunctionList,
              dataList,
            ),
            isRequired: false,
          ),
        )
      ],
    );
  }

  ///
  /// check box tỉnh thành
  ///
  Widget _tinhThanhKhacCheckBox(
    BuildContext context,
    bool firstValue,
    String label,
    Function(bool?) onchange,
    List<Function(dynamic)> selectFunctionList,
    List<List<String>> dataList,
  ) {
    return Stack(
      children: [
        Checkbox(
          value: firstValue,
          onChanged: onchange,
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
            title: label,
            content: _labelSelect(
              context,
              ["Tỉnh/TP", "Quận/huyện", "Phường/xã"],
              selectFunctionList,
              dataList,
            ),
            isRequired: false,
          ),
        )
      ],
    );
  }

  ///
  /// đăng ký
  ///
  Widget _dangKyButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "Nếu bạn là thầu thợ  thì hãy nhấn nút “Đăng ký”",
              style: TextStyle(
                color: Colors.red,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
          ),
          SizedBox(
              height: DeviceUtils.getScaledHeight(
                  context, Dimensions.SCALE_DEFAULT)),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: DeviceUtils.getScaledWidth(context, 1),
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              decoration: const BoxDecoration(
                  color: ColorResources.THEME_DEFAULT,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT))),
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Đăng ký",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
