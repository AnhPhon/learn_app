import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/chi_tiet_vat_tu_request.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/preview_service_request.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';


class V1PreviewVatTuController extends GetxController{
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider = GetIt.I.get<ChiTietVatTuProvider>();
  final ChiTietVatTuProvider chitTietVatTuProvider = GetIt.I.get<ChiTietVatTuProvider>();

  PreviewServiceRequest? previewServiceRequest;
  
  @override
  void onInit() {
    super.onInit();
    previewServiceRequest = Get.arguments as PreviewServiceRequest;
  }

  bool isClicked = false;

  ///
  /// Nhấn nút tạo đơn
  /// 
  void onClickButton(){
    if(isClicked){
      return;
    }else{
      onSave();
    }
  }

  ///
  /// Hoàn thành đơn tạo
  ///
  Future<void> onSave()async{
    EasyLoading.show(status: "Loading ...");
    dichVuProvider.add(data: request(), onSuccess: (data){
      print("Đơn dịch vụ:${data.id}");
      addMass(idDon: data.id!);
      Get.offAllNamed(AppRoutes.V1_SUCCESSFULLY, predicate: ModalRoute.withName(AppRoutes.V1_SUCCESSFULLY));
      EasyLoading.dismiss();
      IZIAlert.success(message: "Báo giá thành công. Chúng tôi sẽ phản hồi lại sớm nhất");
    }, onError: (error){
      EasyLoading.dismiss();
      IZIAlert.error(message: error.toString());
      print("V1PreviewVatTuController onSave $error");
    });
  }

  DonDichVuRequest request(){
    final DonDichVuRequest dichVuRequest = DonDichVuRequest();
    dichVuRequest.moTa = previewServiceRequest!.moTa;
    dichVuRequest.ngayBatDau = DateConverter.formatYYYYMMDD(previewServiceRequest!.ngayBatDau!);
    dichVuRequest.ngayKetThuc = DateConverter.formatYYYYMMDD(previewServiceRequest!.ngayKetThuc!);
    dichVuRequest.idTinhTp = previewServiceRequest!.idTinhTp;
    dichVuRequest.idQuanHuyen = previewServiceRequest!.idQuanHuyen;
    dichVuRequest.idPhuongXa = previewServiceRequest!.idPhuongXa;
    dichVuRequest.idNhomDichVu = previewServiceRequest!.idNhomDichVu;
    dichVuRequest.idTaiKhoan = previewServiceRequest!.idTaiKhoan;
    dichVuRequest.tieuDe = previewServiceRequest!.tieuDe;
    dichVuRequest.diaChiCuThe = previewServiceRequest!.diaChiCuThe ;
    dichVuRequest.idCongTrinh = previewServiceRequest!.idLoaiCongTrinh!.id;
    dichVuRequest.tienDoGiaoHang = previewServiceRequest!.tienDoGiaoHang.toString();
    dichVuRequest.files = previewServiceRequest!.files;
    dichVuRequest.hinhAnhBanKhoiLuongs = previewServiceRequest!.hinhAnhBanKhoiLuongs;

    dichVuRequest.idTrangThaiDonDichVu = CHUA_PHAN_HOI;
    dichVuRequest.idTrangThaiThanhToan = CHUA_THANH_TOAN;
    
    return dichVuRequest;
    
  }

  void addMass({required String idDon}){
    previewServiceRequest!.chiTietVatTus!.forEach((item) {
      final ChiTietVatTuRequest vatTuRequest = ChiTietVatTuRequest();
          vatTuRequest.soLuong = item.soLuong;
          vatTuRequest.idDonDichVu = idDon;
          vatTuRequest.idVatTu = item.idVatTu!.id;
          chitTietVatTuProvider.add(data: vatTuRequest, onSuccess: (data){
              print("Thêm vật tư thành công $data");
          }, onError: (onError){
            print("ReviewController addMass error $onError");
          });
    });
    EasyLoading.dismiss();
  }

}