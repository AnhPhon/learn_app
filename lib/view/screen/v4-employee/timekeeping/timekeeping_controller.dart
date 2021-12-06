import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ntp/ntp.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/data/model/request/cham_cong_request.dart';
import 'package:template/data/model/response/cham_cong_response.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/provider/du_an_nhan_vien_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';

class V4TimekeepingController extends GetxController {
  GetIt sl = GetIt.instance;

  //Chấm công Provider
  ChamCongProvider chamCongProvider = GetIt.I.get<ChamCongProvider>();
  List<ChamCongResponse> chamCongList = [];

  //Tỉnh/Tp Provider
  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();

  //Quận/Huyện Provider
  QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();

  //Phường/Xã Provider
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();

  //Dự án nhân viên Provider
  DuAnNhanVienProvider duAnNhanVienProvider =
      GetIt.I.get<DuAnNhanVienProvider>();

  //Tỉnh thành phố
  List<TinhTpResponse> tinhTps = [];
  TinhTpResponse? tinh;

  //Quận / Huyện
  List<QuanHuyenResponse> quanHuyenList = [];
  QuanHuyenResponse? quanHuyen;

  // Phường / Xã
  List<PhuongXaResponse> phuongXaList = [];
  PhuongXaResponse? phuongXa;

  // Dự án của nhân viên
  List<DuAnNhanVienResponse> duAnNhanVienList = [];
  DuAnNhanVienResponse? duAnNhanVien;

  //Khai báo isLoading
  bool isLoading = true;

  //Khai báo location
  String location = "";

  //Khai báo Thời gian chấm công phải trùng với thời gian hiện tại
  TextEditingController timekeeping = TextEditingController();

  //Khai báo TextEditingController của địa chỉ chấm công
  final addressController = TextEditingController();

  //Khai báo idUser
  String idUser = '';

  //Khai báo check phường xã null
  String? idPhuongXaNull;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    getTime();
    getTinhThanh();
    getDuAnNhanVien();
    _checkPermission();
  }

  ///
  ///Get time Server
  ///
  Future<void> getTime() async {
    final DateTime timeReal = await NTP.now();
    timekeeping =
        TextEditingController(text: DateConverter.formatDateTimeHHmm(timeReal));
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    addressController.dispose();
    super.onClose();
  }

  ///
  ///Thay đổi dự án nhân viên
  ///
  void onChangedDuAnNhanVien(DuAnNhanVienResponse duAnNhanVien) {
    this.duAnNhanVien = duAnNhanVien;
    update();
  }

  ///
  ///Load dự án của nhân viên
  ///
  void getDuAnNhanVien() {
    duAnNhanVienProvider.all(
      onSuccess: (value) {
        duAnNhanVienList.clear();
        if (value.isNotEmpty) {
          duAnNhanVienList.addAll(value);
          duAnNhanVien = duAnNhanVienList.first;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
        update();
      },
    );
  }

  ///
  ///_checkPermission
  ///
  Future<void> _checkPermission() async {
    //check permission
    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      getLocator();
    } else if (status == PermissionStatus.denied) {
      await openAppSettings();
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
  }

  ///
  ///Get Current Location
  ///
  Future<void> getLocator() async {
    // Nếu getLastKnownPosition trả về null thì sẽ lấy vị trí getCurrentPosition
    final lastPosition = await Geolocator.getLastKnownPosition();
    if (lastPosition != null) {
      location = "$lastPosition";
      update();
    } else {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      location =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      update();
    }

    isLoading = false;
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    tinh = tinhTp;
    getQuanHuyen(id: tinhTp.id);
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen) {
    this.quanHuyen = quanHuyen;
    getPhuongXa(id: quanHuyen.id);
    update();
  }

  ///
  ///Thay đổi phường xã
  ///
  void onChangedPhuongXa(PhuongXaResponse phuongXa) {
    this.phuongXa = phuongXa;
    update();
  }

  ///
  /// Load tất cả tỉnh thành phố
  ///
  void getTinhThanh() {
    tinhTpProvider.all(onSuccess: (data) {
      tinhTps.clear();
      if (data.isNotEmpty) {
        tinhTps.addAll(data);
      }
      isLoading = false;
      update();
    }, onError: (error) {
      print("TermsAndPolicyController getTermsAndPolicy onError $error");
      update();
    });
  }

  ///
  /// Load tất cả quận huyện
  ///
  void getQuanHuyen({String? id}) {
    quanHuyenProvider.paginate(
        filter: '&idTinhTp=$id',
        limit: 100,
        page: 1,
        onSuccess: (data) {
          quanHuyenList.clear();
          if (data.isNotEmpty) {
            quanHuyenList.addAll(data);
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        });
  }

  ///
  /// Load tất cả phường xã
  ///
  void getPhuongXa({String? id}) {
    phuongXaProvider.paginate(
        filter: '&idQuanHuyen=$id',
        limit: 100,
        page: 1,
        onSuccess: (data) {
          phuongXaList.clear();
          if (data.isNotEmpty) {
            phuongXaList.addAll(data);
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        });
  }

  ///
  /// Check rỗng
  ///
  bool validate() {
    if (duAnNhanVien == null) {
      IZIAlert.error(message: 'Vui lòng chọn địa điểm làm việc/văn phòng!');
      return false;
    }
    if (addressController.text.toString().isEmpty) {
      IZIAlert.error(message: 'Vui lòng nhập địa chỉ!');
      return false;
    }

    if (tinh == null) {
      IZIAlert.error(message: 'Vui lòng chọn Tỉnh/Tp!');
      return false;
    }
    if (quanHuyen == null) {
      IZIAlert.error(message: 'Vui lòng chọn Quận/Huyện!');
      return false;
    }
    if (phuongXa == null &&
        quanHuyen!.ten.toString().toLowerCase() != "hoàng sa") {
      IZIAlert.error(message: 'Vui lòng chọn Phường/Xã!');
      return false;
    }
    return true;
  }

  ///
  ///Chấm công
  ///
  Future<void> onChamCong() async {
    if (validate()) {
      //Kiểm tra thêm 1 lần nữa
      //check permission
      final status = await Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        EasyLoading.show(status: 'Loading...');

        //Lấy location
        // Nếu getLastKnownPosition trả về null thì sẽ lấy vị trí getCurrentPosition
        final lastPosition = await Geolocator.getLastKnownPosition();
        if (lastPosition != null) {
          location = "$lastPosition";
          update();
        } else {
          final position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          location =
              "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
          update();
        }
        final DateTime timeKeeping =
            DateConverter.convertStringToDatetimeddMMyyyy(timekeeping.text);
        if (phuongXa != null) {
          idPhuongXaNull = phuongXa!.id;
          update();
        } else {
          idPhuongXaNull = null;
        }
        chamCongProvider.add(
          data: ChamCongRequest(
            viTri: location.toString(),
            idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
            thoiGianBatDau: timeKeeping.toString(),
            idDuAnNhanVien: duAnNhanVien!.id,
            diaChi: addressController.text,
            idTinhTp: tinh!.id,
            idQuanHuyen: quanHuyen!.id,
            idPhuongXa: idPhuongXaNull,
            noiDungBaoCao: "Chưa báo cáo",
          ),
          onSuccess: (value) {
            sl
                .get<SharedPreferenceHelper>()
                .saveChamCongId(value.id.toString());
            sl
                .get<SharedPreferenceHelper>()
                .saveIdDuAnNhanVien(value.id.toString());
            sl.get<SharedPreferenceHelper>().saveIsSelected(isSelected: true);
            EasyLoading.dismiss();
            Get.back(result: true);
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
            update();
          },
        );
        EasyLoading.dismiss();
        update();
      } else if (status == PermissionStatus.denied) {
        await openAppSettings();
      } else if (status == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }
    }
  }
}
