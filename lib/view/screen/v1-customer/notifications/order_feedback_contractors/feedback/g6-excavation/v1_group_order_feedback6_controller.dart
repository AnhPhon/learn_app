import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';

class V1GroupOrderFeedBack6Controller extends GetxController{
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final desController = TextEditingController();

  DonDichVuResponse? donDichVu;
  double soTien = 0;
  double phiDichVu = 0;
  double khuyenMai = 0;
  double tongTien = 0;
  double tienCoc = 0;


  @override
  void onInit() {
    if(Get.arguments != null){
      donDichVu = Get.arguments as DonDichVuResponse;
      soTien = double.parse(donDichVu!.soTien!,(e)=> 0);
      phiDichVu = double.parse(donDichVu!.phiDichVu!,(e)=> 0);
      khuyenMai = double.parse(donDichVu!.khuyenMai!,(e)=> 0);
      tienCoc = double.parse(donDichVu!.tienCoc!,(e)=> 0);
      tongTien = double.parse(donDichVu!.tongDon!,(e)=> 0);
    }
    super.onInit();
  }

  void onClickAgreeButton(){
     if(desController.text.toString().isNotEmpty){
      //Nội dung chi tiết giá
      donDichVu!.moTa = desController.text.toString();
    }
    // Đến màn hình chọn phương thức thanh toán
    Get.toNamed(AppRoutes.V1_FORMAL_FEEDBACK_PAYMENT, arguments: donDichVu);
  }

  void showDialog(){
    Get.defaultDialog(
      title: "Bạn có chắc chắn từ chối đơn dich vụ này ?",
      content: const Text(''),
      actions: [
        ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(ColorResources.RED)
        ),
        onPressed: (){
          Get.back();
        }, child: const Text("Huỷ")),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(ColorResources.GREY)
          ),
          onPressed: (){
            onFeebacked();
          }, 
          child: const Text("Đồng ý")
        )
      ]
    );
  }

  ///
  /// Đã phản hồi nhưng không đồng ý thanh toán
  ///
  void onFeebacked(){
    EasyLoading.show(status: "Phản hồi đơn dich vụ ...");
    final DonDichVuRequest dichVuRequest = DonDichVuRequest();
    dichVuRequest.id = donDichVu!.id;
    dichVuRequest.idTrangThaiDonDichVu = THAT_BAI;
    dichVuRequest.idTrangThaiThanhToan = CHUA_THANH_TOAN;
    donDichVuProvider.update(data: dichVuRequest, onSuccess: (onSuccess){
      EasyLoading.dismiss();
      Get.back();
      update();
      Alert.success(message: "Phản hồi thành công");
    }, onError: (onError){
      print("V1GroupOrderFeedBack6Controller onFeebacked: $onError");
    });
  }
  
}