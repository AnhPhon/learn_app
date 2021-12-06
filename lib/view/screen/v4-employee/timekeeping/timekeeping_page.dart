import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/screen/v4-employee/timekeeping/timekeeping_controller.dart';

class V4TimekeepingPage extends GetView<V4TimekeepingController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V4TimekeepingController>(
        init: V4TimekeepingController(),
        builder: (V4TimekeepingController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SafeArea(
              child: Scaffold(
                  appBar: const AppBarWidget(
                    title: "Thông tin chấm công",
                  ),
                  body: SingleChildScrollView(
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

                        //Chọn Tỉnh/TP và chọn Quận/Huyện
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SearchDropDownButton<TinhTpResponse>(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                                  vertical: Dimensions.PADDING_SIZE_LARGE - 2,
                                ),
                                label: "Tỉnh/Tp",
                                hint: "Chọn Tỉnh/Tp",
                                data: controller.tinhTps,
                                width: DeviceUtils.getScaledWidth(context, .45),
                                value: controller.tinh,
                                obligatory: true,
                                fillColor: ColorResources.WHITE,
                                isEnable: controller.tinhTps.isNotEmpty,
                                onChanged: (value) =>
                                    controller.tinhTps.isNotEmpty
                                        ? controller.onChangedTinhThanh(value!)
                                        : null,
                                highLightHint: controller.tinhTps.isNotEmpty,
                                smallSizeHintText: true,
                              ),
                              SearchDropDownButton<QuanHuyenResponse>(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                                  vertical: Dimensions.PADDING_SIZE_LARGE - 2,
                                ),
                                label: "Quận/Huyện",
                                hint: "Chọn Quận/Huyện",
                                data: controller.quanHuyenList,
                                width: DeviceUtils.getScaledWidth(context, .45),
                                value: controller.quanHuyen,
                                obligatory: true,
                                fillColor: ColorResources.WHITE,
                                isEnable: controller.quanHuyenList.isNotEmpty,
                                onChanged: (value) =>
                                    controller.quanHuyenList.isNotEmpty
                                        ? controller.onChangedQuanHuyen(value!)
                                        : null,
                                highLightHint: controller.tinhTps.isNotEmpty,
                                smallSizeHintText: true,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),

                        //Chọn Phường/Xã
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.MARGIN_SIZE_DEFAULT,
                          ),
                          child: SearchDropDownButton<PhuongXaResponse>(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL,
                              vertical: Dimensions.PADDING_SIZE_LARGE - 2,
                            ),
                            label: "Phường/Xã",
                            hint: "Chọn Phường/Xã",
                            data: controller.phuongXaList,
                            width: DeviceUtils.getScaledWidth(context, .45),
                            value: controller.phuongXa,
                            obligatory: true,
                            fillColor: ColorResources.WHITE,
                            isEnable: controller.phuongXaList.isNotEmpty,
                            onChanged: (value) =>
                                controller.phuongXaList.isNotEmpty
                                    ? controller.onChangedPhuongXa(value!)
                                    : null,
                            highLightHint: controller.tinhTps.isNotEmpty,
                            smallSizeHintText: true,
                          ),
                        ),

                        const SizedBox(
                          height: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),

                        Container(
                          height: DeviceUtils.getScaledHeight(context, .12),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_LARGE,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Expanded(
                                child: Text(
                                  "Ứng dụng cần cung cấp quyền vị trí để định vị vị trí chấm công chính xác theo dự án.",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: ColorResources.RED,
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),

                        _btnTimekeeping(controller),

                        const SizedBox(
                          height: Dimensions.PADDING_SIZE_LARGE,
                        ),
                      ],
                    ),
                  )),
            ),
          );
        });
  }

  ///
  /// Chọn thời gian chấm công
  ///
  Widget _timekeeping(
      V4TimekeepingController controller, BuildContext context) {
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
      hint: 'Địa điểm làm việc/văn phòng',
      label: 'Địa điểm làm việc/văn phòng',
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
      labelBold: true,
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
