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
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';

import 'package:template/view/screen/v4-employee/export_import/export_import_controller.dart';

class V4ExportImportPage extends GetView<V4ExportImportControleer> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V4ExportImportControleer>(
      init: V4ExportImportControleer(),
      builder: (V4ExportImportControleer controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Scaffold(
              appBar: const AppBarWidget(title: "Xuất nhập kho"),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),
                    //Chọn xuất hoặc nhập kho theo trang chủ
                    if (controller.isExport == true)
                      _exprot(controller, context)
                    else
                      _import(controller, context),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    // chọn ngày xuất nhập kho
                    _timeExportImport(controller, context),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    // Tên dự án
                    _project(controller, context),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //Tên kho theo dự án
                    _wareHouse(controller, context),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //đơn vị cung cấp
                    _supplier(controller, context),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),

                    //Tên vật tư/thiết bị
                    _supplies(controller, context),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_DEFAULT,
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                        vertical: Dimensions.PADDING_SIZE_DEFAULT,
                      ),
                      child:
                          //Đơn vị
                          _customDonVi(controller, context),
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
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  /// Chọn ngày xuất nhập kho
  ///
  Widget _timeExportImport(
      V4ExportImportControleer controller, BuildContext context) {
    return InputWidget(
      labelBold: true,
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      isddMMyyyy: true,
      isColorFieldWhite: true,
      isDate: true,
      allowEdit: false,
      label: "Ngày",
      obligatory: true,
      width: 1,
      textEditingController: controller.timeExportImport,
      suffixIcon: const Icon(
        Icons.date_range,
        size: Dimensions.ICON_SIZE_SMALL,
        color: ColorResources.PRIMARYCOLOR,
      ),
    );
  }

  ///
  /// Xuất được chọn ở trang chủ
  ///
  Widget _exprot(V4ExportImportControleer controller, BuildContext context) {
    return InputWidget(
      labelBold: true,
      fillColor: ColorResources.LIGHT_GREY.withOpacity(0.8),
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      allowEdit: false,
      label: 'Loại xuất',
      obligatory: true,
      width: 1,
      textEditingController: controller.exportController,
    );
  }

  ///
  ///  Nhập được chọn ở trang Chủ
  ///
  Widget _import(V4ExportImportControleer controller, BuildContext context) {
    return InputWidget(
      labelBold: true,
      fillColor: ColorResources.LIGHT_GREY.withOpacity(0.8),
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      allowEdit: false,
      label: 'Loại nhập',
      obligatory: true,
      width: 1,
      textEditingController: controller.importController,
    );
  }

  ///
  ///Tên dự án
  ///
  Widget _project(V4ExportImportControleer controller, BuildContext context) {
    return DropDownButton1<DuAnNhanVienResponse>(
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      isColorFieldWhite: true,
      fillColor: ColorResources.WHITE,
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
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    fillColor: ColorResources.WHITE,
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
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    fillColor: ColorResources.WHITE,
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
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    fillColor: ColorResources.WHITE,
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
  return InputWidget(
    labelBold: true,
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    fillColor: ColorResources.WHITE,
    maxLine: 8,
    hintText: "Vui lòng nhập nội dung nếu có",
    label: 'Nội dung khác (nếu có)',
    width: DeviceUtils.getScaledWidth(context, 1),
    textEditingController: controller.contentController,
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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
      Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.tru();
            },
            child: Container(
              height: 22,
              width: 22,
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
                size: Dimensions.ICON_SIZE_SMALL,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
            ),
            width: DeviceUtils.getScaledWidth(context, 0.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
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
              height: 22,
              width: 22,
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
                size: Dimensions.ICON_SIZE_SMALL,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

///
///  Đơn vị
///

Widget _customDonVi(V4ExportImportControleer controller, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
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
        height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
      ),
      Row(
        children: [
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, 0.45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                    enabled: false,
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
                      fillColor: ColorResources.LIGHT_GREY.withOpacity(0.8),
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
