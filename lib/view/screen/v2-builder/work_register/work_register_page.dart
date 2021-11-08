import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button_hide_under_line_widget.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/checkbox_custom.dart';
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
            child: Container(
              width: DeviceUtils.getScaledWidth(context, 1),
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                children: [
                  // nhóm công việc phù hợp
                  _dropdownWidget(
                    "Nhóm công việc phù hợp",
                    controller.nhomCongViecController,
                    true,
                    context,
                    controller.idNhomCongViec,
                    controller.nhomDichVu
                        .map((e) => [e.id!, e.tenDichVu!])
                        .toList(),
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
                    controller.congViecPhuHopController,
                    false,
                    context,
                    controller.idCongViec,
                    controller.congViecList
                        .map((e) => [e.id!, e.tenCongViec!])
                        .toList(),
                    controller.onCongViecChange,
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
                    isNumber: true,
                  ),

                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                      context,
                      Dimensions.SCALE_DEFAULT,
                    ),
                  ),

                  // điểm đăng ký làm việc
                  _diemDangKy(context, "Điểm đăng ký làm việc"),

                  // drop down field
                  DropDownField(context),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(
                      context,
                      Dimensions.SCALE_DEFAULT,
                    ),
                  ),

                  // chọn được nhiều địa điểm khác
                  diaDiemKhacWidget(
                    label: "Chọn địa điểm khác",
                    context: context,
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
        },
      ),
    );
  }

  ///
  /// địa điểm nhận
  ///
  Widget _diemDangKy(BuildContext context, String label) {
    return LabelContent(
      title: label,
      content: Container(
        alignment: Alignment.centerLeft,
        child: Row(
          children: const [
            Text(
              'Tỉnh/TP',
              style: TextStyle(
                color: ColorResources.BLACKGREY,
                fontSize: Dimensions.FONT_SIZE_DEFAULT,
              ),
            ),
            Text(
              '*',
              style: TextStyle(
                color: ColorResources.RED,
              ),
            )
          ],
        ),
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
    List<List<String>> data,
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
  /// Loại công trình
  ///
  Widget diaDiemKhacWidget({
    required String label,
    required BuildContext context,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
        MultiSelectDialogField<TinhTpResponse?>(
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
            border: const Border(
              bottom: BorderSide(
                color: ColorResources.LIGHT_GREY,
              ),
              left: BorderSide(
                color: ColorResources.LIGHT_GREY,
              ),
              right: BorderSide(
                color: ColorResources.LIGHT_GREY,
              ),
              top: BorderSide(
                color: ColorResources.LIGHT_GREY,
              ),
            ),
          ),
          closeSearchIcon: const Icon(Icons.close),
          items: controller.tinhTps!
              .map((e) => MultiSelectItem(e, e.ten!))
              .toList(),
          listType: MultiSelectListType.CHIP,
          onConfirm: (values) {
            controller.tinhTpsSelected = values;
          },
          buttonIcon: const Icon(Icons.arrow_drop_down),
          buttonText: const Text("Chọn tỉnh"),
          cancelText: const Text("Hủy bỏ"),
          confirmText: const Text("Chọn"),
          title: const Text("Chọn tỉnh"),
        ),
      ],
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
  /// hcm field
  ///
  Widget DropDownField(BuildContext context) {
    return SizedBox(
      width: DeviceUtils.getScaledWidth(context, 1),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                // hồ chí minh
                onSelectedWorkLocation(
                  context,
                  city: "Hồ Chí Minh",
                  district: controller.quanHuyenHCMList!,
                  ward: controller.phuongXaHCMList!,
                  value: controller.tphcmCheck,
                  onChanged: (val) {
                    controller.checkboxChange(1, val: val!);
                  },
                  onChangedHuyen: (QuanHuyenResponse? val) =>
                      controller.onChangedQuanHuyenHCM(val!),
                  onChangedPhuong: (PhuongXaResponse? val) =>
                      controller.onChangedPhuongXaHCM(val!),
                  phuong: controller.phuongXaHCM,
                  huyen: controller.quanHuyenHCM,
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(
                    context,
                    Dimensions.SCALE_DEFAULT,
                  ),
                ),

                // hà nội
                onSelectedWorkLocation(
                  context,
                  city: "Hà Nội",
                  district: controller.quanHuyenHaNoiList!,
                  ward: controller.phuongXaHaNoiList!,
                  value: controller.hanoiCheck,
                  onChanged: (val) {
                    controller.checkboxChange(2, val: val!);
                  },
                  onChangedHuyen: (QuanHuyenResponse? val) =>
                      controller.onChangedQuanHuyenHaNoi(val!),
                  onChangedPhuong: (PhuongXaResponse? val) =>
                      controller.onChangedPhuongXaHaNoi(val!),
                  phuong: controller.phuongXaHaNoi,
                  huyen: controller.quanHuyenHaNoi,
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(
                    context,
                    Dimensions.SCALE_DEFAULT,
                  ),
                ),

                // đà nẵng
                onSelectedWorkLocation(
                  context,
                  city: "Đà Nẵng",
                  district: controller.quanHuyenDaNangList!,
                  ward: controller.phuongXaDaNangList!,
                  value: controller.danangCheck,
                  onChanged: (val) {
                    controller.checkboxChange(3, val: val!);
                  },
                  onChangedHuyen: (QuanHuyenResponse? val) =>
                      controller.onChangedQuanHuyenDaNang(val!),
                  onChangedPhuong: (PhuongXaResponse? val) =>
                      controller.onChangedPhuongXaDaNang(val!),
                  phuong: controller.phuongXaDaNang,
                  huyen: controller.quanHuyenDaNang,
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(
                    context,
                    Dimensions.SCALE_DEFAULT,
                  ),
                ),

                // tỉnh khác
                onSelectedWorkLocation(
                  context,
                  city: "Tỉnh khác",
                  district: controller.quanHuyenKhacList!,
                  ward: controller.phuongXaKhacList!,
                  tinhList: controller.tinhTpsKhac,
                  value: controller.tinhKhacCheck,
                  onChanged: (val) {
                    controller.checkboxChange(4, val: val!);
                  },
                  onChangedProvince: (TinhTpResponse? val) =>
                      controller.onChangedTinhThanh(val!),
                  onChangedHuyen: (QuanHuyenResponse? val) =>
                      controller.onChangedQuanHuyenKhac(val!),
                  onChangedPhuong: (PhuongXaResponse? val) =>
                      controller.onChangedPhuongXaKhac(val!),
                  phuong: controller.phuongXaKhac,
                  huyen: controller.quanHuyenKhac,
                  tinh: controller.tinhTpKhac,
                  isRadio: false,
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(
                    context,
                    Dimensions.SCALE_DEFAULT,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///
  /// Radio button chon đia điểm làm việc
  ///
  Widget onSelectedWorkLocation(
    BuildContext context, {
    required List<QuanHuyenResponse> district,
    required String city,
    required List<PhuongXaResponse> ward,
    required bool value,
    QuanHuyenResponse? huyen,
    PhuongXaResponse? phuong,
    required Function(bool? val) onChanged,
    required Function(QuanHuyenResponse? val) onChangedHuyen,
    required Function(PhuongXaResponse? val) onChangedPhuong,
    bool? isRadio = true,
    List<TinhTpResponse>? tinhList,
    TinhTpResponse? tinh,
    Function(TinhTpResponse? val)? onChangedProvince,
  }) {
    const double scale = 1;
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            width: DeviceUtils.getScaledWidth(context, scale),
            child: CheckBoxCustom(
              status: value,
              title: city,
              onChanged: (val) => onChanged(val),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2),
            width: DeviceUtils.getScaledWidth(context, scale),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (isRadio == false)
                  DropDownButtonHideUnderLineWidget<TinhTpResponse>(
                    data: tinhList!,
                    onChanged: value == true
                        ? (TinhTpResponse? val) => onChangedProvince!(val)
                        : null,
                    value: tinh,
                    hint: "Chọn tỉnh khác",
                    width: DeviceUtils.getScaledWidth(context, scale / 4),
                  ),
                DropDownButtonHideUnderLineWidget<QuanHuyenResponse>(
                  data: district,
                  onChanged: value == true
                      ? (QuanHuyenResponse? val) => onChangedHuyen(val)
                      : null,
                  value: huyen,
                  hint: "Quận/Huyện",
                  width: DeviceUtils.getScaledWidth(context, scale / 4),
                ),
                DropDownButtonHideUnderLineWidget<PhuongXaResponse>(
                  data: ward,
                  onChanged: value == true
                      ? (PhuongXaResponse? val) => onChangedPhuong(val)
                      : null,
                  value: phuong,
                  hint: "Phường/xa",
                  width: DeviceUtils.getScaledWidth(context, scale / 4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///
  /// select province
  ///
  Widget dropDownProvinceField(
    BuildContext context,
    bool value,
    TinhTpResponse index,
    List<TinhTpResponse>? data,
    Function(TinhTpResponse) onChanged,
  ) {
    return DropDownButtonHideUnderLineWidget<TinhTpResponse>(
      data: data!,
      onChanged: value ? (TinhTpResponse? val) => onChanged(val!) : null,
      value: index,
      hint: "Chọn huyện khác",
      width: DeviceUtils.getScaledWidth(context, 0.83),
    );
  }

  ///
  /// select district
  ///
  Widget dropDownDistrictField(
    BuildContext context,
    bool value,
    QuanHuyenResponse index,
    List<QuanHuyenResponse>? data,
    Function(QuanHuyenResponse) onChanged,
  ) {
    return DropDownButtonHideUnderLineWidget<QuanHuyenResponse>(
      data: data!,
      onChanged: value ? (QuanHuyenResponse? val) => onChanged(val!) : null,
      value: index,
      hint: "Chọn huyện khác",
      width: DeviceUtils.getScaledWidth(context, 0.83),
    );
  }

  ///
  /// select phuong xa
  ///
  Widget dropDownPhuongXaField(
    BuildContext context,
    bool value,
    PhuongXaResponse index,
    List<PhuongXaResponse>? data,
    Function(PhuongXaResponse) onChanged,
  ) {
    return DropDownButtonHideUnderLineWidget<PhuongXaResponse>(
      data: data!,
      onChanged: value ? (PhuongXaResponse? val) => onChanged(val!) : null,
      value: index,
      hint: "Chọn huyện khác",
      width: DeviceUtils.getScaledWidth(context, 0.83),
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
            child: Text(
              controller.noteLabel.toString(),
              style: const TextStyle(
                color: Colors.red,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(
              context,
              Dimensions.SCALE_DEFAULT,
            ),
          ),
          GestureDetector(
            onTap: controller.onRegisterClick,
            child: Container(
              width: DeviceUtils.getScaledWidth(context, 1),
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              decoration: const BoxDecoration(
                  color: ColorResources.THEME_DEFAULT,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT))),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  controller.btnLabel.toString(),
                  style: const TextStyle(
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
