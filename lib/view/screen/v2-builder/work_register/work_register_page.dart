import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button_hide_under_line_widget.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/checkbox_custom.dart';
import 'package:template/view/basewidget/widgets/label_and_content.dart';
import 'package:template/view/screen/v2-builder/work_register/component/v2_number_input_widget.dart';
import 'package:template/view/screen/v2-builder/work_register/work_register_controller.dart';

class V2WorkRegisterPage extends GetView<V2WorkRegisterController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
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
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Column(
                    children: [
                      SizedBox(
                        height: DeviceUtils.getScaledHeight(
                          context,
                          Dimensions.SCALE_DEFAULT,
                        ),
                      ),

                      //Chọn nhóm công việc phù hợp
                      SearchDropDownButton<NhomDichVuResponse>(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: Dimensions.PADDING_SIZE_LARGE - 2,
                        ),
                        label: "Chọn nhóm công việc phù hợp",
                        hint: "Chọn hạng mục",
                        data: controller.nhomDichVu,
                        width: double.infinity,
                        value: controller.idNhomCongViec,
                        obligatory: true,
                        fillColor: ColorResources.WHITE,
                        isEnable: controller.nhomDichVu.isNotEmpty,
                        onChanged: controller.nhomDichVu.isNotEmpty
                            ? controller.onNhomCongViecChange
                            : null,
                      ),
                      SizedBox(
                        height: DeviceUtils.getScaledHeight(
                          context,
                          Dimensions.SCALE_DEFAULT,
                        ),
                      ),

                      //Chọn công việc phù hợp
                      SearchDropDownButton<LoaiCongViecResponse>(
                        isSort: controller.isSortLoaiCongViec,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: Dimensions.PADDING_SIZE_LARGE - 2,
                        ),
                        label: "Chọn công việc phù hợp",
                        hint: "Chọn hạng mục",
                        data: controller.congViecList,
                        width: double.infinity,
                        value: controller.idCongViec,
                        obligatory: true,
                        fillColor: ColorResources.WHITE,
                        isEnable: controller.congViecList.isNotEmpty,
                        onChanged: controller.congViecList.isNotEmpty
                            ? controller.onCongViecChange
                            : null,
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
                      V2InputWidget(
                        hintText: "Nhập số lượng (nhân sự/lao động/thiết bị)",
                        label: "Số lượng (nhân sự/lao động/thiết bị)",
                        justNumber: true,
                        textInputType: TextInputType.number,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 17, horizontal: 15),
                        textEditingController: controller.soLuongController,
                        width: 1,
                        fillColor: ColorResources.WHITE,
                        isColorFieldWhite: true,
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
                      dropDownField(context),
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
        MultiSelectDialogField<String?>(
          searchHint: "Tìm kiếm địa điểm khác...",
          searchable: true,
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
            border: const Border(
              bottom: BorderSide(
                color: ColorResources.PRIMARYCOLOR,
              ),
              left: BorderSide(
                color: ColorResources.PRIMARYCOLOR,
              ),
              right: BorderSide(
                color: ColorResources.PRIMARYCOLOR,
              ),
              top: BorderSide(
                color: ColorResources.PRIMARYCOLOR,
              ),
            ),
          ),
          closeSearchIcon: const Icon(Icons.close),
          items: controller.tinhTps
              .map((e) => MultiSelectItem(e.id.toString(), e.ten!))
              .toList(),
          initialValue: controller.tinhTpsSelected,
          listType: MultiSelectListType.CHIP,
          onConfirm: (List<String?> results) {
            controller.tinhTpsSelected.clear();
            controller.tinhTpsSelected = results;
            print("Anh Phone 2222 ${controller.tinhTpsSelected}");
            FocusScope.of(context).requestFocus(FocusNode());
          },
          buttonIcon: const Icon(Icons.arrow_drop_down),
          buttonText: const Text("Chọn địa điểm khác",
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.GREY,
              )),
          cancelText: const Text("Hủy bỏ"),
          confirmText: const Text("Chọn"),
          title: const Text(
            "Chọn địa điểm khác",
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w700,
            ),
          ),
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
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
            Text("*", style: TextStyle(color: ColorResources.RED)),
          ],
        ),
        TextFieldDate(
          holdplacer: "Chọn thời gian bắt đầu",
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
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.FONT_SIZE_LARGE,
              ),
            ),
          ],
        ),
        TextFieldDate(
          holdplacer: "Chọn thời gian kết thúc",
          controller: controller.timeEndController,
          allowEdit: true,
          isDate: true,
          typeInput: TextInputType.datetime,
          width: DeviceUtils.getScaledWidth(context, 1),
          obligatory: false,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          paddingTop: Dimensions.FONT_SIZE_SMALL,
        )
      ],
    );
  }

  ///
  /// hcm field
  ///
  Widget dropDownField(BuildContext context) {
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
                  district: controller.quanHuyenHCMList,
                  ward: controller.phuongXaHCMList!,
                  value: controller.tphcmCheck,
                  onChanged: (val) {
                    controller.checkboxChange(1, val: val!);
                  },
                  onChangedHuyen: (QuanHuyenResponse? val) {
                    print('phone 0');
                    controller.onChangedQuanHuyenHCM(val!);
                  },
                  onChangedPhuong: (PhuongXaResponse? val) {
                    print('phone 1');
                    controller.onChangedPhuongXaHCM(val!);
                  },
                  phuong: controller.phuongXaHCM,
                  huyen: controller.quanHuyenHCM,
                  highLightHint: controller.isEnableHCM,
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
                  highLightHint: controller.isEnableHN,
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
                  highLightHint: controller.isEnableDN,
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(
                    context,
                    Dimensions.SCALE_DEFAULT,
                  ),
                ),

                onSelectedWorkLocationOrther(
                  context,
                  city: "",
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
                  highLightHint: controller.isEnableTK,
                  isSortHuyen: true,
                  isSortPhuong: true,
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
    required bool highLightHint,
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
                  Expanded(
                    child: DropDownButtonHideUnderLineWidget<TinhTpResponse>(
                      data: tinhList!,
                      width: DeviceUtils.getScaledWidth(context, .3),
                      onChanged: value == true
                          ? (val) {
                              onChangedProvince!(val);
                            }
                          : null,
                      value: tinh,
                      hint: "Tỉnh/TP",
                      highLightHint: highLightHint,
                    ),
                  ),
                Expanded(
                  child: DropDownButtonHideUnderLineWidget<QuanHuyenResponse>(
                    data: district,
                    width: DeviceUtils.getScaledWidth(context, .3),
                    onChanged: value == true
                        ? (val) {
                            onChangedHuyen(val);
                          }
                        : null,
                    value: huyen,
                    hint: "Quận/huyện",
                    highLightHint: highLightHint,
                  ),
                ),
                Expanded(
                  child: DropDownButtonHideUnderLineWidget<PhuongXaResponse>(
                    data: ward,
                    width: DeviceUtils.getScaledWidth(context, .3),
                    onChanged: value == true
                        ? (val) {
                            onChangedPhuong(val);
                          }
                        : null,
                    value: phuong,
                    hint: "Phường/Xã",
                    highLightHint: highLightHint,
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
  Widget onSelectedWorkLocationOrther(
    BuildContext context, {
    required bool highLightHint,
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
    bool? isSortHuyen = false,
    bool? isSortPhuong = false,
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
            child: Row(
              children: [
                Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL)),
                    value: value,
                    onChanged: (val) => onChanged(val)),
                SearchDropDownButton<TinhTpResponse>(
                  isSort: false,
                  highLightHint: true,
                  isHideLineButton: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: Dimensions.PADDING_SIZE_LARGE - 2,
                  ),
                  hint: "Tỉnh/TP khác",
                  data: tinhList!,
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                  width: DeviceUtils.getScaledWidth(context, .433),
                  value: tinh,
                  isEnable: tinhList.isNotEmpty,
                  obligatory: false,
                  onChanged: value == true
                      ? (val) {
                          onChangedProvince!(val);
                        }
                      : null,
                ),
              ],
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
                  Expanded(
                    child: DropDownButtonHideUnderLineWidget<QuanHuyenResponse>(
                      isSort: isSortHuyen,
                      data: district,
                      width: DeviceUtils.getScaledWidth(context, .3),
                      onChanged: value == true
                          ? (val) {
                              onChangedHuyen(val);
                            }
                          : null,
                      value: huyen,
                      hint: "Quận/huyện",
                      highLightHint: highLightHint,
                    ),
                  ),
                Expanded(
                  child: DropDownButtonHideUnderLineWidget<PhuongXaResponse>(
                    isSort: isSortPhuong,
                    data: ward,
                    width: DeviceUtils.getScaledWidth(context, .3),
                    onChanged: value == true
                        ? (val) {
                            onChangedPhuong(val);
                          }
                        : null,
                    value: phuong,
                    hint: "Phường/Xã",
                    highLightHint: highLightHint,
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
