import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';

import 'package:template/view/basewidget/button/dropdown_button.dart';

import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';

import 'package:template/view/screen/v4-employee/timekeeping/timekeeping_controller.dart';

class V4TimekeepingPage extends GetView<V4TimekeepingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Thông tin chấm công",
      ),
      body: GetBuilder<V4TimekeepingController>(
          init: V4TimekeepingController(),
          builder: (V4TimekeepingController controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  // chọn thời gian chấm công
                  _timekeeping(controller, context),
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //dự án
                  _project(controller, context),
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //địa chỉ
                  _address(controller, context),
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //thành phố
                      _city(controller, context),

                      //quận/huyện
                      _district(controller, context),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //Phường/xã
                  _wards(controller, context),

                  Container(
                    height: DeviceUtils.getScaledHeight(context, .15),
                  ),
                  _btnTimekeeping(controller),

                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_LARGE,
                  ),
                ],
              ),
            );
          }),
    );
  }

  ///
  /// Chọn thời gian chấm công
  ///
  Widget _timekeeping(
      V4TimekeepingController controller, BuildContext context) {
    return InputWidget(
      fillColor: ColorResources.LIGHT_GREY.withOpacity(0.8),
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      allowEdit: false,
      label: "Thời gian",
      obligatory: true,
      width: DeviceUtils.getScaledWidth(context, 1),
      textEditingController: controller.timekeeping,
      suffixIcon: const Icon(
        Icons.date_range,
        size: Dimensions.ICON_SIZE_SMALL,
        color: ColorResources.PRIMARYCOLOR,
      ),
    );
  }

  ///
  /// dự án
  ///
  Widget _project(V4TimekeepingController controller, BuildContext context) {
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
      hint: 'Vui lòng chọn dự án',
      label: 'Dự án',
      data: controller.duAnNhanVienList,
      obligatory: true,
      onChanged: (value) => controller.onChangedDuAnNhanVien(value!),
      value: controller.duAnNhanVien,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }

  ///
  /// Địa chỉ
  ///
  Widget _address(V4TimekeepingController controller, BuildContext context) {
    return InputWidget(
      padding: const EdgeInsets.fromLTRB(
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
        Dimensions.PADDING_SIZE_DEFAULT,
        0,
      ),
      isColorFieldWhite: true,
      fillColor: ColorResources.WHITE,
      hintText: "Vui lòng nhập địa chỉ",
      label: 'Địa chỉ',
      obligatory: true,
      width: DeviceUtils.getScaledWidth(context, 1),
      textEditingController: controller.addressController,
    );
  }
}

///
/// Tỉnh /Tp
///
Widget _city(V4TimekeepingController controller, BuildContext context) {
  return DropDownButton1<TinhTpResponse>(
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      0,
      0,
    ),
    isColorFieldWhite: true,
    labelBold: true,
    label: 'Tỉnh/Tp',
    fillColor: ColorResources.WHITE,
    hint: 'Tỉnh/Tp',
    data: controller.tinhTps,
    obligatory: true,
    onChanged: (value) => controller.onChangedTinhThanh(value!),
    value: controller.tinh,
    width: .4,
  );
}

///
/// Quận/Huyện
///
Widget _district(V4TimekeepingController controller, BuildContext context) {
  return DropDownButton1<QuanHuyenResponse>(
    padding: const EdgeInsets.fromLTRB(
      0,
      0,
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
    ),
    isColorFieldWhite: true,
    labelBold: true,
    label: 'Quận/Huyện',
    fillColor: ColorResources.WHITE,
    hint: 'Quận/Huyện',
    data: controller.quanHuyenList,
    obligatory: true,
    onChanged: (value) => controller.onChangedQuanHuyen(value!),
    value: controller.quanHuyen,
    width: 0.4,
  );
}

///
/// Phường/Xã
///
Widget _wards(V4TimekeepingController controller, BuildContext context) {
  return DropDownButton1<PhuongXaResponse>(
    padding: const EdgeInsets.fromLTRB(
      Dimensions.PADDING_SIZE_DEFAULT,
      0,
      0,
      0,
    ),
    isColorFieldWhite: true,
    labelBold: true,
    label: 'Phường/Xã',
    fillColor: ColorResources.WHITE,
    hint: 'Phường/Xã',
    data: controller.phuongXaList,
    obligatory: true,
    onChanged: (value) => controller.onChangedPhuongXa(value!),
    value: controller.phuongXa,
    width: 0.4,
  );
}

///
/// Button chấm công
///
Widget _btnTimekeeping(V4TimekeepingController controller) {
  return LongButton(
    color: ColorResources.APPBARCOLOR,
    onPressed: () {
      controller.onChamCong();
    },
    title: 'Chấm công',
    horizontal: Dimensions.PADDING_SIZE_DEFAULT,
  );
}
