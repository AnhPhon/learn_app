import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/account_management_routers.dart';

class RechargeController extends GetxController {
  //Khai báo isLoading
  bool isLoading = false;

  //Khai báo bool obscure
  bool obscure = true;

  //Khai báo số dư tài khoản
  String accountBalance = "20000000000";

  //Khai báo obscure
  String obscureCharacters = "************";

  //Khai báo sô tiền ở ví
  MoneyMaskedTextController walletBalanceController = MoneyMaskedTextController(
    precision: 0,
    decimalSeparator: '',
  );

  final moneyDraw = IZIInput(
    disbleError: true,
    borderSize: 2,
    isLegend: true,
    label: "Số tiền cần rút",
    isBorder: true,
    min: 0,
    type: IZIInputType.PRICE,
  );

  //Khai báo valRadio
  int groupValue = 1;

  //Khai báo list default amount
  List<String> defaultAmountList = [
    "100.000đ",
    "200.000đ",
    "500.000đ",
  ];

  //Khai báo số tiền rút
  String? withdrawalAmount;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    walletBalanceController.updateValue(99000000000);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    walletBalanceController.dispose();
    super.onClose();
  }

  ///
  ///Change obscure ví của tôi
  ///
  void onChangedIsVisible() {
    obscure = false;
    update();
  }

  ///
  ///Change obscure ví của tôi
  ///
  void onChangedNoVisible() {
    obscure = true;
    update();
  }

  ///
  /// OnTap set Default Amount
  ///
  void setDefaultAmount({required int index}) {
    moneyDraw.newValue = IZINumber.parseDouble(defaultAmountList[index].replaceAll('.', '').replaceAll('đ', ''));
    moneyDraw.onSetValue!();
    update();
  }

  ///
  ///Go to Bank Stansfer
  ///
  void goToBankStransfer() {
    Get.toNamed(AccountManagementRouter.BANK_TRANSFER)!.then((value) {
      if (!IZIValidate.nullOrEmpty(value) && value == true) {
        onInit();
        update();
      }
    });
    update();
  }

  void onChangedRadio(int? val) {
    groupValue = val!;
    update();
  }
}
