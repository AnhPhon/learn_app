import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/chuyen_mon_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/ngoai_ngu_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chuyen_mon_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/ngoai_ngu_provider.dart';
import 'package:template/provider/so_nam_kinh_nghiem_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/trinh_do_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/components/dialog_content.dart';

class V1CandidateController extends GetxController {
  //provider
  final NgoaiNguProvider ngoaiNguProvider = GetIt.I.get<NgoaiNguProvider>();
  final HinhThucLamViecProvider hinhThucLamViecProvider =
      GetIt.I.get<HinhThucLamViecProvider>();
  final TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final ChuyenMonProvider chuyenMonProvider = GetIt.I.get<ChuyenMonProvider>();
  final SoNamKinhNghiemProvider soNamKinhNghiemProvider =
      GetIt.I.get<SoNamKinhNghiemProvider>();
  final TrinhDoProvider trinhDoProvider = GetIt.I.get<TrinhDoProvider>();
  final TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  //model value
  List<NgoaiNguResponse> ngoaiNguListModel = [];
  List<HinhThucLamViecResponse> hinhThucLamViecListModel = [];
  List<TinhTpResponse> tinhTpListModel = [];
  List<ChuyenMonResponse> chuyenMonListModel = [];
  List<SoNamKinhNghiemResponse> soNamKinhNghiemListModel = [];
  List<TrinhDoResponse> trinhDoListModel = [];

  //model choose
  NgoaiNguResponse ngoaiNguResponse = NgoaiNguResponse();
  HinhThucLamViecResponse hinhThucLamViecResponse = HinhThucLamViecResponse();
  TinhTpResponse tinhTpResponse = TinhTpResponse();
  ChuyenMonResponse chuyenMonResponse = ChuyenMonResponse();
  SoNamKinhNghiemResponse soNamKinhNghiemResponse = SoNamKinhNghiemResponse();
  TrinhDoResponse trinhDoResponse = TrinhDoResponse();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();

  final searchController = TextEditingController();
  int currentIndex = 0;
  // Value slider
  double salary = 0;

  //isLoading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        // find tai khoan by user id
        taiKhoanProvider.find(
          id: value!,
          onSuccess: (value) {
            // set user
            taiKhoanResponse = value;

            //load data frist
            getDataNgoaiNgu();
            getDataHinhThucLamViec();
            getDataTinhTp();
            getDataChuyenMon();
            getDataSoNamKinhNghiem();
            getDataTrinhDo();
          },
          onError: (error) {
            print('V1CandidateController onInit $error');
            update();
            SnackBar(
              content: Text(error.message.toString()),
            );
          },
        );
      },
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  ///
  /// load data ngoại ngữ
  ///
  void getDataNgoaiNgu() {
    //list ngoại ngữ
    ngoaiNguProvider.all(
        onSuccess: (value) {
          //add list
          ngoaiNguListModel = value;
          ngoaiNguResponse = value.first;
          // isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1CandidateController getDataNgoaiNgu $error'));
  }

  ///
  /// load data hình thức làm việc
  ///
  void getDataHinhThucLamViec() {
    //list hinh thuc lam iec
    hinhThucLamViecProvider.all(
        onSuccess: (value) {
          //add list
          hinhThucLamViecListModel = value;
          hinhThucLamViecResponse = value.first;
          // isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1CandidateController getDataHinhThucLamViec $error'));
  }

  ///
  /// load data tỉnh tp
  ///
  void getDataTinhTp() {
    tinhTpProvider.all(
        onSuccess: (value) {
          //add list
          tinhTpListModel = value;
          tinhTpResponse = value.first;
          // isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1CandidateController getDataTinhTp $error'));
  }

  ///
  /// load data chuyên môn
  ///
  void getDataChuyenMon() {
    chuyenMonProvider.all(
        onSuccess: (value) {
          //add list
          chuyenMonListModel = value;
          chuyenMonResponse = value.first;
          // isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1CandidateController getDataChuyenMon $error'));
  }

  ///
  /// load data số năm kinh nghiệm
  ///
  void getDataSoNamKinhNghiem() {
    soNamKinhNghiemProvider.all(
        onSuccess: (value) {
          //add list
          soNamKinhNghiemListModel = value;
          soNamKinhNghiemResponse = value.first;
          // isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1CandidateController getDataSoNamKinhNghiem $error'));
  }

  ///
  /// load data trình độ
  ///
  void getDataTrinhDo() {
    trinhDoProvider.all(
        onSuccess: (value) {
          //add list
          trinhDoListModel = value;
          trinhDoResponse = value.first;
          isLoading = false;
          update();
        },
        onError: (error) =>
            print('V1CandidateController getDataTrinhDo $error'));
  }

  ///
  ///chọn hình thức làm việc
  ///
  void onChangeHinhThucLamViec(HinhThucLamViecResponse item) {
    hinhThucLamViecResponse = item;
    update();
  }

  ///
  ///chọn ngôn ngữ
  ///
  void onChangeNgoaiNgu(NgoaiNguResponse item) {
    ngoaiNguResponse = item;
    update();
  }

  ///
  ///chọn tỉnh tp
  ///
  void onChangeTinhTp(TinhTpResponse item) {
    tinhTpResponse = item;
    update();
  }

  ///
  ///chọn ngành nghề
  ///
  void onChangeNganhNghe(ChuyenMonResponse item) {
    chuyenMonResponse = item;
    update();
  }

  ///
  ///chọn kinh nghiệm
  ///
  void onChangeKinhNghiem(SoNamKinhNghiemResponse item) {
    soNamKinhNghiemResponse = item;
    update();
  }

  ///
  ///chọn trình độ
  ///
  void onChangeTrinhDo(TrinhDoResponse item) {
    trinhDoResponse = item;
    update();
  }

  ///
  ///Thay đổi vị trí tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    update();
  }

  ///
  /// thay đổi lương
  ///
  void onChangedSalary(double salary) {
    this.salary = salary;
    update();
  }

  ///
  /// Onlick đến đơn tạo tuyển ứng viên
  ///
  void onClickFloatButton() {
    Get.toNamed(AppRoutes.V1_G7_RECRUITMENT);
  }

  ///
  /// Onlick đến xem thông tin hồ sơ ưng tuyển
  ///
  void onClickProfile() {
    Get.toNamed(AppRoutes.V1_CANDICATE_PROFILE);
  }

  ///
  ///  Hiẻn thị bộ lọc
  ///
  void showDialog() {
    Get.defaultDialog(
        title: "",
        content: const DialogContent(),
        cancel: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Tìm kiếm")));
  }
}
