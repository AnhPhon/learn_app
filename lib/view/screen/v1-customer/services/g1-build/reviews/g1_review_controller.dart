import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/chi_tiet_cong_viec_request.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/preview_service_request.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/chi_tiet_cong_viec_provider.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';


class V1G1ReviewController extends GetxController{
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider = GetIt.I.get<ChiTietVatTuProvider>();
  final ChiTietCongViecProvider chiTietCongViecProvider = GetIt.I.get<ChiTietCongViecProvider>();

  PreviewServiceRequest? previewServiceRequest;
  

  //Flag
  bool isClicked = false;

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
  Future<void> onSave()async{
    if(isClicked){
      return;
    }else{
      isClicked = true;
      EasyLoading.show(status: "Loading ...");
      dichVuProvider.add(data: request(), onSuccess: (data){
        print("Đã tạo dich vụ thanh công");
        // Thệm bảng khối lượng công việc
        addWork(idDon: data.id!);
        Get.offAllNamed(AppRoutes.V1_SUCCESSFULLY, predicate: ModalRoute.withName(AppRoutes.V1_SUCCESSFULLY));
        Alert.success(message: "Tạo đơn công việc thành công. Chúng tôi sẽ phản hồi lại sớm nhất");
      }, onError: (error){
        EasyLoading.dismiss();
        Alert.error(message: error.toString());
        print("V1G1ReviewController onSave $error");
      });
    }
    
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
    dichVuRequest.idLoaiCongViec = previewServiceRequest!.idLoaiCongViec;
    return dichVuRequest;
    
  }

  void addWork({required String idDon}){
    previewServiceRequest!.bangKhoiLuongCongViec!.forEach((item) {
      final ChiTietCongViecRequest congViecRequest = ChiTietCongViecRequest();
      congViecRequest.donVi = item.donVi;
      congViecRequest.tenCongViec = item.tenCongViec;
      congViecRequest.quyCach = item.quyCach;
      congViecRequest.soLuong = item.soLuong;
      congViecRequest.idDonDichVu = idDon;
      chiTietCongViecProvider.add(data: congViecRequest, onSuccess: (data){
          print("Thêm công việc thành công $data");
      }, onError: (onError){
        print("ReviewController addMass error $onError");
      });
    });
    EasyLoading.dismiss();
  }

}