import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/nhom_dich_vu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/getx_smart_refresh/getx_smart_refresh_page.dart';
import 'package:template/view/screen/v2-builder/shorthanded/shorthanded_controller.dart';

class V2ShorthandedPage extends GetView<V2ShorthandedController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedController>(
      init: V2ShorthandedController(),
      builder: (controller) {
        return Scaffold(
          appBar: const AppBarWidget(title: "Danh sách công việc"),
          body: Column(
            children: [
              //filter
              _filter(context, controller: controller),

              Expanded(
                child: controller.initLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GetXSmartRefreshPage(
                        key: const Key('GetXSmartRefreshV2ShorthandedPage'),
                        enablePullUp: true,
                        enablePullDown: true,
                        onLoading: controller.onLoading,
                        onRefresh: controller.onRefresh,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_SMALL,
                            left: Dimensions.PADDING_SIZE_SMALL,
                            right: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.donDichVuResponse!.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return ItemListWidget(
                              textOverImage: true,
                              stringTextOverImage: Validate.checkValueIsNullEmpty(controller.donDichVuResponse![index].idTinhTp) == true ? '' : controller.donDichVuResponse![index].idTinhTp.toString(),
                              margin: const EdgeInsets.only(
                                top: Dimensions.PADDING_SIZE_SMALL,
                                bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),
                              isSpaceBetween: true,
                              onTap: () => controller.onShorthandedGroup(index),
                              title: controller.donDichVuResponse![index].tieuDe.toString(),
                              icon1: const Icon(Icons.location_on),
                              rowText1: Validate.checkValueIsNullEmpty(controller.donDichVuResponse![index].idQuanHuyen) == true ? '' : controller.donDichVuResponse![index].idQuanHuyen.toString(),
                              rowText2: 'Đã duyệt',
                              // rowText2: controller.donDichVuResponse![index].idTrangThaiDonDichVu == null ? '' : controller.donDichVuResponse![index].idTrangThaiDonDichVu!.tieuDe.toString(),
                              urlImage: (Validate.checkValueIsNullEmpty(controller.donDichVuResponse![index]) == false && Validate.checkValueIsNullEmpty(controller.donDichVuResponse![index].idNhomDichVu) == false) ? controller.donDichVuResponse![index].idNhomDichVu!.hinhAnhDaiDien.toString() : '',
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  ///filter
  ///
  Widget _filter(BuildContext context, {required V2ShorthandedController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchDropDownButton<NhomDichVuResponse>(
          isColorFieldWhite: true,
          data: controller.nhomDichVuResponse ?? [],
          obligatory: true,
          onChanged: (value) => controller.selectedNhomCongViec(value),
          value: controller.currentNhomDichVuResponse,
          width: DeviceUtils.getScaledSize(context, 1),
          hint: 'Chọn nhóm công việc phù hợp',
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),
        SearchDropDownButton<LoaiCongViecResponse>(
          isColorFieldWhite: true,
          data: controller.loaiCongViecResponse ?? [],
          obligatory: true,
          isEnable: !Validate.checkValueIsNullEmpty(controller.currentNhomDichVuResponse!.id),
          onChanged: (value) => controller.selectedCongViecPhuHop(value),
          value: controller.currentLoaiCongViecResponse,
          width: DeviceUtils.getScaledSize(context, 1),
          hint: 'Chọn công việc phù hợp',
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),
        Row(
          children: [
            Expanded(
              child: SearchDropDownButton<TinhTpResponse>(
                isColorFieldWhite: true,
                data: controller.tinhTpResponse ?? [],
                obligatory: true,
                onChanged: (value) => controller.selectedTinhThanhPho(value),
                value: controller.currentTinhTpResponse,
                width: DeviceUtils.getScaledSize(context, 1),
                hint: 'Chọn Tỉnh/TP phù hợp',
                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
              ),
            ),
            Expanded(
              child: SearchDropDownButton<QuanHuyenResponse>(
                isColorFieldWhite: true,
                data: controller.quanHuyenResponse ?? [],
                obligatory: true,
                onChanged: (value) => controller.selectedQuanHuyen(value),
                value: controller.currentQuanHuyenResponse,
                width: DeviceUtils.getScaledSize(context, 1),
                isEnable: !Validate.checkValueIsNullEmpty(controller.currentTinhTpResponse.id),
                hint: 'Chọn Quận/Huyện phù hợp',
                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: SearchDropDownButton<PhuongXaResponse?>(
                isColorFieldWhite: true,
                data: controller.phuongXaResponse ?? [],
                obligatory: true,
                onChanged: (value) => controller.selectedPhuongXa(value),
                value: controller.currentPhuongXaResponse,
                width: DeviceUtils.getScaledSize(context, 1),
                isEnable: !(Validate.checkValueIsNullEmpty(controller.currentTinhTpResponse.id) || Validate.checkValueIsNullEmpty(controller.currentQuanHuyenResponse.id)),
                hint: 'Chọn Phường/Xã phù hợp',
                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT, right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.filterData();
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: Dimensions.PADDING_SIZE_SMALL,
                    left: Dimensions.PADDING_SIZE_SMALL,
                    right: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  child: _buttonFilterWidget(Get.context!),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///
  /// Button filter
  ///
  Widget _buttonFilterWidget(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, 1),
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 9,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.filter_alt_outlined,
            size: Dimensions.ICON_SIZE_DEFAULT,
            color: ColorResources.WHITE,
          ),
          Text(
            "Lọc",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "Nunito Sans",
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
