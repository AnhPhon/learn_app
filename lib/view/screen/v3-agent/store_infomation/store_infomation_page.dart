import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:template/data/model/response/nhom_cua_hang_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_map_data_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/component/btn_component.dart';
import 'package:template/view/basewidget/component/btn_component_border.dart';
import 'package:template/view/basewidget/component/image_list_horizontal_add.dart';
import 'package:template/view/basewidget/component/input_widget.dart';
import 'package:template/view/basewidget/unfocus_textfield.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v3-agent/store_infomation/store_infomation_controller.dart';

class V3StoreInfomationPage extends GetView<V3StoreInfomationController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3StoreInfomationController>(
      init: V3StoreInfomationController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return UnFocusTextField(
          widget: Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //name company
                  InputWidget(
                    label: "Tên doanh nghiệp (hoặc tên cá nhân)",
                    labelBold: true,
                    obligatory: true,
                    textEditingController: controller.nameController,
                    fillColor: ColorResources.WHITE,
                    width: .95,
                    textInputAction: TextInputAction.next,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),

                  //legal Representative
                  InputWidget(
                    label: "Người đại diện pháp lý (chủ doanh nghiệp/cá nhân)",
                    labelBold: true,
                    obligatory: true,
                    textEditingController:
                        controller.legalRepresentativeController,
                    fillColor: ColorResources.WHITE,
                    width: .95,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),

                  //phone
                  InputWidget(
                    label: "SĐT Zalo",
                    labelBold: true,
                    textEditingController: controller.phoneController,
                    fillColor: ColorResources.GREY.withOpacity(.3),
                    allowEdit: false,
                    isBorder: false,
                    width: .95,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),

                  //email
                  InputWidget(
                    label: "Email",
                    labelBold: true,
                    textEditingController: controller.emailController,
                    fillColor: ColorResources.WHITE,
                    width: .95,
                    textInputType: TextInputType.emailAddress,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //store group
                  SearchDropDownButton<NhomCuaHangResponse>(
                    label: "Chọn nhóm cửa hàng",
                    hint: "Chọn nhóm cửa hàng",
                    data: controller.nhomCuaHangList,
                    width: DeviceUtils.getScaledWidth(context, .95),
                    value: controller.nhomCuaHangResponse,
                    obligatory: false,
                    isSort: false,
                    fillColor: ColorResources.WHITE,
                    isEnable: controller.nhomCuaHangList.isNotEmpty,
                    highLightHint: controller.nhomCuaHangList.isNotEmpty,
                    onChanged: controller.nhomCuaHangList.isNotEmpty
                        ? (val) => controller.onSelectedNhomCuaHang(value: val!)
                        : null,
                  ),

                  //product special
                  const Label(
                    label: "Chọn mặt hàng đặc trưng",
                    obligatory: true,
                    topPadding: Dimensions.PADDING_SIZE_DEFAULT,
                    horizontalPadding: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: MultiSelectDialogField<String?>(
                      searchable: true,
                      buttonIcon: const Icon(Icons.arrow_drop_down),
                      initialValue: controller.matHangDacTrungResponse,
                      listType: MultiSelectListType.LIST,
                      items: controller.matHangDacTrungList
                          .map((e) => MultiSelectItem<String?>(
                              e!.id!.toString(), e.tieuDe!))
                          .toList(),
                      title: const Text("Chọn mặt hàng đặc trưng"),
                      selectedColor: Colors.blue,
                      selectedItemsTextStyle:
                          const TextStyle(color: ColorResources.PRIMARY),
                      checkColor: ColorResources.WHITE,
                      buttonText: const Text(
                        "Chọn mặt hàng đặc trưng",
                        style: TextStyle(
                          color: ColorResources.BLACK,
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorResources.PRIMARY),
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        color: ColorResources.WHITE,
                      ),
                      onConfirm: (List<String?> results) {
                        controller.matHangDacTrungResponse = results;
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),

                  //store address
                  _storeAddress(context),

                  //address
                  InputWidget(
                    label: "Địa chỉ cụ thể(số nhà, tên đường)",
                    labelBold: true,
                    obligatory: true,
                    textEditingController: controller.addressController,
                    fillColor: ColorResources.WHITE,
                    width: .95,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //working hours in day
                  _workingHours(
                    context,
                    title: "Thời gian làm việc trong ngày",
                    isRequired: true,
                  ),

                  //accept work
                  DropDownMapButton<String>(
                    label: "Chiều thứ 7 có làm việc không?",
                    labelBold: true,
                    hint: "Chọn có hoặc không",
                    value: controller.taiKhoanResponse.lamChieuThuBay,
                    onChanged: (val) =>
                        controller.onSelectedLamChieuThuBay(value: val!),
                    data: controller.boolAccept,
                    width: .95,
                    fillColor: ColorResources.WHITE,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),

                  DropDownMapButton<String>(
                    label: "Chủ nhật có làm việc không?",
                    labelBold: true,
                    hint: "Chọn có hoặc không",
                    value: controller.taiKhoanResponse.lamNgayChuNhat,
                    onChanged: (val) =>
                        controller.onSelectedLamNgayChuNhat(value: val!),
                    data: controller.boolAccept,
                    width: .95,
                    fillColor: ColorResources.WHITE,
                    padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),

                  //note
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_DEFAULT,
                      horizontal: Dimensions.PADDING_SIZE_SMALL,
                    ),
                    child: Text(
                      controller.note,
                      textAlign: TextAlign.justify,
                      style: Dimensions.fontSizeStyle16(),
                    ),
                  ),

                  //warehouse address list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.khoHangModelList.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return _warehouseAddress(context, index: index);
                    },
                  ),

                  //warehouse address add
                  _warehouseAddressAdd(context, controller: controller),

                  //uploadImage
                  _uploadImage(context, controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),

                  //btn
                  _btnBottom(context, controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  /// store address
  ///
  Widget _storeAddress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label(
          label: "Địa điểm cửa hàng chính",
          obligatory: true,
          topPadding: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(
            "Tỉnh/Thành phố",
            style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        DefaultTextStyle(
          style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              color: ColorResources.BLACK),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              onSelectedLocation(
                context,
                ward: controller.phuongXasList,
                city: "TP Hồ Chí Minh",
                district: controller.quanHuyensList,
                value: 0,
                groupValue: controller.groupTinhTpValue,
                onChanged: (int? val) => controller.onChangedGroup(val!),
                onChangedHuyen: (QuanHuyenResponse? val) =>
                    controller.onChangedQuanHuyen(val!),
                onChangedPhuong: (PhuongXaResponse? val) =>
                    controller.onChangedPhuongXa(val!),
                phuong: controller.hcmPhuong,
                huyen: controller.hcmHuyen,
              ),
              onSelectedLocation(
                context,
                ward: controller.phuongXasList,
                city: "Hà Nội",
                district: controller.quanHuyensList,
                value: 1,
                groupValue: controller.groupTinhTpValue,
                onChanged: (int? val) => controller.onChangedGroup(val!),
                onChangedHuyen: (QuanHuyenResponse? val) =>
                    controller.onChangedQuanHuyen(val!),
                onChangedPhuong: (PhuongXaResponse? val) =>
                    controller.onChangedPhuongXa(val!),
                phuong: controller.haNoiPhuong,
                huyen: controller.haNoiHuyen,
              ),
              onSelectedLocation(
                context,
                ward: controller.phuongXasList,
                city: "Đà Nẵng",
                district: controller.quanHuyensList,
                value: 2,
                groupValue: controller.groupTinhTpValue,
                onChanged: (int? val) => controller.onChangedGroup(val!),
                onChangedHuyen: (QuanHuyenResponse? val) =>
                    controller.onChangedQuanHuyen(val!),
                onChangedPhuong: (PhuongXaResponse? val) =>
                    controller.onChangedPhuongXa(val!),
                phuong: controller.daNangPhuong,
                huyen: controller.daNangHuyen,
              ),
              onSelectedLocation(
                context,
                ward: controller.otherwards,
                city: "Tỉnh thành khác",
                district: controller.otherDistricts,
                value: 3,
                groupValue: controller.groupTinhTpValue,
                onChanged: (int? val) => controller.onChangedGroup(val!),
                onChangedHuyen: (QuanHuyenResponse? val) =>
                    controller.onChangedQuanHuyen(val!),
                onChangedPhuong: (PhuongXaResponse? val) =>
                    controller.onChangedPhuongXa(val!),
                phuong: controller.khacPhuong,
                huyen: controller.khacHuyen,
                isRadio: false,
                tinh: controller.otherProvince,
                onChangedProvince: (TinhTpResponse? val) =>
                    controller.onChangedTinhThanh(val!),
                tinhList: controller.otherProvinces,
              ),
            ],
          ),
        )
      ],
    );
  }

  ///
  /// Radio button chon đia điểm
  ///
  Widget onSelectedLocation(
    BuildContext context, {
    required List<QuanHuyenResponse> district,
    required String city,
    required List<PhuongXaResponse> ward,
    required int value,
    QuanHuyenResponse? huyen,
    PhuongXaResponse? phuong,
    required int groupValue,
    required Function(int? val) onChanged,
    required Function(QuanHuyenResponse? val) onChangedHuyen,
    required Function(PhuongXaResponse? val) onChangedPhuong,
    bool? isRadio = true,
    List<TinhTpResponse>? tinhList,
    TinhTpResponse? tinh,
    Function(TinhTpResponse? val)? onChangedProvince,
  }) {
    return Column(
      children: [
        if (isRadio!)
          RadioButton<int>(
            title: city,
            value: value,
            groupValue: groupValue,
            onChanged: (int? val) => onChanged(val),
          )
        else
          Row(
            children: [
              RadioButton<int>(
                title: "",
                value: value,
                groupValue: groupValue,
                onChanged: (int? val) => onChanged(val),
              ),
              SearchDropDownButton<TinhTpResponse>(
                hint: "Chọn tỉnh khác",
                data: tinhList!,
                width: DeviceUtils.getScaledWidth(context, .5),
                value: tinh,
                obligatory: false,
                isHideLineButton: true,
                highLightHint: value == groupValue,
                isEnable: value == groupValue,
                onChanged: value == groupValue
                    ? (TinhTpResponse? val) => onChangedProvince!(val)
                    : null,
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SearchDropDownButton<QuanHuyenResponse>(
                hint: "Quận/Huyện",
                data: district,
                width: DeviceUtils.getScaledWidth(context, .4),
                value: huyen,
                obligatory: false,
                isHideLineButton: true,
                highLightHint: value == groupValue,
                isEnable: (value == 3)
                    ? tinh != null && value == groupValue
                    : value == groupValue,
                onChanged: value == groupValue
                    ? (QuanHuyenResponse? val) => onChangedHuyen(val)
                    : null,
              ),
              SearchDropDownButton<PhuongXaResponse>(
                hint: "Phường/xã",
                data: ward,
                width: DeviceUtils.getScaledWidth(context, .4),
                value: phuong,
                obligatory: false,
                isHideLineButton: true,
                highLightHint: value == groupValue,
                isEnable:
                    value == groupValue && huyen != null && ward.isNotEmpty,
                onChanged: value == groupValue
                    ? (PhuongXaResponse? val) => onChangedPhuong(val)
                    : null,
              ),
            ],
          ),
        )
      ],
    );
  }

  ///
  ///working hours in day
  ///
  Widget _workingHours(BuildContext context,
      {required String title, required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_SMALL,
      ),
      child: Column(
        children: [
          //title
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(
              text: title,
              style: Dimensions.fontSizeStyle16w600().copyWith(
                color: ColorResources.BLACK,
              ),
              children: isRequired == true
                  ? [
                      const TextSpan(
                        text: "*",
                        style: TextStyle(
                          color: ColorResources.RED,
                        ),
                      )
                    ]
                  : [],
            )),
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
          ),

          // time range

          Row(
            children: [
              //start
              Expanded(
                flex: 5,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //label
                    Text(
                      "Từ",
                      style: Dimensions.fontSizeStyle16w600(),
                    ),

                    const SizedBox(
                      width: Dimensions.MARGIN_SIZE_SMALL,
                    ),

                    //filed
                    InputWidget(
                      height: .06,
                      width: .35,
                      textEditingController: controller.startController,
                      isTime: true,
                      allowEdit: false,
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                      fillColor: ColorResources.WHITE,
                    ),
                  ],
                ),
              ),

              //end
              Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //label
                      Text(
                        "Đến",
                        style: Dimensions.fontSizeStyle16w600(),
                      ),

                      const SizedBox(
                        width: Dimensions.MARGIN_SIZE_SMALL,
                      ),

                      //filed
                      InputWidget(
                        height: .06,
                        width: .35,
                        textEditingController: controller.endController,
                        isTime: true,
                        allowEdit: false,
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                        fillColor: ColorResources.WHITE,
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///warehouse address
  ///
  Widget _warehouseAddress(BuildContext context, {required int index}) {
    return GetBuilder<V3StoreInfomationController>(
      builder: (controller) {
        if (controller.isLoadingAdd &&
            index == controller.khoHangModelList.length - 1) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.isLoadingWarehouse) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorResources.LIGHT_SKY_BLUE),
            borderRadius:
                BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
          ),
          margin: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL,
          ),
          padding: const EdgeInsets.only(
            top: Dimensions.PADDING_SIZE_DEFAULT,
            bottom: Dimensions.PADDING_SIZE_DEFAULT,
            left: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_SMALL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //label
                  Label(
                    label: "Địa điểm kho hàng ${index + 1}",
                    obligatory: false,
                    topPadding: 0,
                    horizontalPadding: 0,
                  ),

                  //btn remove
                  GestureDetector(
                    onTap: () {
                      if (controller.khoHangModelList[index].idKhoHang !=
                          null) {
                        // Get.dialog(
                        //   _deleteItem(context,
                        //       index: index, controller: controller),
                        // );
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Dialog(
                                    child: _deleteItem(
                                      context,
                                      index: index,
                                      controller: controller,
                                    ),
                                  ),
                                ],
                              );
                            });
                      } else {
                        controller.onDeleteWarehouse(index: index);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.RED,
                        border: Border.all(color: ColorResources.WHITE),
                      ),
                      child: const Icon(
                        Icons.close_outlined,
                        size: Dimensions.ICON_SIZE_SMALL,
                        color: ColorResources.WHITE,
                      ),
                    ),
                  ),
                ],
              ),

              //province
              SearchDropDownButton<TinhTpResponse>(
                hint: "Tỉnh",
                data: controller.khoHangModelList[index].tinhTpList!,
                width: DeviceUtils.getScaledWidth(context, .4),
                value: controller.khoHangModelList[index].tinhTpResponse,
                obligatory: false,
                isHideLineButton: true,
                isEnable: controller.khoHangModelList[index].tinhTpList !=
                        null &&
                    controller.khoHangModelList[index].tinhTpList!.isNotEmpty,
                highLightHint: controller.khoHangModelList[index].tinhTpList !=
                        null &&
                    controller.khoHangModelList[index].tinhTpList!.isNotEmpty,
                onChanged: (value) =>
                    controller.onChangedTinhThanhIsWarehouse(value!, index),
              ),

              //district & ward
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchDropDownButton<QuanHuyenResponse>(
                    hint: "Quận/huyện",
                    data: controller.khoHangModelList[index].quanHuyenList!,
                    width: DeviceUtils.getScaledWidth(context, .4),
                    value: controller.khoHangModelList[index].quanHuyenResponse,
                    obligatory: false,
                    isHideLineButton: true,
                    isEnable:
                        controller.khoHangModelList[index].tinhTpResponse !=
                                null &&
                            controller.khoHangModelList[index].quanHuyenList!
                                .isNotEmpty,
                    highLightHint:
                        controller.khoHangModelList[index].tinhTpResponse !=
                                null &&
                            controller.khoHangModelList[index].quanHuyenList!
                                .isNotEmpty,
                    onChanged: (value) =>
                        controller.onChangedQuanHuyenIsWarehouse(value!, index),
                  ),
                  SearchDropDownButton<PhuongXaResponse>(
                    hint: "Phường/xã",
                    data: controller.khoHangModelList[index].phuongXaList!,
                    value: controller.khoHangModelList[index].phuongXaResponse,
                    width: DeviceUtils.getScaledWidth(context, .4),
                    obligatory: false,
                    isHideLineButton: true,
                    isEnable:
                        controller.khoHangModelList[index].quanHuyenResponse !=
                                null &&
                            controller.khoHangModelList[index].phuongXaList!
                                .isNotEmpty,
                    highLightHint:
                        controller.khoHangModelList[index].tinhTpResponse !=
                            null,
                    onChanged: (value) =>
                        controller.onChangedPhuongXaIsWarehouse(value!, index),
                  ),
                ],
              ),

              //warehouse address
              Row(
                children: [
                  //title
                  Text(
                    "Địa chỉ cụ thể",
                    style: Dimensions.fontSizeStyle16w600(),
                  ),

                  const SizedBox(
                    width: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //input
                  Expanded(
                    child: InputWidget(
                      height: .06,
                      width: double.infinity,
                      textEditingController:
                          controller.khoHangModelList[index].warehouseAddress!,
                      textInputAction: TextInputAction.next,
                      fillColor: ColorResources.WHITE,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: Dimensions.MARGIN_SIZE_DEFAULT,
              ),

              //warehouse name
              Row(
                children: [
                  //title
                  Text(
                    "Tên kho hàng",
                    style: Dimensions.fontSizeStyle16w600(),
                  ),

                  const SizedBox(
                    width: Dimensions.MARGIN_SIZE_DEFAULT,
                  ),

                  //input
                  Expanded(
                    child: InputWidget(
                      height: .06,
                      width: double.infinity,
                      textEditingController:
                          controller.khoHangModelList[index].warehouseName!,
                      fillColor: ColorResources.WHITE,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  ///delete
  ///
  Widget _deleteItem(
    BuildContext context, {
    required int index,
    required V3StoreInfomationController controller,
  }) {
    return Center(
      child: Container(
        // height: DeviceUtils.getScaledHeight(context, .35),
        // margin: const EdgeInsets.symmetric(
        //   horizontal: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
        // ),
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //title
            const Text(
              "Xác nhận",
              style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(
              color: ColorResources.GREY,
            ),

            //note
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: "Xoá kho hàng sẽ xoá hết tất cả các",
                style: TextStyle(
                  color: ColorResources.BLACK,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                ),
                children: [
                  TextSpan(
                    text: " sản phẩm ",
                    style: TextStyle(
                      color: ColorResources.RED,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                    ),
                  ),
                  TextSpan(
                    text:
                        "thuộc kho hàng này. Bạn có chắc chắn muốn xoá kho hàng không?",
                    style: TextStyle(
                      color: ColorResources.BLACK,
                      fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: Dimensions.MARGIN_SIZE_LARGE,
            ),

            //btn
            Row(
              children: [
                //accept
                Expanded(
                  child: BtnCustomBorder(
                    onTap: () {
                      controller.onDeleteWarehouse(index: index);
                      Get.back();
                    },
                    text: "Đồng ý",
                    width: double.infinity,
                  ),
                ),

                const SizedBox(
                  width: Dimensions.MARGIN_SIZE_SMALL,
                ),

                //cancel
                Expanded(
                  child: BtnCustom(
                    onTap: () => Get.back(),
                    color: ColorResources.PRIMARY,
                    text: "Huỷ",
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  ///warehouse address add
  ///
  Widget _warehouseAddressAdd(BuildContext context,
      {required V3StoreInfomationController controller}) {
    return Column(
      children: [
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
        GestureDetector(
          onTap: () => controller.onClickWareHouseAdd(),
          child: Container(
            alignment: Alignment.center,
            decoration: const ShapeDecoration(
                color: ColorResources.GREY, shape: CircleBorder()),
            child: const Icon(
              Icons.add,
              size: Dimensions.ICON_SIZE_DEFAULT,
            ),
          ),
        ),
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_SMALL,
        ),
        Text(
          "Thêm địa điểm kho hàng",
          style: Dimensions.fontSizeStyle16w600(),
        ),
      ],
    );
  }

  ///
  ///upload image
  ///
  Widget _uploadImage(
    BuildContext context, {
    required V3StoreInfomationController controller,
  }) {
    return ImageListHorizontalAdd(
      label: "Hình ảnh cửa hàng",
      labelBold: true,
      pickImage: () => controller.pickImages(),
      imageFileList: controller.taiKhoanRequest.hinhAnhCuaHangs ?? [],
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_DEFAULT,
        horizontal: Dimensions.PADDING_SIZE_SMALL,
      ),
    );
  }

  ///
  ///btn bottom
  ///
  Widget _btnBottom(BuildContext context,
      {required V3StoreInfomationController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
      child: BtnCustom(
        onTap: () => controller.btnUpdate(context),
        color: ColorResources.PRIMARY,
        text: "Cập nhật",
        width: DeviceUtils.getScaledWidth(context, .95),
      ),
    );
  }
}
