import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/drop_down_button_hide_under_line_widget.dart';
import 'package:template/view/basewidget/button/dropdown_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/screen/v1-customer/component_customer/input_widget.dart';
import 'package:template/view/screen/v3-agent/component_agent/btn_component.dart';
import 'package:template/view/screen/v3-agent/store_infomation/store_infomation_controller.dart';

class V3StoreInfomationPage extends GetView<V3StoreInfomationController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<V3StoreInfomationController>(
        init: V3StoreInfomationController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarWidget(title: controller.title),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_LARGE,
                  ),

                  //name company
                  _titleTextField(
                    title: "Tên doanh nghiệp (hoặc tên cá nhân)",
                    textController: controller.nameController,
                    isRequired: true,
                  ),

                  //legal Representative
                  _titleTextField(
                    title: "Người đại diện pháp lý (chủ doanh nghiệp/cá nhân)",
                    textController: controller.legalRepresentativeController,
                    isRequired: true,
                  ),

                  //phone
                  _titleTextField(
                    title: "SĐT Zalo",
                    textController: controller.phoneController,
                    isRequired: true,
                  ),

                  //email
                  _titleTextField(
                    title: "Email",
                    textController: controller.emailController,
                    isRequired: false,
                  ),

                  //store group
                  DropDownButton<StoreGroup>(
                    hint: "Chọn nhóm cửa hàng",
                    value: controller.storeGroup!,
                    onChanged: controller.onSelectedStoreGroup,
                    data: controller.storeGroupList,
                    width: double.infinity,
                    label: "Chọn nhóm cửa hàng",
                    obligatory: true,
                    isColorFieldWhite: true,
                  ),

                  //product special
                  DropDownButton<ProductSpecial>(
                    hint: "Chọn nhóm cửa hàng",
                    value: controller.productSpecial!,
                    onChanged: (value) =>
                        controller.onProductSpecialGroup(value!),
                    data: controller.productSpecialList,
                    width: double.infinity,
                    label: "Chọn mặt hàng đặc trưng",
                    obligatory: true,
                    isColorFieldWhite: true,
                  ),

                  //store address
                  _storeAddress(context),

                  //address
                  _titleTextField(
                    title: "Địa chỉ cụ thể(số nhà, tên đường)",
                    textController: controller.addressController,
                    isRequired: false,
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
                  _titleDropDown(
                    controller,
                    title: "Chiều thứ 7 có làm việc không?",
                    isRequired: false,
                  ),
                  _titleDropDown(
                    controller,
                    title: "Chủ nhật có làm việc không?",
                    isRequired: false,
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

                  //warehouse address
                  _warehouseAddress(context),

                  //warehouse address add
                  _warehouseAddressAdd(),

                  //image
                  _textTitle(context, title: "Hình ảnh cửa hàng"),
                  _uploadImage(context, controller),

                  const SizedBox(
                    height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _btnBottom(context, controller),
          );
        });
  }

  ///
  ///title and textfield
  ///
  Widget _titleTextField(
      {required String title,
      required TextEditingController textController,
      required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
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
          InputWidget(
            textEditingController: textController,
            isColorFieldWhite: true,
          ),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_DEFAULT,
          ),
        ],
      ),
    );
  }

  ///
  /// store address
  ///
  Widget _storeAddress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_DEFAULT,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                text: "Địa điểm cửa hàng chính",
                style: Dimensions.fontSizeStyle18w600().copyWith(
                  color: ColorResources.BLACK,
                ),
                children: const [
                  TextSpan(
                    text: "*",
                    style: TextStyle(
                      color: ColorResources.RED,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: const Text(
              "Tỉnh/Thành phố:",
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
                onSelectedStoreAddress(context,
                    ward: ["Hoà Khánh", "Thanh Khê"],
                    city: "Hồ Chí Minh",
                    district: ["Quận 9", "Quận 8"],
                    value: 0),
                onSelectedStoreAddress(context,
                    ward: ["Hoà Khánh", "Thanh Khê"],
                    city: "Hà Nội",
                    district: ["Quận 9", "Quận 8"],
                    value: 1),
                onSelectedStoreAddress(context,
                    ward: ["Hoà Khánh", "Thanh Khê"],
                    city: "Đà Nẵng",
                    district: ["Quận 9", "Quận 8"],
                    value: 2),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///
  /// Radio button chon đia điểm cua hang
  ///
  Widget onSelectedStoreAddress(
    BuildContext context, {
    required List<String> district,
    required String city,
    required List<String> ward,
    required int value,
  }) {
    return Column(
      children: [
        RadioButton<int>(
          title: city,
          value: value,
          groupValue: 1,
          onChanged: (int? val) {},
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_EXTRA_LARGE * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropDownButtonHideUnderLineWidget<String>(
                data: district,
                onChanged: (val) {},
                value: "Quận 9",
                hint: "Quận/Huyện",
                width: DeviceUtils.getScaledWidth(context, 0.3),
              ),
              DropDownButtonHideUnderLineWidget<String>(
                data: ward,
                onChanged: (val) {},
                value: null,
                hint: "Phường/xã",
                width: DeviceUtils.getScaledWidth(context, 0.3),
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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Từ",
                      style: Dimensions.fontSizeStyle18(),
                    ),
                    const SizedBox(
                      width: Dimensions.MARGIN_SIZE_DEFAULT,
                    ),
                    SizedBox(
                      width: DeviceUtils.getScaledWidth(context, .3),
                      child: InputWidget(
                        textEditingController: controller.startController,
                        isTime: true,
                        allowEdit: false,
                      ),
                    )
                  ],
                ),
              ),

              //end
              Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Đến",
                        style: Dimensions.fontSizeStyle18(),
                      ),
                      const SizedBox(
                        width: Dimensions.MARGIN_SIZE_DEFAULT,
                      ),
                      SizedBox(
                        width: DeviceUtils.getScaledWidth(context, .3),
                        child: InputWidget(
                          textEditingController: controller.endController,
                          isTime: true,
                          allowEdit: false,
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///title and textfield
  ///
  Widget _titleDropDown(V3StoreInfomationController controller,
      {required String title, required bool isRequired}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Column(
        children: [
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
          DropDownButton1(
              hint: "Chọn có hoặc không",
              value: controller.acceptWork,
              onChanged: controller.onSelectedAcceptWork,
              data: const ["Có", "Không"]),
          const SizedBox(
            height: Dimensions.MARGIN_SIZE_DEFAULT,
          ),
        ],
      ),
    );
  }

  ///
  ///warehouse address
  ///
  Widget _warehouseAddress(BuildContext context) {
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
              "Địa điểm kho hàng 1",
              style: Dimensions.fontSizeStyle18w600().copyWith(
                color: ColorResources.BLACK,
              ),
            ),
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_DEFAULT,
          ),

          //province
          DropDownButtonHideUnderLineWidget<String>(
            hint: "Tỉnh",
            onChanged: (value) {},
            data: const ["Tỉnh"],
            value: null,
            width: DeviceUtils.getScaledWidth(context, .3),
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_DEFAULT,
          ),

          //district & ward
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropDownButtonHideUnderLineWidget<String>(
                hint: "Quận/huyện",
                onChanged: (value) {},
                data: const ["Quận"],
                value: null,
                width: DeviceUtils.getScaledWidth(context, .3),
              ),
              DropDownButtonHideUnderLineWidget<String>(
                hint: "Phường/xã",
                onChanged: (value) {},
                data: const ["Phường"],
                value: null,
                width: DeviceUtils.getScaledWidth(context, .3),
              ),
            ],
          ),

          const SizedBox(
            height: Dimensions.MARGIN_SIZE_DEFAULT,
          ),

          //warehouse address
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Địa chỉ cụ thể",
                style: Dimensions.fontSizeStyle18(),
              ),
              const SizedBox(
                width: Dimensions.MARGIN_SIZE_DEFAULT,
              ),
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, .55),
                child: InputWidget(
                  textEditingController: controller.warehouseController,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///warehouse address add
  ///
  Widget _warehouseAddressAdd() {
    return Column(
      children: [
        const SizedBox(
          height: Dimensions.MARGIN_SIZE_DEFAULT,
        ),
        Container(
          alignment: Alignment.center,
          decoration: const ShapeDecoration(
              color: ColorResources.GREY, shape: CircleBorder()),
          child: const Icon(
            Icons.add,
            size: Dimensions.ICON_SIZE_DEFAULT,
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
                  itemCount: controller.taxImageList.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: Dimensions.PADDING_SIZE_EXTRA_SMALL + 3),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.BORDER_RADIUS_EXTRA_SMALL),
                        child: Image.file(
                          controller.taxImageList[index],
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
  Widget _btnBottom(
      BuildContext context, V3StoreInfomationController controller) {
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
            onTap: () {},
            color: ColorResources.PRIMARY,
            text: "Cập nhật",
            width: DeviceUtils.getScaledWidth(context, .4),
          ),
        ],
      ),
    );
  }
}
