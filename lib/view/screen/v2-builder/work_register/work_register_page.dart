import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/basewidget/widgets/label_dropdown.dart';
import 'package:template/view/screen/v2-builder/work_register/work_register_controller.dart';

class V2WorkRegisterPage extends GetView<V2WorkRegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBarWidget(title: controller.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Column(
            children: [
              // nhóm công việc phù hợp
              _dropdownWidget(
                  "Nhóm công việc phù hợp", controller.nhomCongViec!),
              
              SizedBox(
                height: DeviceUtils.getScaledHeight(
                  context,
                  Dimensions.SCALE_DEFAULT,
                ),
              ),

              // Công việc phù hợp
              _dropdownWidget(
                  "Chọn công việc phù hợp", controller.nhomCongViec!),
              
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

              // điểm đăng ký làm việc
              _diemDangKy(context, "Điểm đăng ký làm việc"),
              SizedBox(
                height: DeviceUtils.getScaledHeight(
                  context,
                  Dimensions.SCALE_DEFAULT,
                ),
              ),

              // Thêm địa điểm khác
              _dropdownWidget("Thêm địa điểm khác \n(chọn được nhiều địa điểm)",
                  controller.nhomCongViec!),
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
      ),
    );
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
              5,
              (index) => Stack(
                children: [
                  Checkbox(
                    value: controller.checkList![index],
                    onChanged: (val) {
                      controller.onChange(index, val);
                    },
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
                      title: "Title",//controller.provinceData![index].value.toString(),
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
        ],
      ),
      isRequired: true,
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
      isRequire: false,
      currencies: controller.currencies!,
      currentSelectvalue: ctrl.text,
      onChanged: (value) {
        controller.onLoaiCongTrinhChange(value);
      },
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
  /// time start
  ///
  Widget _timeStart(BuildContext context) {
    return LabelContent(
      title: "Thời gian bắt đầu",
      isRequired: false,
      content: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: controller.timeStartController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: '12/09/2021',
        ),
        onTap: () {
          controller.datePicker(
            context,
            DateTime(2021),
            DateTime(2021, 12, 31),
          );
        },
      ),
    );
  }

  ///
  /// time end
  ///
  Widget _timeEnd(BuildContext context) {
    return LabelContent(
      title: "Thời gian kết thúc",
      isRequired: false,
      content: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: controller.timeStartController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: '12/09/2021',
        ),
        onTap: () {
          controller.datePicker(
            context,
            DateTime(2021),
            DateTime(2021, 12, 31),
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
              child: const Text(
                "Đăng ký",
                style: TextStyle(
                  color: Colors.white,
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
