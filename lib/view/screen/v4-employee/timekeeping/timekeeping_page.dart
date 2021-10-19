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

import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
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
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),

                  // chọn thời gian chấm công
                  _timekeeping(controller, context),

                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_EXTRA_SMALL + 4,
                  ),
                  //dự án
                  _project(controller, context),

                  //địa chỉ
                  _address(controller, context),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
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
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),

                  //Phường/xã
                  _wards(controller, context),

                  Container(
                    height: DeviceUtils.getScaledHeight(context, .1),
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
    return TextFieldDate(
      paddingTop: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      isDate: true,
      allowEdit: false,
      controller: controller.timekeeping,
      fontSize: Dimensions.FONT_SIZE_LARGE,
      holdplacer: "12-11-2021",
      label: "Thời gian",
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }

  ///
  /// dự án
  ///
  Widget _project(V4TimekeepingController controller, BuildContext context) {
    return DropDownButton1<DuAnNhanVienResponse>(
      isColorFieldWhite: true,
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
    return InputField(
      isColorFieldWhite: false,
      allowEdit: true,
      allowMultiline: false,
      controller: controller.addressController,
      fontSize: Dimensions.FONT_SIZE_LARGE,
      hidden: false,
      holdplacer: 'Vui lòng nhập địa chỉ cụ thể',
      label: 'Địa chỉ',
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context, 1),
    );
  }
}

///
/// Tỉnh /Tp
///
Widget _city(V4TimekeepingController controller, BuildContext context) {
  return DropDownButton1<TinhTpResponse>(
    labelBold: true,
    label: 'Tỉnh/Tp',
    isColorFieldWhite: true,
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
    labelBold: true,
    label: 'Quận/Huyện',
    isColorFieldWhite: true,
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
    labelBold: true,
    label: 'Phường/Xã',
    isColorFieldWhite: true,
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
