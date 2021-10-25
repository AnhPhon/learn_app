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
import 'package:template/view/basewidget/button/drop_down_button.dart';
import 'package:template/view/basewidget/button/drop_down_button_hide_under_line_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/create_work_controller.dart';

class CreateWorkPage extends GetView<CreateWorkController>{
  final CreateWorkController _controller = Get.put(CreateWorkController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: _controller.titleAppBar,),
      body: GetBuilder(
        builder: (CreateWorkController controller) {
          if(controller.isLoadingNhomDichVu || controller.isLoading){
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
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
          DropDownButton<NhomDichVuResponse>(
            data: controller.dichvu == null ? const [] : controller.nhomDichVuResponseList,
            obligatory: true,
            onChanged: (value) => controller.onChangedDichVu(value!),
            value: controller.dichvu,
            width: DeviceUtils.getScaledSize(context,1),
            label: "Chọn nhóm công việc phù hợp",
            hint: "Chọn nhóm công việc",
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          ),
          DropDownButton<LoaiCongViecResponse>(
            data: controller.loaiCongViecResponseList,
            obligatory: true,
            onChanged: (value)=> controller.onChangedLoaiCongViec(value!),
            value: controller.loaiCongViec,
            width: DeviceUtils.getScaledSize(context,1),
            label: "Chọn công việc phù hợp",
            hint: 'Chọn nhóm công việc',
            padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
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
                  onChangedHuyen: (QuanHuyenResponse? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaResponse? val)=> controller.onChangedPhuongXa(val!),
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
                  onChangedHuyen: (QuanHuyenResponse? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaResponse? val)=> controller.onChangedPhuongXa(val!),
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
                  onChangedHuyen: (QuanHuyenResponse? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaResponse? val)=> controller.onChangedPhuongXa(val!),
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
                  onChangedHuyen: (QuanHuyenResponse? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaResponse? val)=> controller.onChangedPhuongXa(val!),
                  phuong: controller.phuongXa,
                  huyen: controller.quanHuyen,
                  isRadio: false,
                  tinh: controller.tinh,
                  onChangedProvince: (TinhTpResponse? val)=> controller.onChangedTinhThanh(val!),
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
            DropDownButtonHideUnderLineWidget<TinhTpResponse>(
              data: tinhList!,
              onChanged: value == groupValue ?  (TinhTpResponse? val)=> onChangedProvince!(val): null,
              value: tinh,
              hint: "Chọn tỉnh khác",
              width: DeviceUtils.getScaledWidth(context, 0.83),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_LARGE* 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropDownButtonHideUnderLineWidget<QuanHuyenResponse>(
                data: district,
                onChanged: value == groupValue ?  (QuanHuyenResponse? val)=> onChangedHuyen(val): null,
                value: huyen,
                hint: "Quận/Huyện",
                width: DeviceUtils.getScaledWidth(context, 0.35),
              ),
              DropDownButtonHideUnderLineWidget<PhuongXaResponse>(
                data: ward,
                onChanged: value == groupValue ?  (PhuongXaResponse? val)=> onChangedPhuong(val) : null,
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
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: (){
          controller.onClickContinue();
        },
        title: "Tiếp tục",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
    );
  }

}