import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/chuyen_nganh_chinh_response.dart';
import 'package:template/data/model/response/gioi_tinh_model.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button_icon.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/recruiment_news_card.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/recruitment/search_recruitment_controller.dart';

class V2SearchRecruitmentPage extends GetView<V2SearchRecruitmentController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: V2SearchRecruitmentController(),
      builder: (V2SearchRecruitmentController controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBarWidget(
            title: "Tìm kiếm tin tuyển dụng",
            action: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.history),
                    color: ColorResources.WHITE,
                    onPressed: () {
                      controller.onClickHistory();
                    },
                  ),
                ],
              )
            ],
          ),
          body: SafeArea(
              child: Column(
            children: [
              filter(context, controller: controller),
              recruitment(context, controller: controller)
            ],
          )),
        );
      },
    );
  }

  

  Widget recruitment(BuildContext context,
      {required V2SearchRecruitmentController controller}) {
    return Expanded(
      child: SmartRefresher(
        controller: controller.refreshTinTuyenDungController,
        enablePullUp: true,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        footer: const ClassicFooter(
          loadingText: "Đang tải...",
          noDataText: "Không có dữ liệu",
          canLoadingText: "Kéo lên để tải thêm dữ liệu",
        ),
        child: ListView.builder(
                itemCount: controller.tuyenDungListModel.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        controller.onClickRecruitmentNews();
                      },
                      child: V2RecruimentNewsCard(
                        tuyenDungResponse: controller.tuyenDungListModel[index],
                      ),
                    );
                },
              ),
      ),
    );
  }



  ///
  ///Bộ lọc
  ///
  Widget filter(BuildContext context,
      {required V2SearchRecruitmentController controller}) {
    return Container(
      padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          // search tiêu đề
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, 0.9),
            child: TextField(
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.top,
                controller: controller.tieuDeController,
                onSubmitted: (val) => {},
                focusNode: controller.tieuDeFocusNode,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      // onTap: () => controller.onChangeTieuDe(
                      //     controller.searchController.text, context),
                      child: const Icon(Icons.search)),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                      vertical: Dimensions.PADDING_SIZE_DEFAULT),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius: BorderRadius.circular(
                        Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  isDense: true,
                  hintText: "Vị trí tuyển dụng",
                  hintStyle: TextStyle(
                    color: ColorResources.BLACK.withOpacity(0.5),
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                )),
          ),
          //search công ty
          Container(
              width: DeviceUtils.getScaledWidth(context, 1),
              padding:
                  const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: DeviceUtils.getScaledWidth(context, 0.52),
                    child: TextField(
                        textInputAction: TextInputAction.go,
                        keyboardType: TextInputType.text,
                        textAlignVertical: TextAlignVertical.top,
                        controller: controller.congTyController,
                        onSubmitted: (val) => {},
                        focusNode: controller.congTyFocusNode,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              // onTap: () => controller.onChangeTieuDe(
                              //     controller.searchController.text, context),
                              child: const Icon(Icons.search)),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL,
                              vertical: Dimensions.PADDING_SIZE_DEFAULT),
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
                          isDense: true,
                          hintText: "Tên công ty",
                          hintStyle: TextStyle(
                            color: ColorResources.BLACK.withOpacity(0.5),
                            fontSize: Dimensions.FONT_SIZE_LARGE,
                          ),
                        )),
                  ),
                  DropDownButtonIcon<GioiTinhModel>(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    width: DeviceUtils.getScaledWidth(context, 0.35),
                    onChanged: (GioiTinhModel? val) =>
                        controller.onChangedSex(val!),
                    data: controller.gioiTinhModel.isNotEmpty
                        ? controller.gioiTinhModel
                        : [],
                    value: controller.gioiTinh,
                    icon: const Icon(
                      Icons.person,
                      size: Dimensions.ICON_SIZE_DEFAULT,
                    ),
                    hint: "Giới tính",
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDownButtonIcon<TinhTpResponse>(
                  width: DeviceUtils.getScaledWidth(context, 0.35),
                  onChanged: (TinhTpResponse? val) =>
                      controller.onChangeTinhTp(val!),
                  data: controller.tinhTpListModel.isNotEmpty
                      ? controller.tinhTpListModel
                      : [],
                  value: controller.noiLamViec,
                  icon: const Icon(
                    Icons.location_city,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  hint: "Tỉnh/Tp",
                ),
                DropDownButtonIcon<ChuyenNganhChinhResponse>(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL),
                  width: DeviceUtils.getScaledWidth(context, 0.5),
                  onChanged: (ChuyenNganhChinhResponse? val) =>
                      controller.onChangeChuyenNganhChinh(val!),
                  data: controller.chuyenNganhChinhListModel.isNotEmpty
                      ? controller.chuyenNganhChinhListModel
                      : [],
                  value: controller.chuyenNganhChinh,
                  icon: const Icon(
                    Icons.card_travel_sharp,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  hint: "Ngành nghề",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDownButtonIcon<MucLuongDuKienResponse>(
                  width: DeviceUtils.getScaledWidth(context, 0.43),
                  onChanged: (MucLuongDuKienResponse? val) =>
                      controller.onChangeMucLuongDuKien(val!),
                  data: controller.mucLuongDuKienListModel.isNotEmpty
                      ? controller.mucLuongDuKienListModel
                      : [],
                  value: controller.mucLuongDuKien,
                  icon: const Icon(
                    Icons.attach_money,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  hint: "Mức lương",
                ),
                DropDownButtonIcon<TrinhDoHocVanResponse>(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL),
                  width: DeviceUtils.getScaledWidth(context, 0.43),
                  onChanged: (TrinhDoHocVanResponse? val) =>
                      controller.onChangeTrinhDoHocVan(val!),
                  data: controller.trinhDoHocVanListModel.isNotEmpty
                      ? controller.trinhDoHocVanListModel
                      : [],
                  value: controller.trinhDoHocVan,
                  icon: const Icon(
                    Icons.school_rounded,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  hint: "Trình độ",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_SMALL,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDownButtonIcon<SoNamKinhNghiemResponse>(
                  width: DeviceUtils.getScaledWidth(context, 0.43),
                  onChanged: (SoNamKinhNghiemResponse? val) =>
                      controller.onChangeSoNamKinhNghiem(val!),
                  data: controller.soNamKinhNghiemListModel.isNotEmpty
                      ? controller.soNamKinhNghiemListModel
                      : [],
                  value: controller.soNamKinhNghiem,
                  icon: const Icon(
                    Icons.score,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  hint: "Kinh nghiệm",
                ),
                DropDownButtonIcon<HinhThucLamViecResponse>(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL),
                  width: DeviceUtils.getScaledWidth(context, 0.43),
                  onChanged: (HinhThucLamViecResponse? val) =>
                      controller.onChangeHinhThucLamViec(val!),
                  data: controller.hinhThucLamViecListModel.isNotEmpty
                      ? controller.hinhThucLamViecListModel
                      : [],
                  value: controller.hinhThucLamViec,
                  icon: const Icon(
                    Icons.timeline_sharp,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  hint: "Hình thức",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
