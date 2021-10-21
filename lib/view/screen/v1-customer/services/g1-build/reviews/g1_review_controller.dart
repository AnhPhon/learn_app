import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/preview_service_request.dart';
import 'package:template/data/model/request/vat_tu_request.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

class V1G1ReviewController extends GetxController{
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();

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
    dichVuProvider.add(data: await request(), onSuccess: (data){

      // Thệm bảng khối lượng công việc
      addMass(idDon: data.id!);
      Get.offAllNamed(AppRoutes.V1_SUCCESSFULLY, predicate: ModalRoute.withName(AppRoutes.V1_SUCCESSFULLY));
      showSnackBar(title: "Tạo đơn công việc thành công", message: "Chúng tôi sẽ phản hồi lại sớm nhất");
    }, onError: (error){
      EasyLoading.dismiss();
      showSnackBar(title: "Lỗi", message: error.toString());
      print("V1G1ReviewController onSave $error");
    });
  }

  Future<DonDichVuRequest> request(){
    String massImages = '';
    String drawingImages = '';
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

    // Hình ảnh bản khối lượng
    previewServiceRequest!.hinhAnhBanKhoiLuong!.forEach((element) { 
      imageUpdateProvider.add(file: element,onSuccess: (data){
        massImages = "$massImages${data.data},";
      }, onError: (onError){
        print("V1G1ReviewController request khối lượng $onError");
      });
    });

    // Ảnh bản vẽ
    previewServiceRequest!.hinhAnhBanVe!.forEach((element) { 
      imageUpdateProvider.add(file: element,onSuccess: (data){
        drawingImages = "$drawingImages${data.data},";
      }, onError: (onError){
        print("V1G1ReviewController request  ảnh bản vẽ $onError");
      });
    });

    // Tài file
    if(previewServiceRequest!.file != null){
      imageUpdateProvider.add(file: previewServiceRequest!.file!, onSuccess: (data){
        dichVuRequest.file = data.data;
      }, onError: (onError){
        showSnackBar(title: "Lỗi", message: "Tải file thất bại");
        print("V1G1ReviewController request  tải file $onError");
      });
    }
    
    // Delay
    return Future.delayed(const Duration(seconds: 1)).then((value){
      dichVuRequest.hinhAnhBanKhoiLuong = massImages;
      dichVuRequest.hinhAnhBanVe  = drawingImages;
      return dichVuRequest;
    });
  }

  void addMass({required String idDon}){
    previewServiceRequest!.bangKhoiLuong!.forEach((item) {
      final VatTuRequest vatTuRequest = VatTuRequest();
      vatTuRequest.donGia = item.donGia;
      vatTuRequest.donVi = item.donVi;
      vatTuRequest.tenVatTu = item.tenVatTu;
      vatTuRequest.quyCach = item.quyCach;
      vatTuRequest.idDonDichVu = idDon;
      vatTuProvider.add(data: vatTuRequest, onSuccess: (data){
          print("Thêm vật tư thành công $data");
      }, onError: (onError){
        print("ReviewController addMass error $onError");
      });
    });
    EasyLoading.dismiss();
  }

}