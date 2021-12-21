import 'package:get/get.dart';

class DetailedProductInformationController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;

  //Khai báo isXemThem
  bool isReadMore = false;

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
  ///Void Xem them
  ///
  void xemThem() {
    isReadMore = true;
    update();
  }

  ///
  ///Void rút gọn
  ///
  void rutGon() {
    isReadMore = false;
    update();
  }
}
