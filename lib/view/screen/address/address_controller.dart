import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/district_model.dart';
import 'package:template/data/model/body/province_model.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class AddressController extends GetxController {
  GetIt sl = GetIt.instance;

  ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  DistrictProvider districtProvider = GetIt.I.get<DistrictProvider>();
  UserProvider userProvider = GetIt.I.get<UserProvider>();

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

  bool isReloadData = false;

  @override
  void onClose() {
    super.onClose();
    addressController.dispose();
    wardController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    getProvince();
    provinceModelList.clear();
    districtModelList.clear();
  }

  ///
  ///get province
  ///
  void getProvince() {
    districtList.clear();
    districtModelList.clear();
    provinceProvider.all(onSuccess: (value) {
      provinceModelList = value;
      provinceModelList
          .map((province) => provinceList.add(province.name!))
          .toList();
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }

  ///
  ///get district
  ///
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

  ///
  ///set selected province
  ///
  void setSelectedProvince(String? value) {
    province = value;
    final indexProvince = provinceModelList
        .indexWhere((element) => element.name!.trim() == value!.trim());
    idProvince = provinceModelList[indexProvince].id;
    getDistrict(idProvince!);
    update();
  }

  ///
  ///set selected district
  ///
  void setSelectedDistrict(String? value) {
    district = value;
    final indexDistrict =
        districtModelList.indexWhere((element) => element.name == value);
    idDistrict = districtModelList[indexDistrict].id;
    update();
  }

  ///
  ///save address
  ///
  void changeAddress() {
    isReloadData = true;
    if (province!.isEmpty ||
        district!.isEmpty ||
        wardController.text.isEmpty ||
        addressController.text.isEmpty) {
      Get.snackbar("Thất bại!", "Vui lòng nhập đủ các trường",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      print("addressController.text: ${addressController.text}");
      sl.get<SharedPreferenceHelper>().saveProvinceId(idProvince!);
      sl.get<SharedPreferenceHelper>().saveDistrictId(idDistrict!);
      sl.get<SharedPreferenceHelper>().saveAddress(addressController.text);

      // update address
      // userProvider.update(data: data, onSuccess: onSuccess, onError: onError);

      //back to cart
      Get.back(result: isReloadData);
    }
  }
}
