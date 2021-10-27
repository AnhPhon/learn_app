


import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/data/model/response/vat_tu_response.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/app_constants.dart';

class V1OrderFeedBackController extends GetxController{
  final VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  final DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse? donDichVu;

  // Khối lương công việc
  List<VatTuResponse> workMass = [];
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
      soTien = double.parse(donDichVu!.soTien!,(e)=> 0);
      phiDichVu = double.parse(donDichVu!.phiDichVu!,(e)=> 0);
      khuyenMai = double.parse(donDichVu!.khuyenMai!,(e)=> 0);
      tienCoc = double.parse(donDichVu!.tienCoc!,(e)=> 0);
      tongTien =  double.parse(donDichVu!.tongDon!,(e)=> 0);
    }
    super.onInit();
    getJobMass();
  }

  ///
  /// Lấy báo giá công việc or vâtk liệu thuộc đơn dịch vụ
  ///
  void getJobMass(){
    vatTuProvider.paginate(page: 1, limit: 100, filter: '&idDonDichVu=${donDichVu!.id!}', onSuccess: (data){
      workMass.clear();
      workMass.addAll(data);
      isLoading = false;
      update();
    }, onError: (onError){
      isLoading = false;
      update();
      print("V1OrderFeedBackController getJobMass onError $onError");
    });
  }

  void onClickAgreeButton(){
    Get.toNamed(AppRoutes.V1_FORMAL_FEEDBACK_PAYMENT, arguments: donDichVu);
  }

  ///
  /// Đã phản hồi nhưng không đồng ý thanh toán
  ///
  void onFeebacked(){
    EasyLoading.show(status: "Phản hồi đơn dich vụ ...");
    final DonDichVuRequest dichVuRequest = DonDichVuRequest();
    dichVuRequest.id = donDichVu!.id;
    dichVuRequest.idTrangThaiDonDichVu = DA_PHAN_HOI;
    dichVuRequest.idTrangThaiThanhToan = CHUA_THANH_TOAN;
    donDichVuProvider.update(data: dichVuRequest, onSuccess: (onSuccess){
      EasyLoading.dismiss();
      Get.back();
    }, onError: (onError){
      print("V1BuildOrderFeedBackController onFeebacked: $onError");
    });
  }
}