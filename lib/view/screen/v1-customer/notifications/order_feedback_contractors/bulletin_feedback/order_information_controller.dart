
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/phan_hoi_don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/phan_hoi_don_dich_vu_response.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

class OrderFeedbackInformationController extends GetxController{
    DonDichVuResponse? donDichVu;

    double soTien = 0;
    double phiDichVu = 0;
    double khuyenMai = 0;
    double tongTien = 0;
    double tienCoc = 0;

    bool isLoading = true;
    @override
  void onInit() {
    super.onInit();
    tinhTien();
    //donDichVu!.tongDon = tongTien.toString();
  }

  void tinhTien(){
    donDichVu = Get.arguments as DonDichVuResponse;
    if(donDichVu != null){
      soTien = double.parse(donDichVu!.soTien!,(e)=> 0);
      phiDichVu = double.parse(donDichVu!.phiDichVu!,(e)=> 0);
      khuyenMai = double.parse(donDichVu!.khuyenMai!,(e)=> 0);
      tongTien = soTien + phiDichVu - khuyenMai;
      tienCoc = double.parse(donDichVu!.tienCoc!,(e)=> 0);
      isLoading = false;
      update();
    }
  }

  ////////////////////////////////////////////////////////////////
  /// Tạo request
  /// 
  PhanHoiDonDichVuRequest onRequest(){
    PhanHoiDonDichVuRequest request =  PhanHoiDonDichVuRequest();
    //donDichVu!.tieuDe = "Phản hồi báo giá đơn dich vụ "
    if(donDichVu!.id != null){
      request.idDonDichVu = donDichVu!.id;
    }
    if(donDichVu!.idTaiKhoan != null){
      // Tài khoản nhận đơn
      request.idTaiKhoan = donDichVu!.idTaiKhoan!.id;
    }
    // if(donDichVu!.idTaiKhoan!.id != null){
    //   request.idTaiKhoan = donDichVu!.idTaiKhoan!.id;
    // }
    return request;
  }
    ///
    /// Nhấn vào đông ý đơn hàng
    ///
    void onNextPage(){
      Get.toNamed(AppRoutes.V1_FORMAL_FEEDBACK_PAYMENT, arguments: donDichVu);
    }
}