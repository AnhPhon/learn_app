import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:template/data/model/request/cham_cong_request.dart';
import 'package:template/data/model/response/cham_cong_response.dart';
import 'package:template/data/model/response/du_an_nhan_vien_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/cham_cong_provider.dart';
import 'package:template/provider/du_an_nhan_vien_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V4TimekeepingController extends GetxController {
  GetIt sl = GetIt.instance;
  ChamCongProvider chamCongProvider = GetIt.I.get<ChamCongProvider>();
  List<ChamCongResponse> chamCongList = [];

  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  QuanHuyenProvider quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  PhuongXaProvider phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
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
  final timekeeping = TextEditingController(
      text: DateConverter.formatDateTimeHHmm(DateTime.now()));

  //Khai báo TextEditingController của địa chỉ chấm công
  final addressController = TextEditingController();
  String idUser = '';
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getTinhThanh();
    getDuAnNhanVien();
    getLocator();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    addressController.dispose();
  }

  ///
  ///Thay đổi dự án nhân viên
  ///
  void onChangedDuAnNhanVien(DuAnNhanVienResponse duAnNhanVien) {
    this.duAnNhanVien = duAnNhanVien;
    update();
  }

  ///
  ///Lấy dự án của nhân viên
  ///
  void getDuAnNhanVien() {
    duAnNhanVienProvider.all(
      onSuccess: (value) {
        duAnNhanVienList.clear();
        if (value.isNotEmpty) {
          duAnNhanVienList.addAll(value);
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
  ///Get Current Location
  ///
  Future<void> getLocator() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();

    print(position.latitude);
    print(position.longitude);
    print(lastPosition);
    location = "$lastPosition";
    print(location);
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhThanh(TinhTpResponse tinhTp) {
    tinh = tinhTp;
    getQuanHuyen(id: tinhTp.id);
    phuongXaList.clear();
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
  /// Lấy tất cả tỉnh thành phố
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
  /// Lấy tất cả quận huyện
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
            quanHuyen = quanHuyenList.first;
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
  /// Lấy tất cả phường xã
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
            phuongXa = phuongXaList.first;
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
      Alert.error(message: 'Vui lòng chọn dự án!');
      return false;
    }
    if (addressController.text.toString().isEmpty) {
      Alert.error(message: 'Vui lòng nhập địa chỉ!');
      return false;
    }

    if (tinh == null) {
      Alert.error(message: 'Vui lòng chọn Tỉnh/Tp!');
      return false;
    }
    if (quanHuyen == null) {
      Alert.error(message: 'Vui lòng chọn Quận/Huyện!');
      return false;
    }
    if (phuongXa == null) {
      Alert.error(message: 'Vui lòng chọn Phường/Xã!');
      return false;
    }
    return true;
  }

  ///
  ///Chấm công
  ///
  Future<void> onChamCong() async {
    if (validate()) {
      final DateTime timeKeeping =
          DateConverter.convertStringToDatetimeddMMyyyy(timekeeping.text);
      chamCongProvider.add(
        data: ChamCongRequest(
          viTri: location,
          idNhanVien: await sl.get<SharedPreferenceHelper>().userId,
          thoiGianBatDau: timeKeeping.toString(),
          idDuAnNhanVien: duAnNhanVien!.id,
          diaChi: addressController.text,
          idTinhTp: tinh!.id,
          idQuanHuyen: quanHuyen!.id,
          idPhuongXa: phuongXa!.id,
        ),
        onSuccess: (value) {
          sl.get<SharedPreferenceHelper>().saveChamCongId(value.id.toString());
          sl
              .get<SharedPreferenceHelper>()
              .saveIdDuAnNhanVien(value.id.toString());

          print(value.id.toString());
          Get.back(result: true);
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
          update();
        },
      );
    }
  }
}
