import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/hang_muc_xay_dung_model.dart';
import 'package:template/data/model/body/loai_cong_viec_model.dart';
import 'package:template/data/model/body/nhom_dich_vu_model.dart';
import 'package:template/data/model/body/phuong_xa_model.dart';
import 'package:template/data/model/body/quan_huyen_model.dart';
import 'package:template/data/model/body/tinh_tp_model.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/drop_down_button_hide_under_line_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/create_work_controller.dart';

class CreateWorkPage extends GetView<CreateWorkController>{
  // final CreateWorkController _controller = Get.put(CreateWorkController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: "Tạo đơn công việc",),
      body: GetBuilder(
        init: CreateWorkController(),
        builder: (CreateWorkController controller) {
          if(controller.isLoadingNhomDichVu ){
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nhóm công việc
                  workGroup(context, controller: controller),
          
                  // Địa điểm làm việc
                  workLocation(context, controller: controller),
          
                  // Nhập địa chỉ cụ thể
                  textField(context),
                  
                  // Button
                  button(controller),
                ],
              ),
            ),
          );
        },
      )
    );
  }


  ///
  /// Nhóm công việc
  ///
  Widget workGroup(BuildContext context, {required CreateWorkController controller}){
    return Column(
      children: [
          DropDownButton<NhomDichVuModel>(
            data: controller.dichvu == null ? const [] : controller.nhomDichVuModelList,
            obligatory: true,
            onChanged: (value) => controller.onChangedDichVu(value!),
            value: controller.dichvu,
            width: DeviceUtils.getScaledSize(context,1),
            label: "Chọn nhóm công việc phù hợp",
            hint: "Chọn nhóm công việc",
          ),
          // if (controller.loaiCongViec == null || controller.loaiCongViecModelList.isEmpty) 
          // DropDownButton<String>(
          //   data: const [],
          //   obligatory: true,
          //   onChanged: (cal){},
          //   value: "",
          //   width: DeviceUtils.getScaledSize(context,1),
          //   label: "Chọn công việc phù hợp",
          //   hint: 'Chọn nhóm công việc',
          // ) else 
          DropDownButton<LoaiCongViecModel>(
            data: controller.loaiCongViecModelList,
            obligatory: true,
            onChanged: (value)=> controller.onChangedLoaiCongViec(value!),
            value: controller.loaiCongViec,
            width: DeviceUtils.getScaledSize(context,1),
            label: "Chọn công việc phù hợp",
            hint: 'Chọn nhóm công việc',
          ),
      ],
    );
  }

  ///
  /// Địa điểm làm việc
  ///
  Widget workLocation(BuildContext context, {required CreateWorkController controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          const Label(
            label: "Địa điểm làm việc",
            obligatory: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
            child: Text("Tỉnh/Thành phố",style: TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              fontWeight: FontWeight.w500
            ),),
          ),
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              color: ColorResources.BLACK
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                onSelectedWorkLocation(
                  context,
                  ward: controller.phuongXaList,
                  city: "Hồ Chí Minh",
                  district: controller.quanHuyenList,
                  value: 0,
                  groupValue: controller.groupTinhTpValue,
                  onChanged: (int? val)=> controller.onChangedGroup(val!),
                  onChangedHuyen: (QuanHuyenModel? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaModel? val)=> controller.onChangedPhuongXa(val!),
                  phuong: controller.phuongXa,
                  huyen: controller.quanHuyen
                ),
                onSelectedWorkLocation(
                  context,
                  ward: controller.phuongXaList,
                  city: "Hà Nội",
                  district: controller.quanHuyenList,
                  value: 1,
                  groupValue: controller.groupTinhTpValue,
                  onChanged: (int? val)=> controller.onChangedGroup(val!),
                  onChangedHuyen: (QuanHuyenModel? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaModel? val)=> controller.onChangedPhuongXa(val!),
                  phuong: controller.phuongXa,
                  huyen: controller.quanHuyen
                ),
                onSelectedWorkLocation(
                  context,
                  ward: controller.phuongXaList,
                  city: "Đà Nẵng",
                  district: controller.quanHuyenList,
                  value: 2,
                  groupValue: controller.groupTinhTpValue,
                  onChanged: (int? val)=> controller.onChangedGroup(val!),
                  onChangedHuyen: (QuanHuyenModel? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaModel? val)=> controller.onChangedPhuongXa(val!),
                  phuong: controller.phuongXa,
                  huyen: controller.quanHuyen
                ),
                onSelectedWorkLocation(
                  context,
                  ward: controller.phuongXaList,
                  city: "Tỉnh thành khách",
                  district: controller.quanHuyenList,
                  value: 3,
                  groupValue: controller.groupTinhTpValue,
                  onChanged: (int? val)=> controller.onChangedGroup(val!),
                  onChangedHuyen: (QuanHuyenModel? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaModel? val)=> controller.onChangedPhuongXa(val!),
                  phuong: controller.phuongXa,
                  huyen: controller.quanHuyen,
                  isRadio: false,
                  tinh: controller.tinh,
                  onChangedProvince: (TinhTpModel? val)=> controller.onChangedTinhThanh(val!),
                  tinhList: controller.tinhTps
                ),
              ],
            ),
          )
      ],
    );
  }

  ///
  /// Radio button chon đia điểm làm việc
  ///
  Widget onSelectedWorkLocation(BuildContext context, {
    required List<QuanHuyenModel> district,
    required String city,
    required List<PhuongXaModel> ward,
    required int value,
    QuanHuyenModel? huyen,
    PhuongXaModel? phuong,
    required int groupValue,
    required Function(int? val) onChanged,
    required Function(QuanHuyenModel? val) onChangedHuyen,
    required Function(PhuongXaModel? val) onChangedPhuong,
    bool? isRadio = true,
    List<TinhTpModel>? tinhList,
    TinhTpModel? tinh,
    Function(TinhTpModel? val)? onChangedProvince,
    }){
    return Column(
      children: [
        if (isRadio!) RadioButton<int>(
          title: city,
          value: value,
          groupValue: groupValue,
          onChanged: (int? val)=> onChanged(val),
        ) else 
        Row(
          children: [
            RadioButton<int>(
              title: "",
              value: value,
              groupValue: groupValue,
              onChanged: (int? val)=> onChanged(val),
            ),
            DropDownButtonHideUnderLineWidget<TinhTpModel>(
              data: tinhList!,
              onChanged: value == groupValue ?  (TinhTpModel? val)=> onChangedProvince!(val): null,
              value: tinh,
              hint: "Chọn tỉnh",
              width: DeviceUtils.getScaledWidth(context, 0.83),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_LARGE* 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropDownButtonHideUnderLineWidget<QuanHuyenModel>(
                data: district,
                onChanged: value == groupValue ?  (QuanHuyenModel? val)=> onChangedHuyen(val): null,
                value: huyen,
                hint: "Quận/Huyện",
                width: DeviceUtils.getScaledWidth(context, 0.35),
              ),
              DropDownButtonHideUnderLineWidget<PhuongXaModel>(
                data: ward,
                onChanged: value == groupValue ?  (PhuongXaModel? val)=> onChangedPhuong(val) : null,
                value: phuong,
                hint: "Phường/xa",
                width: DeviceUtils.getScaledWidth(context, 0.35),
              ),
            ],
          ),
        )
      ],
    );
  }

  ///
  /// text field nhập địa chỉ cụ thể
  ///
  Widget textField(BuildContext context){
    return // Text field
    InputField(
      allowEdit: true,
      allowMultiline: false,
      controller: controller.addressController,
      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
      holdplacer: "123 Hoàng Thị Loan",
      hidden: false,
      label: "Địa chỉ cụ thể (số nhà, tên đường)",
      obligatory: true,
      typeInput: TextInputType.text,
      width: DeviceUtils.getScaledWidth(context,1),
    );
  }

  Widget button(CreateWorkController controller){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: (){
          controller.onClickContinue();
        },
        title: "Tiếp tục",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT
      ),
    );
  }

}