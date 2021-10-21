import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/bang_gia_don_hang_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/bang_gia_don_hang_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

class V1G3OrderQuoteController extends GetxController{
  final BangGiaDonHangProvider bangGiaDonHangProvider = GetIt.I.get<BangGiaDonHangProvider>();
  final LoaiCongViecProvider loaiCongViecProvider = GetIt.I.get<LoaiCongViecProvider>();
  
  final priceController = TextEditingController();
  final personNumberContrller = TextEditingController();
  final descController = TextEditingController();


  // Danh sách công việc
  List<LoaiCongViecResponse> workTypes = [];
  // Loai công việc
  LoaiCongViecResponse? work;


  // Đối tương request truyền từ màn hình trước qua
  DonDichVuRequest? request;
  bool isLoading = true;

  BangGiaDonHangResponse? subServices;

  // Danh sách bản giá đơn hàng
  List<BangGiaDonHangResponse> priceTable = [];

  @override
  void onInit() {
    super.onInit();
    request = Get.arguments as DonDichVuRequest;
    getAllWorkType();
  }



  ////////////////////////////////
  ///Lấy bảng giá đơn hàng
  ///
  void getAllBangGia(){
    bangGiaDonHangProvider.paginate(page: 1, limit: 100, filter: '&idLoaiCongViec=${work!.id!}', onSuccess: (data){
      priceTable = data;
      if(priceTable.isNotEmpty){
        subServices = priceTable.first;
        priceController.text = CurrencyConverter.currencyConverterVND(double.parse(subServices!.giaTien!));
      }
      isLoading = false;
      update();
    }, onError: (onError){
      isLoading = false;
      update();
      print("V1G3OrderQuoteController getAllBangGia Error $onError");
    });
  }


  ////////////////////////////////
  ///Lấy loại công việc
  ///
  void getAllWorkType(){
    loaiCongViecProvider.paginate(page: 1, limit: 100, filter: "&idNhomDichVu=${request!.idNhomDichVu!}" ,onSuccess: (data){
      workTypes.clear();
      workTypes.addAll(data);
      work = workTypes.firstWhere((element){
        return element.tenCongViec!.contains(request!.tieuDe!);
      });
      getAllBangGia();
    }, onError:(error){
      print("V1G3OrderQuoteController getAllWorkType onError $error");
      isLoading = false;
      update();
      Get.snackbar("Error",error.message.toString(),);
    });
  }

  /////
  /// on change work type
  ///
  void onChangedWorkType(LoaiCongViecResponse work){
    this.work = work;
    getAllBangGia();
    update();
  }

  /////
  /// on change service in work type
  ///
  void onChangedSubService(BangGiaDonHangResponse subServices){
    this.subServices = subServices;
    priceController.text = CurrencyConverter.currencyConverterVND(double.parse(subServices.giaTien!));//this.work.
    update();
  }
  

  ///
  /// Tiếp tục
  ///
  void onNextPage(){
    if(validate()){
      request!.tieuDe = work!.tenCongViec;
      request!.moTa = descController.text.toString();
      request!.soLuongYeuCau = personNumberContrller.text.toString();
      request!.soTien = priceController.text.toString().replaceAll(",", '');//work.giaTien;
      request!.phiDichVu = '0';
      request!.khuyenMai = '0';
      request!.tongDon = priceController.text.toString().replaceAll(",", '');//work.money;
      Get.toNamed(AppRoutes.V1_G3_ORDER_DETAIL, arguments: request);
    }
  }

  ///
  /// Check validate
  ///
  bool validate(){
    if(personNumberContrller.text.toString().isEmpty){
      showSnackBar(title: "Lỗi", message: "Vui lòng nhập lượng người yêu cầu");
      return false;
    }else if(descController.text.toString().isEmpty){
      showSnackBar(title: "Lỗi", message: "Vui lòng nhập nội dung miêu tả");
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    super.onClose();
    priceController.dispose();
    personNumberContrller.dispose();
    descController.dispose();
  }


}