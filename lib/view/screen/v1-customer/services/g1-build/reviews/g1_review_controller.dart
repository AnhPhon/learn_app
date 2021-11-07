import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/chi_tiet_vat_tu_request.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/preview_service_request.dart';
import 'package:template/data/model/request/vat_tu_request.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/snack_bar.dart';


class V1G1ReviewController extends GetxController{
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider = GetIt.I.get<ChiTietVatTuProvider>();

  PreviewServiceRequest? previewServiceRequest;
  
  @override
  void onInit() {
    super.onInit();
    previewServiceRequest = Get.arguments as PreviewServiceRequest;
  }

  ///
  /// Nhấn nút tạo đơn
  /// 
  void onClickButton(){
    onSave();
    
  }

  ///
  /// Hoàn thành đơn tạo
  ///
  void onSave()async{
    EasyLoading.show(status: "Loading ...");
    dichVuProvider.add(data: request(), onSuccess: (data){
      print("Đã tạo dich vụ thanh công");
      // Thệm bảng khối lượng công việc
      addMass(idDon: data.id!);
      Get.offAllNamed(AppRoutes.V1_SUCCESSFULLY, predicate: ModalRoute.withName(AppRoutes.V1_SUCCESSFULLY));
      Alert.success(message: "Tạo đơn công việc thành công. Chúng tôi sẽ phản hồi lại sớm nhất");
    }, onError: (error){
      EasyLoading.dismiss();
      Alert.error(message: error.toString());
      print("V1G1ReviewController onSave $error");
    });
  }

  DonDichVuRequest request(){
    final DonDichVuRequest dichVuRequest = DonDichVuRequest();
    dichVuRequest.moTa = previewServiceRequest!.moTa;
    dichVuRequest.ngayBatDau = DateConverter.formatYYYYMMDD(previewServiceRequest!.ngayBatDau!);
    if(previewServiceRequest!.ngayKetThuc != null){
      dichVuRequest.ngayKetThuc =  DateConverter.formatYYYYMMDD(previewServiceRequest!.ngayKetThuc!);
    }
    dichVuRequest.idTinhTp = previewServiceRequest!.idTinhTp;
    dichVuRequest.idQuanHuyen = previewServiceRequest!.idQuanHuyen;
    dichVuRequest.idPhuongXa = previewServiceRequest!.idPhuongXa;
    dichVuRequest.idNhomDichVu = previewServiceRequest!.idNhomDichVu;
    dichVuRequest.idTaiKhoan = previewServiceRequest!.idTaiKhoan;
    dichVuRequest.tieuDe = previewServiceRequest!.tieuDe;
    dichVuRequest.diaChiCuThe = previewServiceRequest!.diaChiCuThe ;
    dichVuRequest.idTaiKhoanNhanDon = previewServiceRequest!.idTaiKhoanNhanDon;

    dichVuRequest.idTrangThaiDonDichVu = CHUA_PHAN_HOI;
    dichVuRequest.idTrangThaiThanhToan = CHUA_THANH_TOAN;
    
    dichVuRequest.hinhAnhBanKhoiLuongs = previewServiceRequest!.hinhAnhBanKhoiLuongs;
    dichVuRequest.hinhAnhBanVes  = previewServiceRequest!.hinhAnhBanVes;
    dichVuRequest.files = previewServiceRequest!.files;
    return dichVuRequest;
    
  }

  void addMass({required String idDon}){
    previewServiceRequest!.bangKhoiLuong!.forEach((item) {
      final VatTuRequest vatTuRequest = VatTuRequest();
      vatTuRequest.donVi = item.donVi;
      vatTuRequest.tenVatTu = item.tenVatTu;
      vatTuRequest.quyCach = item.quyCach;
      // vatTuRequest.idDonDichVu = idDon;
      vatTuProvider.add(data: vatTuRequest, onSuccess: (data){
          final ChiTietVatTuRequest chiTietVatTu = ChiTietVatTuRequest();
          chiTietVatTu.idVatTu = data.id;
          chiTietVatTu.soLuong = item.khoiLuong;
          chiTietVatTu.idDonDichVu = idDon;
          chiTietVatTuProvider.add(data: chiTietVatTu, onSuccess: (onSuccess){
            print("Thêm vật tư thành công $data");
          }, onError: (onError){
            print("Thêm vật tư thất bại !");
          });
          
      }, onError: (onError){
        print("ReviewController addMass error $onError");
      });
    });
    EasyLoading.dismiss();
  }

}