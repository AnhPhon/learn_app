import 'package:get/get.dart';
import 'package:template/routes/route_path/account_routes.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/routes/route_path/account_management_routers.dart';
import 'package:template/routes/route_path/account_routes.dart';
import 'package:template/routes/route_path/contract_list_routers.dart';
import 'package:template/routes/route_path/my_order_routes.dart';
import 'package:template/routes/route_path/refer_friends_routers.dart';
import 'package:template/routes/route_path/voucher_routers.dart';
import 'package:template/view/screen/home/home_page.dart';

class AccountController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///Go to Account Information
  ///
  void onToAccountInformation() {
    Get.toNamed(AccountRoutes.ACCOUNT_INFOMATION);
  }

  ///
  ///Go to Account Managements
  ///
  void goToAccountManagements() {
    Get.toNamed(AccountManagementRouter.ACCOUNT_MANAGEMENT);
  }

  ///
  ///Go to Voucher
  ///
  void goToVoucher() {
    Get.toNamed(VoucherRouters.VOUCHER);
  }

  void onToCapitalContribution(){
    Get.toNamed(AccountRoutes.CAPITAL_CONTRIBUTION);
  }

  void onToCapitalWithdDrawal(){
    Get.toNamed(AccountRoutes.CONTRACT_DETAIL);
  }

  
  ///
  ///Go to Refer Friend page
  ///
  void goToRefeFriend() {
    Get.toNamed(ReferFriendsRouters.REFER_FRIENDS);
  }

  ///
  ///Go to My Order
  ///
  void goToMyOrder() {
    Get.toNamed(MyOrderRouter.MY_ORDER);
  }

  ///
  ///Go to Contract List
  ///
  void goToContractList() {
    Get.toNamed(ContractListRouters.CONTRACT_LIST);
  }
}
