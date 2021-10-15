import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1FormalPaymentController extends GetxController{
  
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuRequest? dichVuRequest;
  @override
  void onInit() {
    final data = Get.arguments as Map<String, dynamic>;
    if(data['idNhom'] == 3){
      dichVuRequest = data['don'] as DonDichVuRequest;
    }
    super.onInit();
  }

  void onNextPage(){
    Get.toNamed(AppRoutes.V1_ORDER_INFORAMTION);
  }

}