import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/kho_hang_dai_ly_provider.dart';
import 'package:template/provider/mat_hang_dac_trung_provider.dart';
import 'package:template/provider/nhom_cua_hang_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/snack_bar.dart';
import 'package:template/view/basewidget/animated_custom_dialog.dart';
import 'package:template/view/basewidget/my_dialog.dart';

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
  //warehouse address list
  List<TextEditingController> warehouseController = [];

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
  List<MatHangDacTrungResponse?> matHangDacTrungResponse = [];

  //TinhTp
  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  List<TinhTpResponse> tinhTpList = [];
  //isWarehouse
  List<TinhTpResponse> tinhTpListIsWareHouse = [];
  TinhTpResponse? tinhTpStore;
  List<TinhTpResponse?> tinhTpWarehouse = [];
  //rad address index
  int groupTinhTpValue = 0;

  //QuanHuyen
  QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  List<QuanHuyenResponse> quanHuyenList = [];
  //isWarehouse
  List<List<QuanHuyenResponse>> quanHuyenListIsWareHouse = [];
  QuanHuyenResponse? quanHuyenStore;
  List<QuanHuyenResponse?> quanHuyenWarehouse = [];

  //PhuongXa
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  List<PhuongXaResponse> phuongXaList = [];
  //isWarehouse
  List<List<PhuongXaResponse>> phuongXaListIsWareHouse = [];
  PhuongXaResponse? phuongXaStore;
  List<PhuongXaResponse?> phuongXaWarehouse = [];

  //KhoHangDaiLy
  KhoHangDaiLyProvider khoHangDaiLyProvider =
      GetIt.I.get<KhoHangDaiLyProvider>();
  List<KhoHangDaiLyResponse> khoHangDaiLyList = [];
  KhoHangDaiLyResponse? khoHangDaiLyResponse;
  KhoHangDaiLyRequest khoHangDaiLyRequest = KhoHangDaiLyRequest();

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
    super.onClose();
    nameController.dispose();
    legalRepresentativeController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    startController.dispose();
    endController.dispose();
    warehouseController.clear();
  }

  ///
  ///get user infomation
  ///
  Future<void> getUserInfomation() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

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

        // matHangDacTrungResponse = value.idMatHangDacTrungs;

        //getNhomCuaHang
        getNhomCuaHang();

        //getMatHangDacTrung
        getMatHangDacTrung();

        //getTinhTp
        getTinhTp();
        getTinhTp(isWarehouse: true);

        //getKhoHangDaiLy
        // getKhoHangDaiLy();

        //getKhoHang
        getKhoHang();
      },
      onError: (error) {
        print("V3StoreInfomationController getUserInfomation onError $error");
      },
    )
        .then(
      (value) {
        isLoading = false;
        update();
      },
    );
  }

  ///
  ///get kho hang
  ///
  // void getKhoHangDaiLy() {
  //   khoHangDaiLyProvider.paginate(
  //     page: 1,
  //     limit: 100,
  //     filter: "&idTaiKhoan=$userId",
  //     onSuccess: (value) {
  //       if (value.isNotEmpty) {
  //         for (var i = 0; i < value.length; i++) {
  //           tinhTpWarehouse.add(tinhTpListIsWareHouse[tinhTpListIsWareHouse
  //               .indexWhere((element) => element.id == value[i].idTinhTp!.id)]);
  //           quanHuyenListIsWareHouse.add([]);
  //         }
  //       }

  //       update();
  //     },
  //     onError: (error) {
  //       print("V3StoreInfomationController getKhoHangDaiLy onError $error");
  //     },
  //   );
  // }

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
      },
      onError: (error) {
        print("V3StoreInfomationController getMatHangDacTrung onError $error");
      },
    );
  }

  ///
  ///get TinhTp
  ///
  void getTinhTp({bool? isWarehouse = false}) {
    tinhTpProvider.all(
      onSuccess: (value) {
        //is not Warehouse
        if (isWarehouse == false) {
          tinhTpList.clear();
          tinhTpList.addAll(value);
          if (groupTinhTpValue == 0) {
            tinhTpStore = tinhTpList
                .firstWhere((element) => element.ten!.contains("Hồ Chí Minh"));
            getQuanHuyen(idTinhTp: tinhTpStore!.id!);
          } else if (groupTinhTpValue == 1) {
            tinhTpStore = tinhTpList
                .firstWhere((element) => element.ten!.contains("Hà Nội"));
            getQuanHuyen(idTinhTp: tinhTpStore!.id!);
          } else if (groupTinhTpValue == 2) {
            tinhTpStore = tinhTpList
                .firstWhere((element) => element.ten!.contains("Đà Nẵng"));
            getQuanHuyen(idTinhTp: tinhTpStore!.id!);
          } else {
            tinhTpStore = null;
          }
        } else {
          //isWarehouse
          tinhTpListIsWareHouse = value;
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
  }) {
    quanHuyenProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTinhTp=$idTinhTp",
      onSuccess: (value) {
        //is not Warehouse
        if (isWarehouse == false) {
          quanHuyenStore = null;
          phuongXaStore = null;
          quanHuyenList.clear();
          phuongXaList.clear();
          if (value.isNotEmpty) {
            quanHuyenList.addAll(value);
          }
        } else {
          if (index != -1) {
            //isWarehouse
            quanHuyenListIsWareHouse[index!] = value;
          }
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
  }) {
    phuongXaProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idQuanHuyen=$idQuanHuyen",
      onSuccess: (value) {
        //is not Warehouse
        if (isWarehouse == false) {
          phuongXaList = value;
        } else {
          if (index != -1) {
            //isWarehouse
            phuongXaListIsWareHouse[index!] = value;
          }
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
    tinhTpStore = tinhTp;
    getQuanHuyen(idTinhTp: tinhTp.id!);
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen) {
    quanHuyenStore = quanHuyen;
    getPhuongXa(idQuanHuyen: quanHuyen.id!);
    update();
  }

  ///
  ///Thay đổi PhuongXa
  ///
  void onChangedPhuongXa(PhuongXaResponse phuongXa) {
    phuongXaStore = phuongXa;
    update();
  }

  ///
  ///btn click add warehouse address
  ///
  void onClickWareHouseAdd({required int index}) {
    isLoadingAdd = true;
    tinhTpWarehouse.add(null);
    quanHuyenWarehouse.add(null);
    phuongXaWarehouse.add(null);
    warehouseController.add(TextEditingController());
    quanHuyenListIsWareHouse.add([]);
    phuongXaListIsWareHouse.add([]);
    // warehouseList.add(widget);
    isLoadingAdd = false;
    update();
  }

  ///
  ///Thay đổi tỉnh thành IsWarehouse
  ///
  void onChangedTinhThanhIsWarehouse(TinhTpResponse tinhTp, int index) {
    tinhTpWarehouse[index] = tinhTp;
    getQuanHuyen(idTinhTp: tinhTp.id!, isWarehouse: true, index: index);
    update();
  }

  ///
  ///Thay đổi quận huyện IsWarehouse
  ///
  void onChangedQuanHuyenIsWarehouse(QuanHuyenResponse quanHuyen, int index) {
    quanHuyenWarehouse[index] = quanHuyen;
    getPhuongXa(idQuanHuyen: quanHuyen.id!, isWarehouse: true, index: index);
    update();
  }

  ///
  ///Thay đổi PhuongXa IsWarehouse
  ///
  void onChangedPhuongXaIsWarehouse(PhuongXaResponse phuongXa, int index) {
    phuongXaWarehouse[index] = phuongXa;
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
    print("${timeDiff(startController.text, endController.text)} giờ");
    //validate
    if (nameController.text.isEmpty) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Trường tên không được để trống",
      );
    } else if (legalRepresentativeController.text.isEmpty) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Trường tên đại diện pháp lý",
      );
    } else if (phoneController.text.isEmpty) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Trường số điện thoại không được để trống",
      );
    } else if (emailController.text.isEmpty) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Trường email không được để trống",
      );
    } else if (nhomCuaHangResponse == null) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Trường nhóm không được để trống",
      );
    } else if (matHangDacTrungResponse.isEmpty) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Trường mặt hàng đặc trưng không được để trống",
      );
    } else if (phuongXaStore == null ||
        quanHuyenStore == null ||
        tinhTpStore == null) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Trường địa điểm cửa hàng chính không được để trống",
      );
    } else if (startController.text.isEmpty || endController.text.isEmpty) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Trường thời gian làm việc trong ngày không được để trống",
      );
    } else if (double.parse(
            timeDiff(startController.text, endController.text)) <
        0) {
      SnackBarUtils.showSnackBar(
        title: "Vui lòng kiểm tra lại",
        message: "Thời gian kết thúc phải lớn hơn thời gian bắt đầu",
      );
    } else if (warehouseList.isNotEmpty) {
      for (var i = 0; i < warehouseList.length; i++) {
        if (tinhTpWarehouse[i] == null ||
            quanHuyenWarehouse[i] == null ||
            phuongXaWarehouse[i] == null ||
            warehouseController[i].text.isEmpty) {
          SnackBarUtils.showSnackBar(
            title: "Vui lòng kiểm tra lại",
            message: "Trường địa điểm kho hàng $i không được để trống",
          );
        }
      }
    } else {
      //set data
      taiKhoanRequest.id = userId;
      taiKhoanRequest.hoTen = nameController.text;
      taiKhoanRequest.tenPhapLy = legalRepresentativeController.text;
      taiKhoanRequest.soDienThoai = phoneController.text;
      taiKhoanRequest.email = emailController.text;
      taiKhoanRequest.idNhomCuaHang = nhomCuaHangResponse!.id;
      // matHangDacTrungResponse.map((e) {
      //   taiKhoanRequest.idMatHangDacTrungs!.add(e!);
      // }).toList();
      taiKhoanRequest.idMatHangDacTrungs =
          matHangDacTrungResponse.cast<MatHangDacTrungResponse>();
      taiKhoanRequest.diaDiemCuaHangChinh =
          "$phuongXaStore, $quanHuyenStore, $tinhTpStore";
      taiKhoanRequest.diaDiemCuThe = addressController.text;
      taiKhoanRequest.thoiGianLamViec =
          "${timeDiff(startController.text, endController.text)} giờ";

      taiKhoanRequest.lamChieuThuBay = taiKhoanResponse.lamChieuThuBay;
      taiKhoanRequest.lamNgayChuNhat = taiKhoanResponse.lamNgayChuNhat;
      taiKhoanRequest.hinhAnhCuaHangs = urlImage;

      //update taiKhoan
      taiKhoanProvider.update(
        data: taiKhoanRequest,
        onSuccess: (value) {
          //set data
          khoHangDaiLyRequest.idTaiKhoan = userId;

          for (var i = 0; i < warehouseList.length; i++) {
            //set data
            khoHangDaiLyRequest.idTinhTp = tinhTpWarehouse[i]!.id;
            khoHangDaiLyRequest.idQuanHuyen = quanHuyenWarehouse[i]!.id;
            khoHangDaiLyRequest.idPhuongXa = phuongXaWarehouse[i]!.id;
            khoHangDaiLyRequest.diaChi = warehouseController[i].text;

            //add khoHang
            khoHangDaiLyProvider.add(
              data: khoHangDaiLyRequest,
              onSuccess: (khoHang) {
                ////show dialog
                showAnimatedDialog(
                  context,
                  const MyDialog(
                    icon: Icons.check,
                    title: "Hoàn tất",
                    description: "Cập nhật thông tin thành công",
                  ),
                  dismissible: false,
                  isFlip: true,
                );
              },
              onError: (error) {
                print("V3StoreInfomationController btnUpdate onError $error");
              },
            );
          }
        },
        onError: (error) {
          print("V3StoreInfomationController btnUpdate onError $error");
        },
      );
    }
  }

  ///
  ///convert string to timeOfDay
  ///
  String timeDiff(String tod0, String tod1) {
    final format = DateFormat.jm(); //"6:00 AM"
    final timeFormat0 = TimeOfDay.fromDateTime(format.parse(tod0));
    final timeFormat1 = TimeOfDay.fromDateTime(format.parse(tod1));
    return (abc(timeFormat1) - abc(timeFormat0)).toString();
  }

  double abc(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
}
