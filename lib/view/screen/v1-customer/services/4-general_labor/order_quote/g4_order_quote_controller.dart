import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/chi_tiet_cong_viec_request.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/snack_bar.dart';

class V1G4OrderQuoteController extends GetxController{

  final LoaiCongViecProvider loaiCongViecProvider = GetIt.I.get<LoaiCongViecProvider>();
  final priceController = TextEditingController();
  final personNumberController = TextEditingController();
  final timeNumberController = TextEditingController();
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
      priceController.text = CurrencyConverter.currencyConverterVND(double.parse(work!.giaCongViec!));
      isLoading = false;
      update();
    }, onError:(error){
      print("V1G4OrderQuoteController getAllWorkType onError $error");
      isLoading = false;
      update();
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
      request!.idLoaiCongViec = work!.id;
      request!.moTa = descController.text.toString();
      request!.soTien = (double.parse(timeNumberController.text.toString()) * double.parse(personNumberController.text.toString()) * double.parse(priceController.text.toString().replaceAll(',', ''))).toString();
      request!.soLuongYeuCau = personNumberController.text.toString();
      request!.soNgay = timeNumberController.text.toString();
      Get.toNamed(AppRoutes.V1_FORMAL_PAYMENT, arguments: request);
      
    }
  }

  ///
  ///onBack
  ///
  void onBack(){
    request!.tieuDe = work!.tenCongViec;
    Get.back(result: request);
  }


  ///
  /// Check validate
  ///
  bool validate(){
    if(timeNumberController.text.toString().isEmpty){
      Alert.error(message: "Bản phải chọn thời gian yêu cầu");
      return false;
    }else if(personNumberController.text.toString().isEmpty){
      Alert.error(message: "Số lượng người yêu cầu không được để trống");
      return false;
    }else if(descController.text.toString().isEmpty){
      Alert.error(message: "Nội dung miêu tả không được để trống");
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    super.onClose();
    priceController.dispose();
    personNumberController.dispose();
    timeNumberController.dispose();
    descController.dispose();
  }

}