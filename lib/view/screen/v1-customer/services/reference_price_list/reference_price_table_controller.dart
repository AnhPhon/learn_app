

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/chi_tiet_gia_tham_khao_model.dart';
import 'package:template/provider/chi_tiet_gia_tham_khao_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/app_constants.dart';

class ReferencePriceTableController extends GetxController{

  final ChiTietGiaThamKhaoProvider chiTietGiaThamKhaoProvider = GetIt.I.get<ChiTietGiaThamKhaoProvider>();

  DonDichVuRequest? request;
  String id = '0';
  String title = '';
  String appBarTitle = 'Tạo đơn công việc';
  bool isLoading = true;
  ChiTietGiaThamKhaoResponse? chiTietGiaThamKhao;

    @override
  void onInit() {
    
    super.onInit();
    if(Get.arguments != null){
      request = Get.arguments as DonDichVuRequest;
      id = Get.parameters['id'].toString();
      title = Get.parameters['title'].toString();
      appBarTitle = Get.parameters['appbar'].toString();
    }
    getChiTietGiaThamKhao();
  }


  ///
  /// Get chi tiet gia tham khao
  ///
  void getChiTietGiaThamKhao(){
    chiTietGiaThamKhaoProvider.all(onSuccess: (data){
      if(data.isNotEmpty){
        chiTietGiaThamKhao = data.first;
      }
      isLoading= false;
      update();
    }, onError: (onError){
      print("ReferencePriceTableController getChiTietGiaThamKhao $onError");
    });
  }

  ///
  /// on back
  ///
  void onBack() {
    Get.back(result: request);
  }

  ////////////////////////////////
  /// Click continue button
  ///
  void onClickCotinueButton(){
    
    if(id.contains('2')){
      Get.toNamed(AppRoutes.V1_G2_CREATE_WORK, arguments: request,);
    }else if(id.contains('3')){
      // Tạo đơn dịch vụ có gía nhóm 3
      Get.toNamed(AppRoutes.V1_G3_CREATE_SERVICE, arguments: request)!.then((value){
        if(value != null){
          request = (value as DonDichVuRequest);
          update();
        }
      });
    }else if(id.contains('4') ){
      // Tạo đơn dich vụ có giá nhóm 4
      Get.toNamed(AppRoutes.V1_G4_CREATE_SERVICE,arguments: request)!.then((value){
        if(value != null){
          request = (value as DonDichVuRequest);
          update();
        }
      });
    }else if(id.contains('5')){
      // Tạo đơn công viẹc và dịch nhóm 5
      Get.toNamed("${AppRoutes.V1_G5_CREATE_SERVICE}?appbar=$appBarTitle", arguments: request);
    }else if(id.contains('6')){
      // Tạo đơn công viẹc và dịch nhóm 6
      Get.toNamed("${AppRoutes.V1_G6_CREATE_SERVICE}?appbar=$appBarTitle", arguments: request);
    }
    // else if(id.contains('7')){
    //   // Tạo đơn công viẹc và dịch nhóm 7
    //   Get.toNamed(AppRoutes.V1_G7_RECRUITMENT, arguments: request);
    // }
  }

}