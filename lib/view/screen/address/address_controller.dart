import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/district_model.dart';
import 'package:template/data/model/body/province_model.dart';
import 'package:template/data/model/body/user_model.dart';
import 'package:template/provider/district_provider.dart';
import 'package:template/provider/province_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class AddressController extends GetxController {
  GetIt sl = GetIt.instance;

  ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  DistrictProvider districtProvider = GetIt.I.get<DistrictProvider>();
  UserProvider userProvider = GetIt.I.get<UserProvider>();

  final addressController = TextEditingController();

  String? province;
  String? district;

  String? idProvince;
  String? idDistrict;

  List<ProvinceModel> provinceModelList = [];
  List<DistrictModel> districtModelList = [];

  List<String> provinceList = [];
  List<String> districtList = [];

  UserModel userModel = UserModel();

  @override
  void onClose() {
    super.onClose();
    addressController.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    getProvince();
    provinceModelList.clear();
    districtModelList.clear();
  }

  ///
  ///get user info
  ///
  void getUserInfo() {
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userProvider.find(
          id: value!,
          onSuccess: (value) {
            userModel = value;
            update();
          },
          onError: (error) {
            print(error);
          });
    });
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
    if (province!.isEmpty ||
        district!.isEmpty ||
        addressController.text.isEmpty) {
      Get.snackbar("Thất bại!", "Vui lòng nhập đủ các trường",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      print("addressController.text: ${addressController.text}");

      // update address

      userProvider.update(
          data: UserModel(
            id: userModel.id,
            address: userModel.address,
            avatar: userModel.avatar,
            born: userModel.born,
            citizenIdentification: userModel.citizenIdentification,
            email: userModel.email,
            phone: userModel.phone,
            fullname: userModel.fullname,
            idOptionalRole: userModel.idOptionalRole,
            idRole: userModel.idRole,
            idUser: userModel.idUser,
            imageCitizenIdentification1: userModel.imageCitizenIdentification1,
            imageCitizenIdentification: userModel.imageCitizenIdentification,
            paymentProofImage: userModel.paymentProofImage,
            sex: userModel.sex,
            status: userModel.status,
            username: userModel.username,
            addressCurrent: userModel.addressCurrent,
            addressOrder: addressController.text,
            districtOrder: idDistrict,
            provinceOrder: idProvince,
          ),
          onSuccess: (value) {},
          onError: (error) {
            print(error);
          });
      update();
      //back to cart
      Get.back(result: true);
    }
  }
}
