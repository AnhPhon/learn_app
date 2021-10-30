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
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button_icon.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/cupertino_supreme/select_box_supreme.dart';
import 'package:template/view/screen/v2-builder/shorthanded/shorthanded_controller.dart';

class V2ShorthandedPage extends GetView<V2ShorthandedController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V2ShorthandedController>(
        init: V2ShorthandedController(),
        builder: (controller) {
          return Scaffold(
            appBar: const AppBarWidget(title: "Danh sách công việc"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //filter
                  _filter(context, controller: controller),

                  //item list
                  ListView.builder(
                      padding: const EdgeInsets.only(
                        top: Dimensions.PADDING_SIZE_SMALL,
                        left: Dimensions.PADDING_SIZE_SMALL,
                        right: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.shorthandedGroupList.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return ItemListWidget(
                          margin: const EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_SMALL,
                            bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            // right: Dimensions.PADDING_SIZE_SMALL,
                          ),
                          isSpaceBetween: true,
                          onTap: () => controller.onShorthandedGroup(index),
                          title: controller.shorthandedGroupList[index]['label'].toString(),
                          icon1: controller.shorthandedGroupList[index]['icon'] as Icon,
                          rowText1: controller.shorthandedGroupList[index]['location'].toString(),
                          rowText2: controller.shorthandedGroupList[index]['status'].toString(),
                          urlImage: '',
                        );
                      }),
                ],
              ),
            ),
          );
        });
  }

  ///
  ///filter
  ///
  Widget _filter(BuildContext context, {required V2ShorthandedController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectBoxSupreme<NhomDichVuResponse?>(
          items: controller.nhomDichVuResponse,
          onChanged: (val) {
            controller.selectedNhomCongViec(val as NhomDichVuResponse);
          },
          hint: "Chọn nhóm công việc",
        ),
        SelectBoxSupreme<LoaiCongViecResponse?>(
          items: controller.loaiCongViecResponse,
          onChanged: (val) {
            controller.selectedCongViecPhuHop(val as LoaiCongViecResponse);
          },
          hint: "Chọn công việc",
        ),
        Row(
          children: [
            Expanded(
              child: SelectBoxSupreme<TinhTpResponse?>(
                items: controller.tinhTpResponse,
                onChanged: (val) {
                  controller.selectedTinhThanhPho(val as TinhTpResponse);
                },
                hint: 'Tỉnh/TP',
              ),
            ),
            Expanded(
              child: SelectBoxSupreme<QuanHuyenResponse?>(
                items: controller.quanHuyenResponse,
                onChanged: (val) {
                  controller.selectedQuanHuyen(val as QuanHuyenResponse);
                },
                hint: 'Quận/Huyện',
              ),
            ),
            Expanded(
              child: SelectBoxSupreme<PhuongXaResponse?>(
                items: controller.phuongXaResponse,
                onChanged: (val) {
                  controller.selectedPhuongXa(val as PhuongXaResponse);
                },
                hint: 'Phường/Xã',
              ),
            ),
          ],
        ),
        GestureDetector(
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
      ],
    );
  }

  ///
  /// Button register
  ///
  Widget _buttonFilterWidget(BuildContext context) {
    return GestureDetector(
      // onOTPVerifierTap
      onTap: null,
      child: Container(
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
      ),
    );
  }
}
