import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:template/data/model/response/mat_hang_dac_trung_response.dart';
import 'package:template/data/model/response/nhom_cua_hang_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button_hide_under_line_widget.dart';
import 'package:template/view/basewidget/button/drop_down_map_data_button.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/component_customer/btn_component.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
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
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //name company
                  InputWidget(
                    width: double.infinity,
                    label: "Tên doanh nghiệp (hoặc tên cá nhân)",
                    obligatory: true,
                    textEditingController: controller.nameController,
                    fillColor: ColorResources.WHITE,
                  ),

                  //legal Representative
                  InputWidget(
                    width: double.infinity,
                    label: "Người đại diện pháp lý (chủ doanh nghiệp/cá nhân)",
                    obligatory: true,
                    textEditingController:
                        controller.legalRepresentativeController,
                    fillColor: ColorResources.WHITE,
                  ),

                  //phone
                  InputWidget(
                    width: double.infinity,
                    label: "SĐT Zalo",
                    obligatory: true,
                    textEditingController: controller.phoneController,
                    fillColor: ColorResources.WHITE,
                  ),

                  //email
                  InputWidget(
                    width: double.infinity,
                    label: "Email",
                    obligatory: true,
                    textEditingController: controller.emailController,
                    fillColor: ColorResources.WHITE,
                  ),

                  //store group
                  DropDownButton1<NhomCuaHangResponse>(
                    label: "Chọn nhóm cửa hàng",
                    hint: "Chọn nhóm cửa hàng",
                    labelBold: true,
                    value: controller.nhomCuaHangResponse,
                    onChanged: (val) =>
                        controller.onSelectedNhomCuaHang(value: val!),
                    data: controller.nhomCuaHangList,
                    width: double.infinity,
                    obligatory: true,
                    fillColor: ColorResources.WHITE,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                  ),

                  //product special
                  const Label(
                      label: "Chọn mặt hàng đặc trưng", obligatory: true),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                    ),
                    child: MultiSelectDialogField<MatHangDacTrungResponse?>(
                      listType: MultiSelectListType.CHIP,
                      items: controller.matHangDacTrungList
                          .map((e) => MultiSelectItem(e, e!.tieuDe!))
                          .toList(),
                      title: const Text("Chọn mặt hàng đặc trưng"),
                      selectedColor: Colors.blue,
                      selectedItemsTextStyle:
                          const TextStyle(color: ColorResources.WHITE),
                      checkColor: ColorResources.WHITE,
                      buttonText: Text(
                        "Chọn mặt hàng đặc trưng",
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: (List<MatHangDacTrungResponse?> results) {
                        controller.matHangDacTrungResponse = results;
                      },
                    ),
                  ),

                  //store address
                  _storeAddress(context),

                  //address
                  InputWidget(
                    width: double.infinity,
                    label: "Địa chỉ cụ thể(số nhà, tên đường)",
                    obligatory: true,
                    textEditingController: controller.addressController,
                    fillColor: ColorResources.WHITE,
                  ),

                  //working hours in day
                  _workingHours(
                    context,
                    title: "Thời gian làm việc trong ngày",
                    isRequired: true,
                  ),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
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
                    width: double.infinity,
                    fillColor: ColorResources.WHITE,
                  ),

                  DropDownMapButton<String>(
                    label: "Chủ nhật có làm việc không?",
                    labelBold: true,
                    hint: "Chọn có hoặc không",
                    value: controller.taiKhoanResponse.lamNgayChuNhat,
                    onChanged: (val) =>
                        controller.onSelectedLamNgayChuNhat(value: val!),
                    data: controller.boolAccept,
                    width: double.infinity,
                    fillColor: ColorResources.WHITE,
                  ),

                  //note
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT,
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
                    itemCount: controller.tinhTpWarehouse.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      if (controller.isLoadingAdd &&
                          index == controller.warehouseList.length - 1) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return _warehouseAddress(context, index: index);
                    },
                  ),

                  //warehouse address add
                  _warehouseAddressAdd(context, controller: controller),

                  //image
                  _textTitle(context, title: "Hình ảnh cửa hàng"),

                  //uploadImage
                  _uploadImage(context, controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE * 2,
                  ),

                  //btn
                  _btnBottom(context, controller: controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),
                ],
              ),
            ),
          );
        });
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
        ),
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(
            "Tỉnh/Thành phố",
            style: TextStyle(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                fontWeight: FontWeight.w500),
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
                ward: controller.phuongXaList,
                city: "Hồ Chí Minh",
                district: controller.quanHuyenList,
                value: 0,
                groupValue: controller.groupTinhTpValue,
                onChanged: (int? val) => controller.onChangedGroup(val!),
                onChangedHuyen: (QuanHuyenResponse? val) =>
                    controller.onChangedQuanHuyen(val!),
                onChangedPhuong: (PhuongXaResponse? val) =>
                    controller.onChangedPhuongXa(val!),
                phuong: controller.phuongXaStore,
                huyen: controller.quanHuyenStore,
              ),
              onSelectedLocation(context,
                  ward: controller.phuongXaList,
                  city: "Hà Nội",
                  district: controller.quanHuyenList,
                  value: 1,
                  groupValue: controller.groupTinhTpValue,
                  onChanged: (int? val) => controller.onChangedGroup(val!),
                  onChangedHuyen: (QuanHuyenResponse? val) =>
                      controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaResponse? val) =>
                      controller.onChangedPhuongXa(val!),
                  phuong: controller.phuongXaStore,
                  huyen: controller.quanHuyenStore),
              onSelectedLocation(context,
                  ward: controller.phuongXaList,
                  city: "Đà Nẵng",
                  district: controller.quanHuyenList,
                  value: 2,
                  groupValue: controller.groupTinhTpValue,
                  onChanged: (int? val) => controller.onChangedGroup(val!),
                  onChangedHuyen: (QuanHuyenResponse? val) =>
                      controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaResponse? val) =>
                      controller.onChangedPhuongXa(val!),
                  phuong: controller.phuongXaStore,
                  huyen: controller.quanHuyenStore),
              onSelectedLocation(
                context,
                ward: controller.phuongXaList,
                city: "Tỉnh thành khách",
                district: controller.quanHuyenList,
                value: 3,
                groupValue: controller.groupTinhTpValue,
                onChanged: (int? val) => controller.onChangedGroup(val!),
                onChangedHuyen: (QuanHuyenResponse? val) =>
                    controller.onChangedQuanHuyen(val!),
                onChangedPhuong: (PhuongXaResponse? val) =>
                    controller.onChangedPhuongXa(val!),
                phuong: controller.phuongXaStore,
                huyen: controller.quanHuyenStore,
                isRadio: false,
                tinh: controller.tinhTpStore,
                onChangedProvince: (TinhTpResponse? val) =>
                    controller.onChangedTinhThanh(val!),
                tinhList: controller.tinhTpList,
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
              DropDownButton1<TinhTpResponse>(
                data: tinhList!,
                onChanged: value == groupValue
                    ? (TinhTpResponse? val) => onChangedProvince!(val)
                    : null,
                value: tinh,
                hint: "Chọn tỉnh khác",
                width: .83,
                isBorder: false,
              ),
            ],
          ),
        Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropDownButton1<QuanHuyenResponse>(
                data: district,
                onChanged: value == groupValue
                    ? (QuanHuyenResponse? val) => onChangedHuyen(val)
                    : null,
                value: huyen,
                hint: "Quận/Huyện",
                width: .35,
                isBorder: false,
              ),
              DropDownButton1<PhuongXaResponse>(
                data: ward,
                onChanged: value == groupValue
                    ? (PhuongXaResponse? val) => onChangedPhuong(val)
                    : null,
                value: phuong,
                hint: "Phường/xã",
                width: .35,
                isBorder: false,
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
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
          //title
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
                text: TextSpan(
              text: title,
              style: Dimensions.fontSizeStyle16().copyWith(
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
            height: Dimensions.MARGIN_SIZE_SMALL,
          ),

          // time range

          Row(
            children: [
              //start
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    Text(
                      "Từ",
                      style: Dimensions.fontSizeStyle18(),
                    ),
                    InputWidget(
                      width: .3,
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
                      Text(
                        "Đến",
                        style: Dimensions.fontSizeStyle18(),
                      ),
                      InputWidget(
                        width: .3,
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
    return GetBuilder<V3StoreInfomationController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Địa điểm kho hàng ${index + 1}",
                style: Dimensions.fontSizeStyle18w600().copyWith(
                  color: ColorResources.BLACK,
                ),
              ),
            ),

            const SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),

            //province
            DropDownButton1<TinhTpResponse?>(
              hint: "Tỉnh",
              onChanged: (value) =>
                  controller.onChangedTinhThanhIsWarehouse(value!, index),
              data: controller.tinhTpListIsWareHouse,
              value: controller.tinhTpWarehouse[index],
              width: .3,
              isBorder: false,
            ),

            const SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),

            //district & ward
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropDownButton1<QuanHuyenResponse?>(
                  hint: "Quận/huyện",
                  onChanged: (value) =>
                      controller.onChangedQuanHuyenIsWarehouse(value!, index),
                  data: controller.quanHuyenListIsWareHouse[index].isNotEmpty
                      ? controller.quanHuyenListIsWareHouse[index]
                      : [],
                  value: controller.quanHuyenListIsWareHouse[index].isNotEmpty
                      ? controller.quanHuyenWarehouse[index]
                      : null,
                  width: .35,
                  isBorder: false,
                ),
                DropDownButton1<PhuongXaResponse>(
                  hint: "Phường/xã",
                  onChanged: (value) =>
                      controller.onChangedPhuongXaIsWarehouse(value!, index),
                  data: controller.phuongXaListIsWareHouse[index].isNotEmpty
                      ? controller.phuongXaListIsWareHouse[index]
                      : [],
                  value: controller.phuongXaListIsWareHouse[index].isNotEmpty
                      ? controller.phuongXaWarehouse[index]
                      : null,
                  width: .35,
                  isBorder: false,
                ),
              ],
            ),

            const SizedBox(
              height: Dimensions.MARGIN_SIZE_DEFAULT,
            ),

            //warehouse address
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Địa chỉ cụ thể",
                  style: Dimensions.fontSizeStyle18(),
                ),
                const SizedBox(
                  width: Dimensions.MARGIN_SIZE_DEFAULT,
                ),
                InputWidget(
                  width: .5,
                  textEditingController: controller.warehouseController[index],
                ),
              ],
            ),
          ],
        ),
      );
    });
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
          onTap: () => controller.onClickWareHouseAdd(
              index: controller.warehouseList.length),
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
        const Text("Thêm địa điểm kho hàng"),
      ],
    );
  }

  ///
  ///text title
  ///
  Widget _textTitle(BuildContext context, {required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.PADDING_SIZE_LARGE + 2,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ///
  ///upload image
  ///
  Widget _uploadImage(
      BuildContext context, V3StoreInfomationController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: Dimensions.MARGIN_SIZE_DEFAULT),
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        border: Border.all(color: ColorResources.PRIMARY),
        borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
      ),
      height: DeviceUtils.getScaledHeight(context, .158),
      child: Align(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.fileImageList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: Dimensions.PADDING_SIZE_EXTRA_SMALL + 3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        child: Image.file(
                          controller.fileImageList[index],
                          fit: BoxFit.fill,
                          height: DeviceUtils.getScaledHeight(context, .122),
                          width: DeviceUtils.getScaledWidth(context, .254),
                        ),
                      ),
                    );
                  }),
              GestureDetector(
                onTap: () => controller.pickImage(),
                child: Image.asset(
                  Images.add_image,
                  height: DeviceUtils.getScaledHeight(context, .122),
                  width: DeviceUtils.getScaledWidth(context, .254),
                  fit: BoxFit.fill,
                  color: ColorResources.PRIMARY,
                ),
              ),
            ],
          ),
        ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BtnCustom(
            onTap: () {},
            color: ColorResources.GREY,
            text: "Chỉnh sửa",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
          const SizedBox(
            width: Dimensions.MARGIN_SIZE_LARGE,
          ),
          BtnCustom(
            onTap: () => controller.btnUpdate(context),
            color: ColorResources.PRIMARY,
            text: "Cập nhật",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
        ],
      ),
    );
  }
}
