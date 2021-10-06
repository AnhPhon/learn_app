import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class V1ShippingAddressController extends GetxController {
  final addressController = TextEditingController();

  String title = "Địa điểm nhận hàng";

  String? province;
  List<String> provinceList = [];
  String? district;
  List<String> districtList = [];
  String? ward;
  List<String> wardList = [];

  ///
  ///set selected province
  ///
  void setSelectedProvince(String? index) {}

  ///
  ///set selected province
  ///
  void setSelectedDistrict(String? index) {}

  ///
  ///set selected province
  ///
  void setSelectedWard(String? index) {}
}
