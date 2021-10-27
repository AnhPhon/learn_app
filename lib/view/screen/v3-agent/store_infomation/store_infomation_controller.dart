import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/request/kho_hang_dai_ly_request.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/response/kho_hang_dai_ly_response.dart';
import 'package:template/data/model/response/mat_hang_dac_trung_response.dart';
import 'package:template/data/model/response/nhom_cua_hang_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/kho_hang_dai_ly_provider.dart';
import 'package:template/provider/mat_hang_dac_trung_provider.dart';
import 'package:template/provider/nhom_cua_hang_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V3StoreInfomationController extends GetxController {
  //image
  File? image;
  List<File> fileImageList = [];

  //name of company
  final nameController = TextEditingController();
  //legal Representative
  final legalRepresentativeController = TextEditingController();
  //phone
  final phoneController = TextEditingController();
  //email
  final emailController = TextEditingController();
  //address
  final addressController = TextEditingController();
  //start time range
  final startController = TextEditingController();
  //end time range
  final endController = TextEditingController();

  //user idd
  String userId = "";

  //TaiKhoan
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();
  TaiKhoanRequest taiKhoanRequest = TaiKhoanRequest();

  //NhomCuaHang
  NhomCuaHangProvider nhomCuaHangProvider = GetIt.I.get<NhomCuaHangProvider>();
  List<NhomCuaHangResponse> nhomCuaHangList = [];
  NhomCuaHangResponse? nhomCuaHangResponse;

  //MatHangDacTrung
  MatHangDacTrungProvider matHangDacTrungProvider =
      GetIt.I.get<MatHangDacTrungProvider>();
  List<MatHangDacTrungResponse?> matHangDacTrungList = [];
  List<String?> matHangDacTrungResponse = [];

  //TinhTp
  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  List<TinhTpResponse> tinhTpsList = [];
  List<TinhTpResponse> otherProvinces = [];
  //isWarehouse
  TinhTpResponse? hcmProvince;
  TinhTpResponse? otherProvince;
  TinhTpResponse? daNangProvince;
  TinhTpResponse? haNoiProvince;
  //rad address index
  int groupTinhTpValue = 0;

  //QuanHuyen
  QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  List<QuanHuyenResponse> quanHuyensList = [];
  List<QuanHuyenResponse> otherDistricts = [];
  QuanHuyenResponse? hcmHuyen;
  QuanHuyenResponse? daNangHuyen;
  QuanHuyenResponse? haNoiHuyen;
  QuanHuyenResponse? khacHuyen;

  //PhuongXa
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  List<PhuongXaResponse> phuongXasList = [];
  List<PhuongXaResponse> otherwards = [];
  PhuongXaResponse? hcmPhuong;
  PhuongXaResponse? daNangPhuong;
  PhuongXaResponse? haNoiPhuong;
  PhuongXaResponse? khacPhuong;

  //KhoHangDaiLy
  KhoHangDaiLyProvider khoHangDaiLyProvider =
      GetIt.I.get<KhoHangDaiLyProvider>();
  List<KhoHangDaiLyResponse> khoHangDaiLyList = [];
  KhoHangDaiLyResponse? khoHangDaiLyResponse;
  KhoHangDaiLyRequest khoHangDaiLyRequest = KhoHangDaiLyRequest();

  //list khohang model
  List<KhoHangModel> khoHangModelList = [];

  //ImageUpdate
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  List<String> urlImage = [];

  //accept
  Map<String, String> boolAccept = {
    "0": "Không",
    "1": "Có",
  };

  //title appbar
  String title = "Thông tin cửa hàng";

  //note
  String note =
      "Nếu địa điểm kho hàng nằm ở vị trí khác (hoặc tỉnh khác) cửa hàng chính thì cập nhật thêm địa chỉ để tính toán cước vận chuyển";

  //CircularProgressIndicator
  bool isLoading = true;
  bool isLoadingAdd = false;

  bool isLoadingWarehouse = true;

  //warehouse list
  List<Widget> warehouseList = [];

  @override
  void onInit() {
    super.onInit();
    //get load data
    getUserInfomation();
  }

  @override
  void onClose() {
    nameController.dispose();
    legalRepresentativeController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    startController.dispose();
    endController.dispose();
    super.onClose();
  }

  ///
  ///get user infomation
  ///
  Future<void> getUserInfomation() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //getMatHangDacTrung
    getMatHangDacTrung();

    //getNhomCuaHang
    getNhomCuaHang();

    //getTinhTp
    getTinhTp();

    //getKhoHang
    getKhoHangDaiLy();
  }

  ///
  ///get kho hang
  ///
  void getKhoHangDaiLy() {
    isLoadingAdd = true;
    khoHangDaiLyProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTaiKhoan=$userId",
      onSuccess: (value) {
        if (value.isNotEmpty) {
          khoHangDaiLyList = value;
          khoHangModelList =
              List<KhoHangModel>.generate(khoHangDaiLyList.length, (index) {
            return KhoHangModel(
              idKhoHang: khoHangDaiLyList[index].id,
              warehouseAddress: TextEditingController(),
              warehouseName: TextEditingController(),
            );
          });
          for (var i = 0; i < value.length; i++) {
            //mapping tinhTpWarehouse
            khoHangModelList[i].tinhTpResponse = tinhTpsList[tinhTpsList
                .indexWhere((element) => element.id == value[i].idTinhTp!.id)];
            khoHangModelList[i].tinhTpList = tinhTpsList;

            //mapping name & address
            khoHangModelList[i].warehouseAddress!.text =
                value[i].diaChi.toString();
            khoHangModelList[i].warehouseName!.text = value[i].ten.toString();

            //mapping quanHuyenWareHouse
            getQuanHuyen(
                idTinhTp: value[i].idTinhTp!.id.toString(),
                indexWarehouse: i,
                isWarehouse: true);

            //mapping phuongXaWareHouse
            getPhuongXa(
                idQuanHuyen: value[i].idQuanHuyen!.id.toString(),
                indexWarehouse: i,
                isWarehouse: true);
          }
        }
        isLoadingAdd = false;
        update();
      },
      onError: (error) {
        print("V3StoreInfomationController getKhoHangDaiLy onError $error");
      },
    );
  }

  ///
  ///get NhomCuaHang
  ///
  void getNhomCuaHang() {
    nhomCuaHangProvider.all(
      onSuccess: (value) {
        nhomCuaHangList = value;

        //check nhomCuaHangResponse already exits
        if (value.indexWhere((element) =>
                element.id == taiKhoanResponse.idNhomCuaHang!.id) !=
            -1) {
          //binding nhomCuaHangResponse
          nhomCuaHangResponse = value[value.indexWhere(
              (element) => element.id == taiKhoanResponse.idNhomCuaHang!.id)];
        }

        update();
      },
      onError: (error) {
        print("V3StoreInfomationController getNhomCuaHang onError $error");
      },
    );
  }

  ///
  ///get MatHangDacTrung
  ///
  void getMatHangDacTrung() {
    matHangDacTrungProvider.all(
      onSuccess: (value) {
        matHangDacTrungList = value;
        update();

        //get user infomation
        taiKhoanProvider
            .find(
          id: userId,
          onSuccess: (value) {
            //binding data TextEditingController
            taiKhoanResponse = value;
            nameController.text = value.hoTen.toString();
            legalRepresentativeController.text = value.tenPhapLy.toString();
            phoneController.text = value.soDienThoai.toString();
            emailController.text = value.email ?? "";
            addressController.text = value.diaChi.toString();

            value.idMatHangDacTrungs!
                .map((e) => matHangDacTrungResponse.add(e.id))
                .toList();
            print('phuong ${matHangDacTrungResponse[0]!.toString()}');
            print('phuong 1 ${matHangDacTrungList[0]!.toString()}');
            update();
          },
          onError: (error) {
            print(
                "V3StoreInfomationController getUserInfomation onError $error");
          },
        )
            .then(
          (value) {
            isLoading = false;
            update();
          },
        );
      },
      onError: (error) {
        print("V3StoreInfomationController getMatHangDacTrung onError $error");
      },
    );
  }

  ///
  ///get TinhTp
  ///
  void getTinhTp() {
    tinhTpProvider.all(
      onSuccess: (value) {
        tinhTpsList.addAll(value);
        otherProvinces.addAll(value);
        if (groupTinhTpValue == 0) {
          hcmProvince = tinhTpsList
              .firstWhere((element) => element.ten!.contains("Hồ Chí Minh"));
          getQuanHuyen(idTinhTp: hcmProvince!.id!);
        } else if (groupTinhTpValue == 1) {
          haNoiProvince = tinhTpsList
              .firstWhere((element) => element.ten!.contains("Hà Nội"));
          getQuanHuyen(idTinhTp: haNoiProvince!.id!);
        } else if (groupTinhTpValue == 2) {
          daNangProvince = tinhTpsList
              .firstWhere((element) => element.ten!.contains("Đà Nẵng"));
          getQuanHuyen(idTinhTp: daNangProvince!.id!);
        } else {
          otherProvince = null;
        }

        update();
      },
      onError: (error) {
        print("V3StoreInfomationController getTinhTp onError $error");
      },
    );
  }

  ///
  ///get QuanHuyen
  ///
  void getQuanHuyen({
    required String idTinhTp,
    bool? isWarehouse = false,
    int? index = -1,
    int? indexWarehouse = -1,
  }) {
    quanHuyenProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTinhTp=$idTinhTp",
      onSuccess: (value) {
        //is not Warehouse
        if (isWarehouse == false) {
          if (groupTinhTpValue != 3) {
            hcmHuyen = null;
            hcmPhuong = null;
            quanHuyensList.clear();
            phuongXasList.clear();
            if (value.isNotEmpty) {
              quanHuyensList.addAll(value);
            }
            update();
          } else {
            khacHuyen = null;
            khacPhuong = null;
            otherDistricts.clear();
            otherDistricts.addAll(value);
            update();
          }
        } else {
          if (index != -1) {
            //isWarehouse
            khoHangModelList[index!].quanHuyenList = value;
          }
        }
        if (indexWarehouse != -1) {
          //mapping warehouse quanHUyen
          khoHangModelList[indexWarehouse!].quanHuyenList = value;
          khoHangModelList[indexWarehouse].quanHuyenResponse =
              khoHangModelList[indexWarehouse].quanHuyenList![
                  khoHangModelList[indexWarehouse].quanHuyenList!.indexWhere(
                      (element) =>
                          element.id ==
                          khoHangDaiLyList[indexWarehouse].idQuanHuyen!.id)];
        }

        update();
      },
      onError: (error) {
        print("V3StoreInfomationController getQuanHuyen onError $error");
      },
    );
  }

  ///
  ///get PhuongXa
  ///
  void getPhuongXa({
    required String idQuanHuyen,
    bool? isWarehouse = false,
    int? index = -1,
    int? indexWarehouse = -1,
  }) {
    phuongXaProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idQuanHuyen=$idQuanHuyen",
      onSuccess: (value) {
        //is not Warehouse
        if (isWarehouse == false) {
          if (groupTinhTpValue != 3) {
            hcmPhuong = null;
            phuongXasList.clear();
            if (value.isNotEmpty) {
              phuongXasList.addAll(value);
            }
            update();
          } else {
            khacPhuong = null;
            otherwards.clear();
            otherwards.addAll(value);
            update();
          }
        } else {
          if (index != -1) {
            //isWarehouse
            khoHangModelList[index!].phuongXaList = value;
          }
        }
        if (indexWarehouse != -1) {
          //mapping warehouse phuongXa
          khoHangModelList[indexWarehouse!].phuongXaList = value;
          khoHangModelList[indexWarehouse].phuongXaResponse =
              khoHangModelList[indexWarehouse].phuongXaList![
                  khoHangModelList[indexWarehouse].phuongXaList!.indexWhere(
                      (element) =>
                          element.id ==
                          khoHangDaiLyList[indexWarehouse].idPhuongXa!.id)];
        }
        if (indexWarehouse == khoHangDaiLyList.length - 1) {
          isLoadingWarehouse = false;
        }
        update();
      },
      onError: (error) {
        print("V3StoreInfomationController getPhuongXa onError $error");
      },
    );
  }

  ///
  ///get KhoHang
  ///
  void getKhoHang() {
    khoHangDaiLyProvider.paginate(
      page: 1,
      limit: 5,
      filter: "&idTaiKhoan=$userId",
      onSuccess: (value) {
        khoHangDaiLyList = value;
      },
      onError: (error) {
        print("V3StoreInfomationController getKhoHang onError $error");
      },
    );
  }

  ///
  ///on selected NhomCuaHang
  ///
  void onSelectedNhomCuaHang({required NhomCuaHangResponse value}) {
    nhomCuaHangResponse = value;
    update();
  }

  ///
  ///on selected lamChieuThuBay
  ///
  void onSelectedLamChieuThuBay({required String value}) {
    taiKhoanResponse.lamChieuThuBay = value;
    update();
  }

  ///
  ///on selected lamNgayChuNhat
  ///
  void onSelectedLamNgayChuNhat({required String value}) {
    taiKhoanResponse.lamNgayChuNhat = value;
    update();
  }

  ///
  /// Thay đổi radio button
  ///
  void onChangedGroup(int val) {
    groupTinhTpValue = val;
    getTinhTp();
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    if (groupTinhTpValue == 3) {
      otherProvince = tinhTp;
    } else if (groupTinhTpValue == 2) {
      daNangProvince = tinhTp;
    } else if (groupTinhTpValue == 1) {
      haNoiProvince = tinhTp;
    } else {
      hcmProvince = tinhTp;
    }

    getQuanHuyen(idTinhTp: tinhTp.id!);
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen) {
    if (groupTinhTpValue == 3) {
      khacHuyen = quanHuyen;
    } else if (groupTinhTpValue == 2) {
      daNangHuyen = quanHuyen;
    } else if (groupTinhTpValue == 1) {
      haNoiHuyen = quanHuyen;
    } else {
      hcmHuyen = quanHuyen;
    }

    getPhuongXa(idQuanHuyen: quanHuyen.id!);
    update();
  }

  ///
  ///Thay đổi PhuongXa
  ///
  void onChangedPhuongXa(PhuongXaResponse phuongXa) {
    if (groupTinhTpValue == 3) {
      khacPhuong = phuongXa;
    } else if (groupTinhTpValue == 2) {
      daNangPhuong = phuongXa;
    } else if (groupTinhTpValue == 1) {
      haNoiPhuong = phuongXa;
    } else {
      hcmPhuong = phuongXa;
    }

    update();
  }

  ///
  ///btn click add warehouse address
  ///
  void onClickWareHouseAdd() {
    isLoadingAdd = true;
    khoHangModelList.add(KhoHangModel(
      tinhTpList: tinhTpsList,
      quanHuyenList: [],
      phuongXaList: [],
      warehouseAddress: TextEditingController(),
      warehouseName: TextEditingController(),
    ));
    isLoadingAdd = false;
    update();
  }

  ///
  ///Thay đổi tỉnh thành IsWarehouse
  ///
  void onChangedTinhThanhIsWarehouse(TinhTpResponse tinhTp, int index) {
    //clear data
    khoHangModelList[index].quanHuyenResponse = null;
    khoHangModelList[index].quanHuyenList!.clear();
    khoHangModelList[index].phuongXaResponse = null;
    khoHangModelList[index].phuongXaList!.clear();

    //set data
    khoHangModelList[index].tinhTpResponse = tinhTp;
    update();

    //getQuanHuyen
    getQuanHuyen(idTinhTp: tinhTp.id!, isWarehouse: true, index: index);
    update();
  }

  ///
  ///Thay đổi quận huyện IsWarehouse
  ///
  void onChangedQuanHuyenIsWarehouse(QuanHuyenResponse quanHuyen, int index) {
    //clear data
    khoHangModelList[index].phuongXaResponse = null;
    khoHangModelList[index].phuongXaList!.clear();

    //set data
    khoHangModelList[index].quanHuyenResponse = quanHuyen;
    update();

    //getPhuongXa
    getPhuongXa(idQuanHuyen: quanHuyen.id!, isWarehouse: true, index: index);
    update();
  }

  ///
  ///Thay đổi PhuongXa IsWarehouse
  ///
  void onChangedPhuongXaIsWarehouse(PhuongXaResponse phuongXa, int index) {
    print(index);
    //set data
    khoHangModelList[index].phuongXaResponse = phuongXa;
    update();
  }

  ///
  ///on delete warehouse
  ///
  void onDeleteWarehouse({required int index}) {
    //check is not empty
    if (khoHangModelList[index].idKhoHang != null) {
      khoHangDaiLyProvider.delete(
        id: khoHangModelList[index].idKhoHang.toString(),
        onSuccess: (data) {
          print("Xoá kho hàng thành công");
        },
        onError: (error) {
          print("V3StoreInfomationController onDeleteWarehouse onError $error");
        },
      );
    }
    khoHangModelList.removeAt(index);
    update();
  }

  ///
  ///pick image
  ///
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      this.image = imageTemporary;

      //add file image to list
      fileImageList.add(imageTemporary);

      //uploadImage
      uploadImage(image: imageTemporary);
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  ///
  ///upload image
  ///
  void uploadImage({required File image}) {
    imageUpdateProvider.add(
      file: image,
      onSuccess: (value) {
        urlImage.add(value.data.toString());
      },
      onError: (error) {
        print("V3StoreInfomationController uploadImage onError $error");
      },
    );
  }

  ///
  ///btn update
  ///
  void btnUpdate(BuildContext context) {
    //validate
    if (nameController.text.isEmpty) {
      Alert.error(message: 'Trường tên không được để trống');
      return;
    } else if (legalRepresentativeController.text.isEmpty) {
      Alert.error(message: 'Trường tên đại diện pháp lý');
      return;
    } else if (phoneController.text.isEmpty) {
      Alert.error(message: 'Trường số điện thoại không được để trống');
      return;
    } else if (emailController.text.isEmpty) {
      Alert.error(message: 'Trường email không được để trống');
      return;
    } else if (nhomCuaHangResponse == null) {
      Alert.error(message: 'Trường nhóm không được để trống');
      return;
    } else if (matHangDacTrungResponse.isEmpty) {
      Alert.error(message: 'Trường mặt hàng đặc trưng không được để trống');
      return;
    } else if (hcmProvince == null &&
        otherProvince == null &&
        haNoiProvince == null &&
        daNangProvince == null) {
      Alert.error(
          message: 'Trường địa điểm cửa hàng chính không được để trống');
      return;
    } else if (hcmHuyen == null &&
        khacHuyen == null &&
        haNoiHuyen == null &&
        daNangHuyen == null) {
      Alert.error(
          message: 'Trường địa điểm cửa hàng chính không được để trống');
      return;
    } else if (hcmPhuong == null &&
        khacPhuong == null &&
        haNoiPhuong == null &&
        daNangPhuong == null) {
      Alert.error(
          message: 'Trường địa điểm cửa hàng chính không được để trống');
      return;
    } else if (startController.text.isEmpty || endController.text.isEmpty) {
      Alert.error(
          message: 'Trường thời gian làm việc trong ngày không được để trống');
      return;
    } else if (double.parse(
            timeDiff(startController.text, endController.text)) <
        0) {
      Alert.error(message: 'Thời gian kết thúc phải lớn hơn thời gian bắt đầu');
      return;
    } else if (khoHangModelList.isNotEmpty) {
      //show loading
      EasyLoading.show(status: 'loading...');

      //set data
      taiKhoanRequest.id = userId;
      taiKhoanRequest.hoTen = nameController.text;
      taiKhoanRequest.tenPhapLy = legalRepresentativeController.text;
      taiKhoanRequest.soDienThoai = phoneController.text;
      taiKhoanRequest.email = emailController.text;
      taiKhoanRequest.idNhomCuaHang = nhomCuaHangResponse!.id;
      taiKhoanRequest.idMatHangDacTrungs!.addAll(matHangDacTrungResponse as List<String>);
      // matHangDacTrungResponse.map((e) => e.toString()).toList();

      taiKhoanRequest.diaDiemCuThe = addressController.text;
      taiKhoanRequest.thoiGianLamViec =
          "${timeDiff(startController.text, endController.text)} giờ";

      taiKhoanRequest.lamChieuThuBay = taiKhoanResponse.lamChieuThuBay;
      taiKhoanRequest.lamNgayChuNhat = taiKhoanResponse.lamNgayChuNhat;
      taiKhoanRequest.hinhAnhCuaHangs = urlImage;

      //set data store address
      if (groupTinhTpValue == 3) {
        taiKhoanRequest.diaDiemCuaHangChinh =
            "$otherProvince, $khacHuyen, $khacPhuong";
      } else if (groupTinhTpValue == 2) {
        taiKhoanRequest.diaDiemCuaHangChinh =
            "$daNangProvince, $daNangHuyen, $daNangPhuong";
      } else if (groupTinhTpValue == 1) {
        taiKhoanRequest.diaDiemCuaHangChinh =
            "$haNoiProvince, $haNoiHuyen, $haNoiPhuong";
      } else {
        taiKhoanRequest.diaDiemCuaHangChinh =
            "$hcmProvince, $hcmHuyen, $hcmPhuong";
      }

      //set data
      khoHangDaiLyRequest.idTaiKhoan = userId;

      for (var i = 0; i < khoHangModelList.length; i++) {
        //validate warehouse
        if (khoHangModelList[i].tinhTpResponse == null ||
            khoHangModelList[i].quanHuyenResponse == null ||
            khoHangModelList[i].phuongXaResponse == null ||
            khoHangModelList[i].warehouseAddress!.text.isEmpty ||
            khoHangModelList[i].warehouseName!.text.isEmpty) {
          EasyLoading.dismiss();
          Alert.error(
              message: 'Trường địa điểm kho hàng ${i + 1} không được để trống');
          return;
        }
        //set data
        khoHangDaiLyRequest.idTinhTp = khoHangModelList[i].tinhTpResponse!.id;
        khoHangDaiLyRequest.idQuanHuyen =
            khoHangModelList[i].quanHuyenResponse!.id;
        khoHangDaiLyRequest.idPhuongXa =
            khoHangModelList[i].phuongXaResponse!.id;
        khoHangDaiLyRequest.diaChi = khoHangModelList[i].warehouseAddress!.text;
        khoHangDaiLyRequest.ten = khoHangModelList[i].warehouseName!.text;
        khoHangDaiLyRequest.id = khoHangModelList[i].idKhoHang;
        //if warehouse already exits
        if (khoHangModelList[i].idKhoHang != null) {
          //set data

          //update warehouse already exits
          khoHangDaiLyProvider.update(
            data: khoHangDaiLyRequest,
            onSuccess: (khoHangDaiLyUpdate) {
              ////show dialog
              if (khoHangModelList[i] == khoHangModelList.last) {
                //update taiKhoan
                taiKhoanProvider.update(
                  data: taiKhoanRequest,
                  onSuccess: (value) {},
                  onError: (error) {
                    EasyLoading.dismiss();
                    print(
                        "V3StoreInfomationController btnUpdate onError $error");
                  },
                );
                EasyLoading.dismiss();
                Get.back();
                Alert.success(message: 'Cập nhật thông tin thành công');
              }
            },
            onError: (error) {
              EasyLoading.dismiss();
              print(
                  "V3StoreInfomationController khoHangDaiLyUpdate onError $error");
            },
          );
        } else {
          //add khoHang
          khoHangDaiLyProvider.add(
            data: khoHangDaiLyRequest,
            onSuccess: (khoHang) {
              ////show dialog
              if (khoHangModelList[i] == khoHangModelList.last) {
                //update taiKhoan
                taiKhoanProvider.update(
                  data: taiKhoanRequest,
                  onSuccess: (value) {},
                  onError: (error) {
                    EasyLoading.dismiss();
                    print(
                        "V3StoreInfomationController btnUpdate onError $error");
                  },
                );
                EasyLoading.dismiss();
                Get.back();
                Alert.success(message: 'Cập nhật thông tin thành công');
              }
            },
            onError: (error) {
              EasyLoading.dismiss();
              print("V3StoreInfomationController btnUpdate onError $error");
            },
          );
        }
      }
    }
  }

  ///
  ///convert string to timeOfDay
  ///
  String timeDiff(String tod0, String tod1) {
    final format = DateFormat.jm(); //"6:00 AM"
    final timeFormat0 = TimeOfDay.fromDateTime(format.parse(tod0));
    final timeFormat1 = TimeOfDay.fromDateTime(format.parse(tod1));
    return ((abc(timeFormat1) - abc(timeFormat0)).toStringAsFixed(2))
        .toString();
  }

  double abc(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
}

class KhoHangModel {
  String? idKhoHang;
  TextEditingController? warehouseAddress = TextEditingController();
  TextEditingController? warehouseName = TextEditingController();
  TinhTpResponse? tinhTpResponse;
  QuanHuyenResponse? quanHuyenResponse;
  PhuongXaResponse? phuongXaResponse;
  List<TinhTpResponse>? tinhTpList;
  List<QuanHuyenResponse>? quanHuyenList;
  List<PhuongXaResponse>? phuongXaList;
  KhoHangModel({
    this.idKhoHang,
    this.warehouseAddress,
    this.warehouseName,
    this.tinhTpResponse,
    this.quanHuyenResponse,
    this.phuongXaResponse,
    this.tinhTpList,
    this.quanHuyenList,
    this.phuongXaList,
  });
}
