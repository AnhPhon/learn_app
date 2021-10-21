import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

class V1G4OrderQuoteController extends GetxController{

  final LoaiCongViecProvider loaiCongViecProvider = GetIt.I.get<LoaiCongViecProvider>();
  final priceController = TextEditingController();
  final timeNumberContrller = TextEditingController();
  final personNumberContrller = TextEditingController();
  final descController = TextEditingController();


  // Danh sách công việc
  List<LoaiCongViecResponse> workTypes = [];
  // Loai công việc
  LoaiCongViecResponse? work;


  // Đối tương request truyền từ màn hình trước qua
  DonDichVuRequest? request;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    request = Get.arguments as DonDichVuRequest;
    getAllWorkType();
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
      priceController.text = CurrencyConverter.currencyConverterVND(10000);
      isLoading = false;
      update();
    }, onError:(error){
      print("V1G4OrderQuoteController getAllWorkType onError $error");
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
    priceController.text = CurrencyConverter.currencyConverterVND(double.parse(this.work!.giaCongViec!));//this.work.
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
      request!.soNgay = timeNumberContrller.text.toString();
      request!.soTien = priceController.text.toString().replaceAll(',', '');//work.giaTien;
      request!.phiDichVu = '0';
      request!.khuyenMai = '0';
      request!.tongDon = work!.giaCongViec!.replaceAll(",", '');
      Get.toNamed(AppRoutes.V1_G4_ORDER_DETAIL, arguments: request);
    }
  }

  ///
  /// Check validate
  ///
  bool validate(){
    if(timeNumberContrller.text.toString().isEmpty){
      showSnackBar(title: "Vui lòng kiểm tra lại!", message: "Bản phải chọn thời gian yêu cầu");
      return false;
    }else if(personNumberContrller.text.toString().isEmpty){
      showSnackBar(title: "Vui lòng kiểm tra lại!", message: "Số lượng người yêu cầu không được để trống");
      return false;
    }else if(descController.text.toString().isEmpty){
      showSnackBar(title: "Vui lòng kiểm tra lại!", message: "Nội dung miêu tả không được để trống");
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    super.onClose();
    priceController.dispose();
    timeNumberContrller.dispose();
    personNumberContrller.dispose();
    descController.dispose();
  }

}