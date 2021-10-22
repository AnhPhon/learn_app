import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/basewidget/snackbar/snack_bar_widget.dart';

class V1G3OrderDetailController extends GetxController{
  DonDichVuProvider dichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuRequest? donDichVuRequest;

  @override
  void onInit() {
    super.onInit();
    donDichVuRequest = Get.arguments as DonDichVuRequest;
  }

  ///
  /// Lưu đơn
  ///
  void onSave(){
    EasyLoading.show(status:"Loading ...");
    Get.toNamed(AppRoutes.V1_FORMAL_PAYMENT, arguments: donDichVuRequest,);
    // dichVuProvider.add(data: donDichVuRequest!, onSuccess: (data){
    //   showSnackBar(title: "Tạo đơn dịch vụ thành công", message: "Chúng tôi sẽ phản hối sớm nhất có thể");
    //   Get.toNamed(AppRoutes.V1_FORMAL_PAYMENT, arguments: donDichVuRequest,);
    //   EasyLoading.dismiss();
    // }, onError: (onError){
    //   EasyLoading.dismiss();
    //   print("V1G3OrderDetailController onSave $onError");
    // });
  }

  void onNextPage(){
    onSave();
  }

}