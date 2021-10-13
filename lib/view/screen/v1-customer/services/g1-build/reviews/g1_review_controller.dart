import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/request/preview_service_request.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

class V1G1ReviewController extends GetxController{
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  PreviewServiceRequest? previewServiceRequest;
  
  @override
  void onInit() {
    super.onInit();
    previewServiceRequest = Get.arguments as PreviewServiceRequest;
  }

  void onClickButton(){
    Get.toNamed(AppRoutes.V1_SUCCESSFULLY);
  }

  ///
  /// Hoàn thành đơn tạo
  ///
  void onSave(){
    EasyLoading.show(status: "Loading ...");
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
    // dichVuRequest.hinhAnhBanKhoiLuong = previewServiceRequest!.hinhAnhBanKhoiLuong;
    // dichVuRequest.bangKhoiLuong = previewServiceRequest!.bangKhoiLuong;
    // dichVuRequest.hinhAnhBanVe  = previewServiceRequest!.hinhAnhBanVe;
    dichVuProvider.add(data: dichVuRequest, onSuccess: (data){
      EasyLoading.dismiss();
    }, onError: (error){
      showSnackBar(title: "Lỗi", message: error.toString());
    });
  }
}