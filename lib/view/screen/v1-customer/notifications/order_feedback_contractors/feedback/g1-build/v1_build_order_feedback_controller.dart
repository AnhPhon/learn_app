

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';
import 'package:template/data/model/response/danh_sach_bao_gia_don_dich_vu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';

class V1BuildOrderFeedBackController extends GetxController{
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  final VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  final ChiTietVatTuProvider chiTietVatTuProvider = GetIt.I.get<ChiTietVatTuProvider>();
  final DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider = GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  DonDichVuResponse? donDichVu;
  // Khối lương công việc
  DanhSachBaoGiaDonDichVuResponse? donPhanHoi;
  bool isLoading = true;
  double soTien = 0;
  double phiDichVu = 0;
  double khuyenMai = 0;
  double tongTien = 0;
  double tienCoc = 0;

  @override
  void onInit() {
    if(Get.arguments != null){
      donDichVu = Get.arguments as DonDichVuResponse;
    }
    soTien = double.parse(donDichVu!.soTien!,(e)=> 0);
    phiDichVu = double.parse(donDichVu!.phiDichVu!,(e)=> 0);
    khuyenMai = double.parse(donDichVu!.khuyenMai!,(e)=> 0);
    tongTien =  double.parse(donDichVu!.tongDon!,(e)=> 0);
    tienCoc = double.parse(donDichVu!.tienCoc!,(e)=> 0);
    super.onInit();
    getJobMass();
  }



  ///
  /// Lấy báo giá công việc or vâtk liệu thuộc đơn dịch vụ
  ///
  void getJobMass(){
    danhSachBaoGiaDonDichVuProvider.paginate(page: 1, limit: 100, filter: '&idDonDichVu=${donDichVu!.id!}', onSuccess: (donBaoGia){
       if(donBaoGia.isNotEmpty){
          donPhanHoi = donBaoGia.first;
          for(int i=0; i<donPhanHoi!.giaVatTus!.length; i++ ){
            chiTietVatTuProvider.paginate(page: 1, limit: 100, filter: '&idDonDichVu=${donDichVu!.id!}', onSuccess: (data){
              if(data.isNotEmpty){
                donPhanHoi!.giaVatTus![i].idChiTietVatTu = data.first;
              }
              if(i == donPhanHoi!.giaVatTus!.length - 1){
                isLoading = false;
                update();
              }
            }, onError: (error){
              print("getJobMass $error");
            }
          );

          if(donPhanHoi!.giaVatTus!.isEmpty){
            isLoading = false;
            update();
          }
          
        }
       }
       
       
       if(donBaoGia.isEmpty){
           isLoading = false;
           update();
       }
     
    }, onError: (onError){
      print("V1OrderFeedBackController getJobMass onError $onError");
    });
    // print(donDichVu!.toJson());
    // chiTietVatTuProvider.paginate(page: 1, limit: 100, filter: '&idDonDichVu=${donDichVu!.id!}', onSuccess: (data){
    //   workMass.clear();
    //   workMass.addAll(data);
    //   isLoading = false;
    //   update();
    // }, onError: (onError){
    //   isLoading = false;
    //   update();
    //   print("V1OrderFeedBackController getJobMass onError $onError");
    // });
  }

  void onClickAgreeButton(){
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
            Get.back();
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
      Alert.success(message: "Phản hồi thành công");
    }, onError: (onError){
      print("V1BuildOrderFeedBackController onFeebacked: $onError");
    });
  }
}