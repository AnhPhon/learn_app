
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';

class V1G3OrderDetailController extends GetxController{
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuRequest? donDichVuRequest;
  double soTien = 0;
  double phiDichVu = 0;
  double khuyenMai = 0;
  double tongTien = 0;
//unit
  @override
  void onInit() {
    super.onInit();
    donDichVuRequest = Get.arguments as DonDichVuRequest;
    if(donDichVuRequest != null){
      soTien = double.parse(donDichVuRequest!.soTien != 'null' ? donDichVuRequest!.soTien !: '0');
      phiDichVu = double.parse(donDichVuRequest!.phiDichVu != 'null' ? donDichVuRequest!.phiDichVu !: '0');
      khuyenMai = double.parse(donDichVuRequest!.khuyenMai != 'null' ? donDichVuRequest!.khuyenMai !: '0');
      tongTien = double.parse(donDichVuRequest!.tongDon != 'null' ? donDichVuRequest!.tongDon !: '0') + phiDichVu - khuyenMai;
    }
  }


  void onNextPage(){
    donDichVuRequest!.tongDon = (tongTien + phiDichVu - khuyenMai).toString();
    Get.toNamed(AppRoutes.V1_FORMAL_PAYMENT, arguments: donDichVuRequest,);
    //onSave();
  }

}