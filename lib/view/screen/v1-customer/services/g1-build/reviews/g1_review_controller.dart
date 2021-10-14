import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/preview_service_request.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

class V1G1ReviewController extends GetxController{
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  PreviewServiceRequest? previewServiceRequest;
  
  @override
  void onInit() {
    super.onInit();
    previewServiceRequest = Get.arguments as PreviewServiceRequest;
  }

  void onClickButton(){
    onSave();
    Get.toNamed(AppRoutes.V1_SUCCESSFULLY);
  }

  ///
  /// Hoàn thành đơn tạo
  ///
  void onSave(){
    EasyLoading.show(status: "Loading ...");
    dichVuProvider.add(data: request(), onSuccess: (data){
      EasyLoading.dismiss();
      showSnackBar(title: "Tạo đơn công việc thành công", message: "Chúng tôi sẽ phản hồi lại sớm nhất");
    }, onError: (error){
      EasyLoading.dismiss();
      showSnackBar(title: "Lỗi", message: error.toString());
    });
  }

  DonDichVuRequest request(){
    String massImages = '';
    String drawingImages = '';
    final DonDichVuRequest dichVuRequest = DonDichVuRequest();
    dichVuRequest.moTa = previewServiceRequest!.moTa;
    dichVuRequest.ngayBatDau = previewServiceRequest!.ngayBatDau;
    dichVuRequest.ngayKetThuc = previewServiceRequest!.ngayKetThuc;
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
        print("Error");
      });
    });
    // Ảnh bản vẽ
    previewServiceRequest!.hinhAnhBanVe!.forEach((element) { 
      imageUpdateProvider.add(file: element,onSuccess: (data){
        drawingImages = "$drawingImages${data.data},";
      }, onError: (onError){
        print("Error");
      });
    });
    // Tài file
    if(previewServiceRequest!.file != null){
      imageUpdateProvider.add(file: previewServiceRequest!.file!, onSuccess: (data){
        dichVuRequest.file = data as String;
      }, onError: (onError){
        showSnackBar(title: "Lỗi", message: "Tải file thất bại");
      });
    }
    
    previewServiceRequest!.bangKhoiLuong!.forEach((element) {
      // Tải bảng khối lượng lên
    });
    Future.delayed(const Duration(seconds: 4)).then((value){
      dichVuRequest.hinhAnhBanKhoiLuong = massImages;
      dichVuRequest.hinhAnhBanVe  = drawingImages;
      return dichVuRequest;
    });
    
    //dichVuRequest.bangKhoiLuong = previewServiceRequest!.bangKhoiLuong;
    // Thiếu bảng khối lượng
    return dichVuRequest;
  }

}