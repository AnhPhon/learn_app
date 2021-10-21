import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/vi_tien_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/vi_tien_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1PaymentAccountController extends GetxController {
  ViTienProvider viTienProvider = GetIt.I.get<ViTienProvider>();
  ViTienResponse viTienResponse = ViTienResponse();

  String title = "Tài khoản của bạn";

  String price = "";

  int amountOfPrice = 0;

  bool isLoading = true;

  bool isBuy = false;
  bool isInsurance = false;

  @override
  void onInit() {
    super.onInit();
    isBuy = (Get.parameters['isBuy'] != "null")
        ? Get.parameters['isBuy'] == "true"
        : isBuy;
    isInsurance = (Get.parameters['isInsurance'] != "null")
        ? Get.parameters['isInsurance'] == "true"
        : isInsurance;
    price = Get.parameters['amountOfMoney'].toString();

    getBalance();
  }

  ///
  ///get balance
  ///
  void getBalance() {
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      viTienProvider.paginate(
        page: 1,
        limit: 5,
        filter: "&idTaiKhoan=$userId",
        onSuccess: (value) {
          viTienResponse = value.first;
          amountOfPrice =
              int.parse(viTienResponse.tongTien.toString()) - int.parse(price);
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  ///on checkout click
  ///
  void onCheckoutClick() {
    Get.toNamed(
        "${AppRoutes.V1_PAYMENT_SUCCESS}?isBuy=$isBuy&isInsurance=$isInsurance");
  }

  ///
  ///go to recharge
  ///
  void onRechargeClick() {
    Get.toNamed(
        "${AppRoutes.V1_RECHARGE}??isBuy=$isBuy&isInsurance=$isInsurance");
  }
}
