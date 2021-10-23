import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:template/data/model/response/don_vi_cung_cap_response.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/data/model/response/kho_hang_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/utils/color_resources.dart';

import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';

import 'package:template/view/screen/v4-employee/export_import/export_import_controller.dart';

class V4ExportImportPage extends GetView<V4ExportImportControleer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Xuất nhập kho"),
      body: GetBuilder(
          init: V4ExportImportControleer(),
          builder: (V4ExportImportControleer controller) {
            if (controller.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // chọn ngày xuất nhập kho
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Dimensions.PADDING_SIZE_DEFAULT,
                        ),
                        child: _timeExportImport(controller, context),
                      ),

                      //Chọn xuất hoặc nhập kho theo trang chủ
                      if (controller.isExport == true)
                        _exprot(controller, context)
                      else
                        _import(controller, context),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),

                  // Tên dự án
                  _project(controller, context),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),

                  //Tên kho theo dự án
                  _wareHouse(controller, context),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),

                  //đơn vị cung cấp
                  _supplier(controller, context),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),

                  //Tên vật tư/thiết bị
                  _supplies(controller, context),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_LARGE,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Số lượng
                        _customSoLuong(controller, context),

                        _customDonVi(controller, context),
                      ],
                    ),
                  ),
                  Container(
                    height: DeviceUtils.getScaledHeight(context, 0.03),
                  ),

                  //Nội dung khác(nếu có)
                  _ortherContent(controller, context),

                  Container(
                    height: DeviceUtils.getScaledHeight(context, 0.07),
                  ),

                  //Chọn xuất hoặc nhập kho theo trang chủ
                  if (controller.isExport == true)
                    _btnXuat(controller)
                  else
                    _btnNhap(controller),

                  Container(
                    height: DeviceUtils.getScaledHeight(context, 0.03),
                  ),
                ],
              ),
            );
          }),
    );
  }

  ///
  /// Chọn ngày xuất nhập kho
  ///
  Widget _timeExportImport(
      V4ExportImportControleer controller, BuildContext context) {
    return TextFieldDate(
      paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      isDate: true,
      allowEdit: false,
      controller: controller.timeExportImport,
      fontSize: Dimensions.FONT_SIZE_LARGE,
      holdplacer: "12-11-2021",
      label: "Ngày",
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 0.5),
    );
  }

  ///
  /// Xuất được chọn ở trang chủ
  ///
  Widget _exprot(V4ExportImportControleer controller, BuildContext context) {
    return InputField(
      boldHinText: true,
      allowEdit: false,
      allowMultiline: false,
      controller: controller.exportController,
      fontSize: Dimensions.FONT_SIZE_LARGE,
      hidden: false,
      holdplacer: 'Xuất',
      label: 'Loại xuất',
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 0.5),
    );
  }

  ///
  ///  Nhập được chọn ở trang Chủ
  ///
  Widget _import(V4ExportImportControleer controller, BuildContext context) {
    return InputField(
      isColorFieldWhite: true,
      boldHinText: true,
      allowEdit: false,
      allowMultiline: false,
      controller: controller.importController,
      fontSize: Dimensions.FONT_SIZE_LARGE,
      hidden: false,
      holdplacer: 'Nhập',
      label: 'Loại nhập',
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 0.5),
    );
  }

  ///
  ///Tên dự án
  ///
  Widget _project(V4ExportImportControleer controller, BuildContext context) {
    return DropDownButton1<DuAnNhanVienResponse>(
      isColorFieldWhite: true,
      labelBold: true,
      hint: 'Vui lòng chọn tên dự án',
      label: 'Tên dự án',
      data: controller.duAnNhanVienModelList,
      obligatory: true,
      onChanged: (value) => controller.onChangedDuAnNhanVien(value!),
      value: controller.duAnNhanVien,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }
}

///
///Tên kho theo dự án
///
Widget _wareHouse(V4ExportImportControleer controller, BuildContext context) {
  return DropDownButton1<KhoHangResponse>(
    isColorFieldWhite: true,
    labelBold: true,
    hint: 'Vui lòng chọn kho hàng',
    label: 'Kho hàng',
    data: controller.khoHangModelList,
    obligatory: true,
    onChanged: (value) => controller.onChangedKhoHang(value!),
    value: controller.khoHang,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
///Tên kho theo dự án
///
Widget _supplier(V4ExportImportControleer controller, BuildContext context) {
  return DropDownButton1<DonViCungCapResponse>(
    isColorFieldWhite: true,
    labelBold: true,
    hint: 'Vui lòng chọn đơn vị cung cấp',
    label: 'Đơn vị cung cấp',
    data: controller.donViCungCapModelList,
    obligatory: true,
    onChanged: (value) => controller.onChangedDonViCungCap(value!),
    value: controller.donViCungCap,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
///Tên vật tư/ thiết bị
///
Widget _supplies(V4ExportImportControleer controller, BuildContext context) {
  return DropDownButton1<VatTuResponse>(
    isColorFieldWhite: true,
    labelBold: true,
    hint: 'Vui lòng chọn vật tư',
    label: 'Tên vật tư/Thiết bị',
    data: controller.vatTuModelList,
    obligatory: true,
    onChanged: (value) => controller.onChangedVatTu(value!),
    value: controller.vatTu,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// Nội dung khác ( nếu có)
///
Widget _ortherContent(
    V4ExportImportControleer controller, BuildContext context) {
  return InputField(
    isColorFieldWhite: false,
    line: 5,
    allowEdit: true,
    allowMultiline: true,
    controller: controller.contentController,
    fontSize: Dimensions.FONT_SIZE_LARGE,
    hidden: false,
    holdplacer: 'Nhập nội dung khác',
    label: 'Nội dung khác(nếu có)',
    obligatory: false,
    typeInput: TextInputType.text,
    width: DeviceUtils.getScaledWidth(context, 1),
  );
}

///
/// Button xuất kho
///
Widget _btnXuat(V4ExportImportControleer controller) {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {
      controller.xuat();
    },
    title: 'Xuất',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}

///
/// Button nhập kho
///
Widget _btnNhap(V4ExportImportControleer controller) {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {
      controller.nhap();
    },
    title: 'Nhập',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}

///
/// Số lượng
///

Widget _customSoLuong(
    V4ExportImportControleer controller, BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        margin: const EdgeInsets.only(
          bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        ),
        alignment: Alignment.centerLeft,
        child: Wrap(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              'Số lượng',
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE, // * 2.1,
                fontWeight: FontWeight.w600,
                color: ColorResources.BLACK,
              ),
            ),
            const Text(
              '*',
              style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_LARGE, // * 2.1,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            )
          ],
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.tru();
            },
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: ColorResources.PRIMARY,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                    color: ColorResources.BLACK.withAlpha(60),
                  )
                ],
              ),
              child: const Icon(
                Icons.remove,
                color: ColorResources.WHITE,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            width: DeviceUtils.getScaledWidth(context, 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                    enabled: true,
                    controller: controller.countController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_DEFAULT + 2,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorResources.PRIMARYCOLOR),
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorResources.PRIMARYCOLOR),
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorResources.PRIMARYCOLOR),
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      filled: true,
                      isDense: true,
                      hintText: '0',
                      hintStyle: const TextStyle(
                        color: ColorResources.BLACK,
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.w600,
                      ),
                      fillColor: ColorResources.WHITE,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.cong();
            },
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                color: ColorResources.PRIMARY,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                    color: ColorResources.BLACK.withAlpha(60),
                  )
                ],
              ),
              child: const Icon(
                Icons.add,
                color: ColorResources.WHITE,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

///
/// Số lượng
///

Widget _customDonVi(V4ExportImportControleer controller, BuildContext context) {
  return Row(
    children: [
      Container(
        margin: const EdgeInsets.only(
          bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        ),
        alignment: Alignment.centerLeft,
        child: Wrap(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              'Đơn vị',
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE, // * 2.1,
                fontWeight: FontWeight.w600,
                color: ColorResources.BLACK,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            width: DeviceUtils.getScaledWidth(context, 0.2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                    enabled: true,
                    controller: controller.utils,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL,
                        vertical: Dimensions.PADDING_SIZE_DEFAULT + 2,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorResources.PRIMARYCOLOR),
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorResources.PRIMARYCOLOR),
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: ColorResources.PRIMARYCOLOR),
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                      ),
                      filled: true,
                      isDense: true,
                      hintText: '',
                      hintStyle: const TextStyle(
                        color: ColorResources.BLACK,
                        fontSize: Dimensions.FONT_SIZE_LARGE,
                        fontWeight: FontWeight.w600,
                      ),
                      fillColor: ColorResources.NOT_ALLOW_EDIT,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
