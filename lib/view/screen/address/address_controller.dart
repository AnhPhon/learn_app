import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/district_model.dart';
import 'package:template/data/model/body/province_model.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/province_provider.dart';

class AddressController extends GetxController {
  ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  DistrictProvider districtProvider = GetIt.I.get<DistrictProvider>();

  final wardController = TextEditingController();
  final addressController = TextEditingController();

  String? province;
  String? district;

  String? idProvince;
  String? idDistrict;

  List<ProvinceModel> provinceModelList = [];
  List<DistrictModel> districtModelList = [];

  List<String> provinceList = [];
  List<String> districtList = [];

  @override
  void onInit() {
    super.onInit();
    getProvince();
  }

  @override
  void onClose() {
    super.onClose();
    wardController.dispose();
    addressController.dispose();
  }

  void getProvince() {
    provinceProvider.all(onSuccess: (value) {
      provinceModelList = value;
      provinceModelList
          .map((province) => provinceList.add(province.name!))
          .toList();
      print("provinceList.length: ${provinceList.length}");
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  void getDistrict(String id) {
    districtProvider.paginate(
        page: 1,
        limit: 100,
        filter: "idProvince=$id",
        onSuccess: (value) {
          districtModelList = value;
          districtModelList
              .map((district) => districtList.add(district.name!))
              .toList();
          update();
        },
        onError: (error) {
          print(error);
          update();
        });
  }

  void setSelectedProvince(String? value) {
    province = value;
    final indexProvince = provinceModelList
        .indexWhere((element) => element.name!.trim() == value!.trim());
    print("indexProvince: $indexProvince");
    idProvince = provinceModelList[indexProvince].id;
    getDistrict(idProvince!);
    update();
  }

  void setSelectedDistrict(String? value) {
    district = value;
    final indexDistrict =
        districtModelList.indexWhere((element) => element.name == value);
    idDistrict = districtModelList[indexDistrict].id;
    update();
  }
}
