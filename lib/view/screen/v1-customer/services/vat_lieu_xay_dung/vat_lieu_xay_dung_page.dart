import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/response/loai_cong_trinh_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/view/basewidget/appbar/app_bar_widget.dart';
import 'package:template/view/basewidget/button/attach_button.dart';
import 'package:template/view/basewidget/button/drop_down_button_hide_under_line_widget.dart';
import 'package:template/view/basewidget/button/long_button.dart';
import 'package:template/view/basewidget/button/radio_button.dart';
import 'package:template/view/basewidget/button/search_drop_down_button.dart';
import 'package:template/view/basewidget/textfield/input_field.dart';
import 'package:template/view/basewidget/textfield/text_field_date.dart';
import 'package:template/view/basewidget/widgets/box_image.dart';
import 'package:template/view/basewidget/widgets/label.dart';
import 'package:template/view/screen/v1-customer/services/components/material_card.dart';
import 'package:template/view/screen/v1-customer/services/vat_lieu_xay_dung/vat_lieu_xay_dung_controller.dart';

class V1VatLieuXayDungPage extends GetView<V1VatLieuXayDungController>{
  final V1VatLieuXayDungController _controller = Get.put(V1VatLieuXayDungController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const AppBarWidget(title: 'Yêu cầu báo giá vật tư',),
        body: GetBuilder(
          builder: (V1VatLieuXayDungController controller) {
            if(controller.isLoading || controller.isLoadingCongTrinh || controller.isLoadingVatTu){
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
    
                    // THời gian nhận vật tư dự kiến
                    recieveTime(context, controller: controller),
    
                    // Vật tư
                    vatTuWidget(context, controller: controller),
                    
                    // Button
                    button(context, controller: controller),
                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }


  ///
  /// Nhóm công việc
  ///
  Widget workGroup(BuildContext context, {required V1VatLieuXayDungController controller}){
    return Column(
      children: [
          InputField(
            allowEdit: true,
            allowMultiline: false,
            controller: controller.titleController,
            fontSize: Dimensions.FONT_SIZE_LARGE,
            holdplacer: "Báo giá vật liệu xây dựng",
            hidden: false,
            label: "Tiêu đề báo giá",
            obligatory: true,
            textInputAction: TextInputAction.next,
            typeInput: TextInputType.text,
            width: DeviceUtils.getScaledWidth(context,1),
          ),
          SearchDropDownButton<LoaiCongTrinhResponse>(
            data: controller.LoaiCongTrinhResponseList,
            obligatory: true,
            onChanged: (value)=> controller.onChangedLoaiCongTrinh(value!),
            value: controller.loaiCongTrinh,
            width: DeviceUtils.getScaledSize(context,1),
            label: "Chọn loại công trình",
            hint: 'Chọn loại công trình phù hợp',
            padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
          ),
      ],
    );
  }

  ///
  /// Địa điểm làm việc
  ///
  Widget workLocation(BuildContext context, {required V1VatLieuXayDungController controller}){
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
                  ward: controller.hcmWards,
                  city: "Hồ Chí Minh",
                  district: controller.hcmDistricts,
                  value: 0,
                  groupValue: controller.groupTinhTpValue,
                  onChanged: (int? val)=> controller.onChangedGroup(val!),
                  onChangedHuyen: (QuanHuyenResponse? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaResponse? val)=> controller.onChangedPhuongXa(val!),
                  phuong: controller.hcmPhuong,
                  huyen: controller.hcmHuyen
                ),
                onSelectedWorkLocation(
                  context,
                  ward: controller.hnWards,
                  city: "Hà Nội",
                  district: controller.hnDistricts,
                  value: 1,
                  groupValue: controller.groupTinhTpValue,
                  onChanged: (int? val)=> controller.onChangedGroup(val!),
                  onChangedHuyen: (QuanHuyenResponse? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaResponse? val)=> controller.onChangedPhuongXa(val!),
                  phuong: controller.haNoiPhuong,
                  huyen: controller.haNoiHuyen
                ),
                onSelectedWorkLocation(
                  context,
                  ward: controller.dnWards,
                  city: "Đà Nẵng",
                  district: controller.dnDistricts,
                  value: 2,
                  groupValue: controller.groupTinhTpValue,
                  onChanged: (int? val)=> controller.onChangedGroup(val!),
                  onChangedHuyen: (QuanHuyenResponse? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaResponse? val)=> controller.onChangedPhuongXa(val!),
                  phuong: controller.daNangPhuong,
                  huyen: controller.daNangHuyen
                ),
                onSelectedWorkLocation(
                  context,
                  ward: controller.otherwards,
                  city: "Tỉnh thành khác",
                  district: controller.otherDistricts,
                  value: 3,
                  groupValue: controller.groupTinhTpValue,
                  onChanged: (int? val)=> controller.onChangedGroup(val!),
                  onChangedHuyen: (QuanHuyenResponse? val)=> controller.onChangedQuanHuyen(val!),
                  onChangedPhuong: (PhuongXaResponse? val)=> controller.onChangedPhuongXa(val!),
                  phuong: controller.khacPhuong,
                  huyen: controller.khacHuyen,
                  isRadio: false,
                  tinh: controller.otherProvince,
                  onChangedProvince: (TinhTpResponse? val)=> controller.onChangedTinhThanh(val!),
                  tinhList: controller.otherProvinces,
                  isTinhKhac: true
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
    bool? isTinhKhac = false,
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
            SearchDropDownButton<TinhTpResponse>(
              obligatory: false,
              isHideLineButton: true,
              isEnable: groupValue == 3,
              data: tinhList!,
              onChanged: value == groupValue ?  (TinhTpResponse? val)=> onChangedProvince!(val): null,
              value: tinh ?? TinhTpResponse(ten: 'Chọn tỉnh khác'),
              hint: "Chọn tỉnh khác",
              width: DeviceUtils.getScaledWidth(context, 0.43),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_LARGE* 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if(isTinhKhac!)
              SearchDropDownButton<QuanHuyenResponse>(
                obligatory: false,
                isHideLineButton: true,
                isEnable: groupValue == 3,
                data: controller.isLoadingDistrict ? [] : district,
                onChanged: value == groupValue ?  (QuanHuyenResponse? val)=> onChangedHuyen(val): null,
                value: huyen,
                highLightHint: groupValue == value,
                hint: "Quận/huyện",
                width: DeviceUtils.getScaledWidth(context, 0.4),
              )else
              DropDownButtonHideUnderLineWidget<QuanHuyenResponse>(
                data: controller.isLoadingDistrict ? [] : district,
                onChanged: value == groupValue ?  (QuanHuyenResponse? val)=> onChangedHuyen(val): null,
                value: huyen,
                hint: "Quận/huyện",
                highLightHint: groupValue == value,
                width: DeviceUtils.getScaledWidth(context, 0.35),
              ),
              if(isTinhKhac)
              SearchDropDownButton<PhuongXaResponse>(
                obligatory: false,
                isHideLineButton: true,
                isEnable: groupValue == 3,
                data: controller.isLoadingWard ? [] : ward,
                onChanged: value == groupValue ?  (PhuongXaResponse? val)=> onChangedPhuong(val) : null,
                value: phuong,
                highLightHint: groupValue == value,
                hint: "Phường/xã",
                width: DeviceUtils.getScaledWidth(context, 0.4),
              )
              else
              DropDownButtonHideUnderLineWidget<PhuongXaResponse>(
                data: controller.isLoadingWard ? [] : ward,
                onChanged: value == groupValue ?  (PhuongXaResponse? val)=> onChangedPhuong(val) : null,
                value: phuong,
                highLightHint: groupValue == value,
                hint: "Phường/xã",
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
      fontSize: Dimensions.FONT_SIZE_LARGE,
      holdplacer: "Nhập địa chỉ cụ thể nhận vật tư",
      hidden: false,
      label: "Địa chỉ cụ thể (số nhà, tên đường)",
      obligatory: true,
      typeInput: TextInputType.text,
      textInputAction: TextInputAction.next,
      width: DeviceUtils.getScaledWidth(context,1),
    );
  }

  ///
  /// Thời gian nhận vật tư
  ///
  Widget recieveTime(BuildContext context, {required V1VatLieuXayDungController controller}){
    return Column(
      children: [
        const Label(
          label: "Thời gian nhận dự kiến",
          obligatory: true,
        ),

        // Từ
        TextFieldDate(
          isDate: true,
          allowEdit: true,
          controller: controller.startTimeController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Chọn ngày nhận vật tư dự kiến",
          label: "Từ ngày",
          obligatory: true,
          typeInput: TextInputType.datetime,
          width: DeviceUtils.getScaledWidth(context,1),
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT,),
        ),

        // đến
        TextFieldDate(
          isDate: true,
          allowEdit: true,
          controller: controller.endTimeController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Chọn ngày nhận vật tư dự kiến",
          label: "Đến ngày",
          obligatory: true,
          typeInput: TextInputType.datetime,
          width: DeviceUtils.getScaledWidth(context,1),
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),
      ],
    );
  }

  ///
  /// Form vật tư
  ///
  Widget vatTuWidget(BuildContext context, {required V1VatLieuXayDungController controller}){
    return Column(
      children: [
        InputField(
          allowEdit: true,
          allowMultiline: true,
          controller: controller.requireContent,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Nhập nội dung yêu cầu",
          hidden: false,
          label: "Nội dung yêu cầu",
          obligatory: false,
          textInputAction: TextInputAction.newline,
          typeInput: TextInputType.multiline,
          width: DeviceUtils.getScaledWidth(context,1),
        ),
        // Thêm vật tư
        material(context, controller: controller),
      ],
    );
  }

  ///
  /// Thêm vật liệu
  ///
  Widget material(BuildContext context, {required V1VatLieuXayDungController controller} ){
    return Column(
      children: [
        const Label(
          label: "Nhập tên, quy cách, khối lượng, đơn vị",
          obligatory: false,
        ),
        SearchDropDownButton<VatTuResponse>(
          data: controller.vatTuList,
          obligatory: false,
          onChanged: (value)=> controller.onChangedVatTu(value!),
          value: controller.vatTu,
          width: DeviceUtils.getScaledSize(context,1),
          label: "Tên vật tư",
          hint: 'Chọn tên vật tư',
          padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT,right: Dimensions.PADDING_SIZE_DEFAULT, top: Dimensions.PADDING_SIZE_SMALL),
        ),
        InputField(
          allowEdit: false,
          allowMultiline: false,
          controller: controller.quyCachController,
          fontSize: Dimensions.FONT_SIZE_LARGE,
          holdplacer: "Quy cách vật tư",
          hidden: false,
          label: "Quy cách(Thương hiệu/Kích thước/Nơi sản xuất...)",
          textInputAction: TextInputAction.next,
          obligatory: false,
          isInteger: true,
          typeInput: TextInputType.number,
          width: DeviceUtils.getScaledWidth(context,1),
          padding: const EdgeInsets.only(
            left: Dimensions.PADDING_SIZE_DEFAULT,
            top: Dimensions.PADDING_SIZE_SMALL,
            right: Dimensions.PADDING_SIZE_DEFAULT
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InputField(
              allowEdit: true,
              allowMultiline: false,
              controller: controller.massController,
              fontSize: Dimensions.FONT_SIZE_LARGE,
              holdplacer: "Nhập khối lượng",
              hidden: false,
              label: "Khối lượng",
              textInputAction: TextInputAction.next,
              obligatory: false,
              isInteger: true,
              typeInput: TextInputType.number,
              width: DeviceUtils.getScaledWidth(context,0.5),
              padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_SMALL,
                right: Dimensions.PADDING_SIZE_DEFAULT
              ),
            ),
            InputField(
              allowEdit: false,
              allowMultiline: false,
              controller: controller.unitController,
              fontSize: Dimensions.FONT_SIZE_LARGE,
              holdplacer: "Đơn vị",
              hidden: false,
              label: "Đơn vị",
              textInputAction: TextInputAction.next,
              obligatory: false,
              isInteger: true,
              typeInput: TextInputType.number,
              width: DeviceUtils.getScaledWidth(context,0.5),
              padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                top: Dimensions.PADDING_SIZE_SMALL,
                right: Dimensions.PADDING_SIZE_DEFAULT
              ),
            ),
          ],
         ),

        // Button
        Padding(
          padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
          child: LongButton(
             title: '+ Thêm vật tư', 
             color: ColorResources.PRIMARYCOLOR, 
             onPressed: controller.onClickAddMass,
             horizontal: Dimensions.PADDING_SIZE_DEFAULT,
          ),
        ),
        
        //Danh sách vật tư
        materialList(context, controller: controller),

        // Hinhf ảnh bảng khối lượng
        imageMaterial(controller: controller),

        // Đính kèm file
        attchFile(context, controller: controller),

        //Chọn tiến độ giao hàng
        deliveryProgress(context, controller: controller)
      ],
    );
  }

  ///
  /// Danh sách vật tư được thêm 
  ///
  Widget materialList(BuildContext context,{required V1VatLieuXayDungController controller}){
    return Column(
      children: controller.supplies.map((e) => 
      SizedBox(
        width: DeviceUtils.getScaledWidth(context, 1),
        child: MaterialCard(mass: e, onDelete: ()=> controller.deleteSupplies(e)))
      ).toList()
    );
  }

  ///
  /// File đính kèm
  ///
  Widget attchFile(BuildContext context,{required V1VatLieuXayDungController controller}){
    return Column(
      children: [
        const Label(
          label: "Đính kèm file excel hoặc khác",
          obligatory: false,
        ),
        AttachButton(
          title: controller.fileDonDichVu.isEmpty  ? "Thêm tập tin" : controller.fileDonDichVu.first, 
          color: ColorResources.WHITE, 
          onPressed: controller.pickFiles,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        )
      ],
    );
  }

  ///
  /// Hình ảnh vật tư
  ///
  Widget imageMaterial({required V1VatLieuXayDungController controller}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label(
          label: "Hình ảnh bảng khối lượng",
          obligatory: false,
          paddingTitle: 0
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: Text("(Bảng in hoặc viết bằng tay nếu có)"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
          child: BoxImage(
            images: controller.anhKhoiLuong,
            isAddImage: true,onPress:()=> controller.pickImages(data: controller.anhKhoiLuong),
            onDelete: (String file, List<String> files)=> controller.onDeleteImage(file: file,files: files,),
          ),
        ),
      ],
    );
  }

  ///
  /// Chọn tiến độ giao hàng
  ///
  Widget deliveryProgress(BuildContext context,{required V1VatLieuXayDungController controller}){
    return Column(
      children: [
        const Label(
          label: "Chọn tiến độ giao hàng",
          obligatory: true,
        ),
        Row(
          children: [
            RadioButton<int>(title: "Giao gấp", onChanged: (val) => controller.changeProgress(val!), value: 1, groupValue: controller.progress),
            RadioButton<int>(title: "Không gấp, giao kết hợp", onChanged: (val)=> controller.changeProgress(val!), value: 2, groupValue: controller.progress),
          ],
        ),
      ],
    );
  }

  Widget button(BuildContext context, {required V1VatLieuXayDungController controller}){
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
      child: LongButton(
        color: ColorResources.PRIMARYCOLOR,
        onPressed: (){
          DeviceUtils.unFocus(context);
          controller.onClickContinue();
        },
        title: "Tiếp tục",
        horizontal: Dimensions.PADDING_SIZE_DEFAULT,
        vertical: Dimensions.PADDING_SIZE_SMALL,
      ),
    );
  }

}