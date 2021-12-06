import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/gioi_tinh_model.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button_icon.dart';
import 'package:template/view/basewidget/button/search_drop_button_icon.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/candidate_controller.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/components/candicate_card.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/components/recruiment_news_card.dart';

class V1CandidatePage extends GetView<V1CandidateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(title: "Tuyển dụng ứng viên"),
        body: GetBuilder(
          builder: (V1CandidateController controller) {
            return SafeArea(
              child: Column(
                children: [
                  tabBarWidget(context: context, controller: controller),
                  if (controller.currentIndex == 0)
                    news(context, controller: controller, index: 0)
                  else
                    listOfCandidates(context, controller: controller, index: 1)
                ],
              ),
            );
          },
        ),
        floatingActionButton: GetBuilder(
          builder: (V1CandidateController controller) {
            return controller.currentIndex == 0
                ? FloatingActionButton.extended(
                    onPressed: controller.onClickFloatButton,
                    tooltip: "Tạo tin tuyển dụng",
                    backgroundColor: ColorResources.PRIMARYCOLOR,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 5,
                    label: const Text(
                      'Tạo tin',
                      style: TextStyle(
                          color: ColorResources.WHITE,
                          fontWeight: FontWeight.bold),
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: ColorResources.WHITE,
                    ),
                  )
                : Container();
          },
        ));
  }

  ///
  /// Tin tuyển dụng
  ///
  Widget news(BuildContext context,
      {required V1CandidateController controller, required int index}) {
    return Expanded(
      child: SmartRefresher(
        controller: controller.refreshTinTuyenDungController,
        scrollController: controller.scrollTinTuyenDungController,
        enablePullUp: true,
        onRefresh: controller.onRefreshTinTuyenDung,
        onLoading: controller.onLoadingTinTuyenDung,
        footer: const ClassicFooter(
          loadingText: "Đang tải...",
          noDataText: "Không có dữ liệu",
          canLoadingText: 'Đang tải...',
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (controller.isLoadingTuyenDung)
                const Padding(
                  padding:
                      EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.tuyenDungListModel.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => controller.onTapViewTuyenDung(
                          tuyendungModel: controller.tuyenDungListModel[index]),
                      child: RecruimentNewsCard(
                          tuyenDungResponse:
                              controller.tuyenDungListModel[index]),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Danh sách ứng tuyển
  ///
  Widget listOfCandidates(BuildContext context,
      {required V1CandidateController controller, required int index}) {
    return Expanded(
      child: SmartRefresher(
        controller: controller.refreshTimUngVienController,
        enablePullUp: true,
        scrollController: controller.scrollTimUngVienController,
        onLoading: controller.onLoading,
        onRefresh: controller.onRefresh,
        footer: const ClassicFooter(
          loadingText: "Đang tải...",
          noDataText: "Không có dữ liệu",
          canLoadingText: 'Đang tải...',
          idleText: "Vuốt lên tải thêm dữ liệu",
        ),
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // Tìm kiếm
              search(context, controller: controller),
              // Bộ lọc
              filter(context, controller: controller),
              // dánh sách ứng viên
              if (controller.isLoadingCadidate)
                const Padding(
                  padding:
                      EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )else if(controller.dangKyViecMoiListModel.isEmpty)
                   const Center(heightFactor: 10, child: Text("Không có dữ liệu"))
                
              else
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.dangKyViecMoiListModel.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            controller.onClickProfile(
                                dangKyViecMoiModel:
                                    controller.dangKyViecMoiListModel[index]);
                          },
                          child: CandidateCard(
                            dangKyViecMoiResponse:
                                controller.dangKyViecMoiListModel[index],
                            showEmailAndPass: false,
                          ));
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Khi chọn tab bar
  ///
  Widget onSelectedTab(BuildContext context,
      {required String title, required int index, required bool isLeft}) {
    return GestureDetector(
      onTap: () {
        controller.onChangeTab(index);
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: (DeviceUtils.getScaledWidth(context, 0.95).roundToDouble() / 2) -
            Dimensions.PADDING_SIZE_DEFAULT,
        decoration: BoxDecoration(
            color: index == controller.currentIndex
                ? ColorResources.PRIMARYCOLOR
                : ColorResources.WHITE,
            borderRadius: isLeft
                ? const BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                    bottomLeft:
                        Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT))
                : const BorderRadius.only(
                    topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                    bottomRight:
                        Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT)),
            ),
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: controller.currentIndex == index
                ? ColorResources.WHITE
                : ColorResources.GREY,
            fontSize: Dimensions.FONT_SIZE_LARGE,
          ),
        ),
      ),
    );
  }

  ///
  /// Thanh chọn tab
  ///
  Widget tabBarWidget(
      {required BuildContext context,
      required V1CandidateController controller}) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimensions.PADDING_SIZE_DEFAULT,
          left: Dimensions.PADDING_SIZE_DEFAULT,
          right: Dimensions.PADDING_SIZE_DEFAULT,
          bottom: Dimensions.PADDING_SIZE_DEFAULT),
      child: Container(
        alignment: Alignment.center,
        width: DeviceUtils.getScaledWidth(context, 1).roundToDouble(),
        height: 60,
        child: GetBuilder<V1CandidateController>(
          builder: (controller) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                onSelectedTab(context,
                    title: "Tin đăng tuyển", index: 0, isLeft: true),
                onSelectedTab(context,
                    title: "Danh sách ứng viên", index: 1, isLeft: false),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget search(BuildContext context,
      {required V1CandidateController controller}) {
    return Padding(
      padding: const EdgeInsets.all(
        Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, 0.75) - Dimensions.PADDING_SIZE_DEFAULT ,
            child: TextField(
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.top,
                controller: controller.searchController,
                onSubmitted: (val) => controller.onChangeTieuDe(val, context),
                focusNode: controller.searchFocusNode,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: () => controller.onChangeTieuDe(
                          controller.searchController.text, context),
                      child: const Icon(Icons.search)),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                      vertical: Dimensions.PADDING_SIZE_DEFAULT),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius:
                        BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius:
                        BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: ColorResources.PRIMARYCOLOR),
                    borderRadius:
                        BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                  ),
                  isDense: true,
                  hintText: "Tìm kiếm",
                  hintStyle: TextStyle(
                    color: ColorResources.BLACK.withOpacity(0.5),
                    fontSize: Dimensions.FONT_SIZE_LARGE,
                  ),
                )),
          ),
          GestureDetector(
            onTap: (){
              controller.clearSearch();
              DeviceUtils.unFocus(context);
            },
            child: Container(
              height: 49,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                color: ColorResources.RED.withOpacity(0.6),
              ),
              width: DeviceUtils.getScaledWidth(context,0.2) - Dimensions.PADDING_SIZE_DEFAULT ,
              child: const Text(
                "Xoá lọc",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Dimensions.FONT_SIZE_SMALL + 2,
                  fontWeight: FontWeight.w500,
                  color: ColorResources.WHITE
                ),
              )
            ),
          )
        ],
      ),
    );
  }

  ///
  ///Bộ lọc
  ///
  Widget filter(BuildContext context,
      {required V1CandidateController controller}) {
    return Container(
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        left: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Wrap(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  controller.showDialog();
                },
                child: DropDownButtonIcon<String>(
                  width: DeviceUtils.getScaledWidth(context, 0.25),
                  onChanged: (val) {},
                  data: const [],
                  icon: const Icon(
                    Icons.filter_alt_outlined,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  hint: "Lọc",
                  dropIcon: Container(),
                  style: const TextStyle(color: ColorResources.BLACK),
                ),
              ),
              SearchDropDownButtonIcon<TinhTpResponse>(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_SMALL),
                width: DeviceUtils.getScaledWidth(context, 0.7),
                onChanged: (TinhTpResponse? val) =>
                    controller.onChangeTinhTp(val!),
                data: controller.tinhTpListModel.isEmpty
                    ? const []
                    : controller.tinhTpListModel,
                value: controller.tinhTpResponse,
                icon: const Icon(
                  Icons.location_on,
                  size: Dimensions.ICON_SIZE_DEFAULT,
                ),
                hint: "Tỉnh/Tp",
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: Row(
              children: [
                SearchDropDownButtonIcon<LoaiCongViecResponse>(
                  width: DeviceUtils.getScaledWidth(context, 0.45),
                  onChanged: (LoaiCongViecResponse? val) =>
                      controller.onChangeChuyenMon(val!),
                  data: controller.chuyenMonListModel.isEmpty
                      ? const []
                      : controller.chuyenMonListModel,
                  value: controller.chuyenMonResponse,
                  icon: const Icon(
                    Icons.work,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  hint: "Chọn ngành nghề",
                ),
                DropDownButtonIcon<GioiTinhModel>(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL),
                  width: DeviceUtils.getScaledWidth(context, 0.45),
                  onChanged: (val) => controller.onChangedSex(val!),
                  data: controller.gioiTinhModel.isEmpty
                      ? const []
                      : controller.gioiTinhModel,
                  value: controller.gioiTinh,
                  icon: const Icon(
                    Icons.person,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  hint: "Giới tính",
                ),
              ],
            ),
          ),
          // Kinh nghiêm trình độ
          Padding(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            child: Row(
              children: [
                SearchDropDownButtonIcon<SoNamKinhNghiemResponse>(
                  width: DeviceUtils.getScaledWidth(context, 0.45),
                  onChanged: (SoNamKinhNghiemResponse? val) =>
                      controller.onChangeSoNamKinhNghiem(val!),
                  data: controller.soNamKinhNghiemListModel.isEmpty
                      ? const []
                      : controller.soNamKinhNghiemListModel,
                  value: controller.soNamKinhNghiemResponse,
                  icon: const Icon(
                    Icons.score,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  hint: "Kinh nghiệm",
                  isSort: false,
                ),
                SearchDropDownButtonIcon<TrinhDoHocVanResponse>(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL),
                  width: DeviceUtils.getScaledWidth(context, 0.5),
                  value: controller.trinhDoResponse,
                  onChanged: (TrinhDoHocVanResponse? val) =>
                      controller.onChangeTrinhDo(val!),
                  data: controller.trinhDoListModel.isEmpty
                      ? const []
                      : controller.trinhDoListModel,
                  icon: const Icon(
                    Icons.school_rounded,
                    size: Dimensions.ICON_SIZE_DEFAULT,
                  ),
                  hint: "Trình độ",
                  isSort: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
