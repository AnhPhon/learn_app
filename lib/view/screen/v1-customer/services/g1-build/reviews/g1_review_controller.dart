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
    onSave();
  }

  void onClickButton(){
    Get.toNamed(AppRoutes.V1_SUCCESSFULLY);
  }

  ///
  /// Hoàn thành đơn tạo
  ///
  void onSave(){
    EasyLoading.show(status: "Loading ...");
    request();
    // dichVuProvider.add(data: request(), onSuccess: (data){
    //   EasyLoading.dismiss();
    // }, onError: (error){
    //   showSnackBar(title: "Lỗi", message: error.toString());
    // });
  }

  DonDichVuRequest request(){
    String massImages = '';
    String drawingImage = '';
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
    previewServiceRequest!.hinhAnhBanKhoiLuong!.forEach((element) { 
      imageUpdateProvider.add(file: element,onSuccess: (data){
        massImages = "${massImages},${data.data}";
      }, onError: (onError){
        print("Error");
      });
    });
    previewServiceRequest!.hinhAnhBanVe!.forEach((element) { 
      imageUpdateProvider.add(file: element,onSuccess: (data){
        drawingImage = "$drawingImage,${data.data}";
      }, onError: (onError){
        print("Error");
      });
    });
    print(massImages);
    previewServiceRequest!.bangKhoiLuong!.forEach((element) {
      // Tải bảng khối lượng lên
    });
    // dichVuRequest.hinhAnhBanKhoiLuong = previewServiceRequest!.hinhAnhBanKhoiLuong;
    //dichVuRequest.bangKhoiLuong = previewServiceRequest!.bangKhoiLuong;
    // Thiếu bảng khối lượng
    // dichVuRequest.hinhAnhBanVe  = previewServiceRequest!.hinhAnhBanVe;
    return dichVuRequest;
  }

}