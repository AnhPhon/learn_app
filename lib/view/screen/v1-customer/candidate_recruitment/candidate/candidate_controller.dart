import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/response/chuyen_mon_response.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/gioi_tinh_model.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/ngoai_ngu_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/tim_kiem_ung_vien_model.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_response.dart';
import 'package:template/data/model/response/tuyen_dung_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chuyen_mon_provider.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/ngoai_ngu_provider.dart';
import 'package:template/provider/so_nam_kinh_nghiem_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/trinh_do_provider.dart';
import 'package:template/provider/tuyen_dung_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/view/screen/v1-customer/candidate_recruitment/candidate/components/dialog_content.dart';
import 'package:tiengviet/tiengviet.dart';

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
  final DangKyViecMoiProvider dangKyViecMoiProvider =
      GetIt.I.get<DangKyViecMoiProvider>();
  final TuyenDungProvider tuyenDungProvider = GetIt.I.get<TuyenDungProvider>();

  //index tab
  int currentIndex = 0;

  //model value
  List<NgoaiNguResponse> ngoaiNguListModel = [];
  List<HinhThucLamViecResponse> hinhThucLamViecListModel = [];
  List<TinhTpResponse> tinhTpListModel = [];
  List<ChuyenMonResponse> chuyenMonListModel = [];
  List<SoNamKinhNghiemResponse> soNamKinhNghiemListModel = [];
  List<TrinhDoResponse> trinhDoListModel = [];
  List<DangKyViecMoiResponse> dangKyViecMoiListModel = [];
  List<TuyenDungResponse> tuyenDungListModel = [];
  //set default giới tính
  List<GioiTinhModel> gioiTinhModel = [
    GioiTinhModel(key: 'gioiTinh', value: 'Giới tính'),
    GioiTinhModel(key: 'gioiTinh', value: 'Nam'),
    GioiTinhModel(key: 'gioiTinh', value: 'Nữ'),
  ];

  //model choose
  NgoaiNguResponse ngoaiNguResponse = NgoaiNguResponse();
  HinhThucLamViecResponse hinhThucLamViecResponse = HinhThucLamViecResponse();
  TinhTpResponse tinhTpResponse = TinhTpResponse();
  ChuyenMonResponse chuyenMonResponse = ChuyenMonResponse();
  SoNamKinhNghiemResponse soNamKinhNghiemResponse = SoNamKinhNghiemResponse();
  TrinhDoResponse trinhDoResponse = TrinhDoResponse();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();

  //sreach
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  //giới tính
  GioiTinhModel gioiTinh = GioiTinhModel();

  // Value slider
  double salary = 0;

  //isLoadingCadidate
  bool isLoadingCadidate = true;

  //value tìm kiếm tiêu đề
  String tieuDeSearch = '';

  //conditionFilter
  String conditionFilter = '';
  List<TimKiemUngVienModel> conditions = [];

  //Refresh Page tuyển dụng
  int pageMax = 1;
  int limit = 5;
  bool isLoadingTuyenDung = true;

  // refresh controller for load more refresh
  RefreshController? refreshController;

  //tenChuyeNganhPhu
  String tenChuyenNganhPhu = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    refreshController ??= RefreshController();

    //load data tinhTp
    getDataTinhTp();
    //get userId
    sl.get<SharedPreferenceHelper>().userId.then(
      (value) {
        // find tai khoan by user id
        taiKhoanProvider.find(
          id: value!,
          onSuccess: (value) {
            // set user
            taiKhoanResponse = value;
            onLoadDataWithTab(0);
            //load data frist
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
    searchController.dispose();
    searchFocusNode.dispose();
    refreshController!.dispose();
    super.onClose();
  }

  ///
  ///onLoadDataTuyenDung
  ///
  void onLoadDataTuyenDung({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      tuyenDungListModel.clear();
    } else {
      //isLoading
      pageMax++;
    }
    //load data tuyen dung
    tuyenDungProvider.paginate(
        page: pageMax,
        limit: limit,
        filter: '&sortBy=created_at:desc',
        onSuccess: (value) {
          //check data empty
          if (value.isEmpty) {
            refreshController!.loadNoData();
          } else if (isRefresh) {
            //check refresh
            tuyenDungListModel = value;
            refreshController!.refreshCompleted();
            refreshController!.loadComplete();
          } else {
            tuyenDungListModel.addAll(value);
            refreshController!.loadComplete();
          }
          isLoadingTuyenDung = false;
          print('tuyenDungListModel ${tuyenDungListModel.length}');
          update();
        },
        onError: (error) =>
            print('V1CandidateController onLoadDataTuyenDung $error'));
  }

  ///
  ///onRefresh
  ///
  void onRefreshTuyenDung() {
    onLoadDataTuyenDung(isRefresh: true);
  }

  ///
  ///onLoadDataTuyenDung
  ///
  void onLoadingTuyenDung() {
    onLoadDataTuyenDung(isRefresh: false);
  }

  ///
  ///onLoadDataWithTab
  ///
  void onLoadDataWithTab(int select) {
    if (select == 1) {
      getDataNgoaiNgu();
      getDataHinhThucLamViec();
      // getDataTinhTp();
      getDataChuyenMon();
      getDataSoNamKinhNghiem();
      getDataTrinhDo();
      //set value frist giới tính
      gioiTinh = gioiTinhModel.first;
      update();
    } else {
      onLoadDataTuyenDung(isRefresh: true);
    }
  }

  ///
  ///onChangeNameTinhTp
  ///
  String? onChangeNameTinhTp(String id) {
    return tinhTpListModel.firstWhere((element) => element.id == id).ten;
  }

  ///
  ///onTapViewTuyenDung
  ///
  void onTapViewTuyenDung({required TuyenDungResponse tuyendungModel}) {
    // set tên chuyên ngành phụ
    if (tuyendungModel.idChuyenNganhPhus!.isNotEmpty) {
      for (int i = 0; i < tuyendungModel.idChuyenNganhPhus!.length; i++) {
        if (i == 0) {
          tenChuyenNganhPhu =
              tuyendungModel.idChuyenNganhPhus![i].tieuDe.toString();
        } else {
          tenChuyenNganhPhu +=
              ', ${tuyendungModel.idChuyenNganhPhus![i].tieuDe.toString()}';
        }
      }
    }

    ///gán data tuyển dụng
    Map<String, dynamic> param = {
      "TieuDe": tuyendungModel.tieuDe,
      "CongTy": tuyendungModel.congTy,
      'TenDiaChiCongTy':
          '${tuyendungModel.diaChi}, ${tuyendungModel.idPhuongXa}, ${tuyendungModel.idQuanHuyen}, ${tuyendungModel.idTinhTp}',
      "GioiTinh": tuyendungModel.gioiTinh == 'Nam' ? '1' : '2',
      "SoLuong": tuyendungModel.soLuong,
      "TenHinhThucLamViec": tuyendungModel.idHinhThucLamViec,
      "TenTrinhDoHocVan": tuyendungModel.idTrinhDoHocVan,
      "TenChuyenNganhChinh": tuyendungModel.idChuyenNganhChinh,
      "TenChuyenNganhPhu": tenChuyenNganhPhu,
      "TenSoNamKinhNghiem": tuyendungModel.idSoNamKinhNghiem,
      "TenMucLuongDuKien": tuyendungModel.idMucLuongDuKien,
      "TenNoiLamViec": onChangeNameTinhTp(tuyendungModel.noiLamViec.toString()),
      "TenThoiGianLamViec": tuyendungModel.idThoiGianLamViec,
      "ThoiGianThuViec": tuyendungModel.thoiGianThuViec,
      "MoTaCongViec": tuyendungModel.moTaCongViec,
      "YeuCauCongViec": tuyendungModel.yeuCauCongViec,
      "QuyenLoi": tuyendungModel.quyenLoi,
      "UuTien": tuyendungModel.uuTien,
      "HanNopHoSo": tuyendungModel.hanNopHoSo,
      "HoTenLienHe": tuyendungModel.hoTenLienHe,
      "SoDienThoaiLienHe": tuyendungModel.soDienThoaiLienHe,
      "DiaChiLienHe": tuyendungModel.diaChiLienHe,
      "EmailLienHe": tuyendungModel.emailLienHe,
    };

    Get.toNamed('${AppRoutes.V1_G7_REVIEW}?isReview=false', arguments: param);
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

          //set value tất cả
          ngoaiNguListModel.insert(
              0, NgoaiNguResponse(id: "0", loaiNgoaiNgu: "Ngoại ngữ"));

          ngoaiNguResponse = value.first;
          // isLoadingCadidate = false;
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

          //set value tất cả
          hinhThucLamViecListModel.insert(0,
              HinhThucLamViecResponse(id: "0", tieuDe: "Hình thức việc làm"));
          hinhThucLamViecResponse = value.first;
          // isLoadingCadidate = false;
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
          //set value tất cả
          tinhTpListModel.insert(0, TinhTpResponse(id: "0", ten: "Tỉnh/Tp"));
          tinhTpResponse = value.first;
          // isLoadingCadidate = false;
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
          //set value tất cả
          chuyenMonListModel.insert(
              0, ChuyenMonResponse(id: "0", tieuDe: "Ngành nghề"));
          chuyenMonResponse = value.first;
          // isLoadingCadidate = false;
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
          //set value tất cả
          soNamKinhNghiemListModel.insert(
              0, SoNamKinhNghiemResponse(id: "0", tieuDe: "Kinh Nghiệm"));
          soNamKinhNghiemResponse = value.first;
          // isLoadingCadidate = false;
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
          //set value tất cả
          trinhDoListModel.insert(
              0, TrinhDoResponse(id: "0", tieuDe: "Trình độ"));
          trinhDoResponse = value.first;
          // isLoadingCadidate = false;

          //get data ứng viên
          getDataSeach(textFilter: '');
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
    //add new conditions
    addNewConditions(
        condition:
            TimKiemUngVienModel(key: "idHinhThucLamViec", value: item.id),
        isButtonSearch: true);
    update();
  }

  ///
  ///chọn ngôn ngữ
  ///
  void onChangeNgoaiNgu(NgoaiNguResponse item) {
    ngoaiNguResponse = item;
    //add new conditions
    addNewConditions(
        condition: TimKiemUngVienModel(key: "idNgoaiNgu", value: item.id),
        isButtonSearch: true);
    update();
  }

  ///
  ///chọn tỉnh tp
  ///
  void onChangeTinhTp(TinhTpResponse item) {
    tinhTpResponse = item;
    //add new conditions
    addNewConditions(
        condition: TimKiemUngVienModel(key: "idTinhTp", value: item.id),
        isButtonSearch: false);
    update();
  }

  ///
  ///chọn ngành nghề
  ///
  void onChangeNganhNghe(ChuyenMonResponse item) {
    chuyenMonResponse = item;
    //add new conditions
    addNewConditions(
        condition: TimKiemUngVienModel(key: "idChuyenMon", value: item.id),
        isButtonSearch: false);
    update();
  }

  ///
  ///chọn kinh nghiệm
  ///
  void onChangeKinhNghiem(SoNamKinhNghiemResponse item) {
    soNamKinhNghiemResponse = item;
    //add new conditions
    addNewConditions(
        condition:
            TimKiemUngVienModel(key: "idSoNamKinhNghiem", value: item.id),
        isButtonSearch: false);
    update();
  }

  ///
  ///chọn trình độ
  ///
  void onChangeTrinhDo(TrinhDoResponse item) {
    trinhDoResponse = item;
    //add new conditions
    addNewConditions(
        condition: TimKiemUngVienModel(key: "idTrinhDo", value: item.id),
        isButtonSearch: false);
    update();
  }

  ///
  ///Thay đổi vị trí tab
  ///
  void onChangeTab(int index) {
    currentIndex = index;
    onLoadDataWithTab(index);
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
  /// thay đổi lương để tìm kiếm
  ///
  void onChangedEndSalary(double salary) {
    this.salary = salary;
    //add new conditions
    addNewConditions(
        condition: TimKiemUngVienModel(
            key: "mucLuongDeXuat", value: salary.toStringAsFixed(0)),
        isButtonSearch: true);
    update();
  }

  ///
  ///tìm kiếm theo tiêu đề
  ///
  void onChangeTieuDe(String text, BuildContext context) {
    if (text.length > 2 && text != '') {
      searchController.text = text;
      tieuDeSearch = TiengViet.parse(text);
      DeviceUtils.hideKeyboard(context);
      //add new conditions
      addNewConditions(
          condition: TimKiemUngVienModel(
              key: "tieuDeSearch", value: tieuDeSearch.toString()),
          isButtonSearch: false);
    } else if (text == '') {
      //add new conditions
      addNewConditions(
          condition: TimKiemUngVienModel(key: "tieuDeSearch", value: '0'),
          isButtonSearch: false);
    } else {
      Alert.error(message: 'Tiêu đề tối thiểu 3 ký tự');
    }
    update();
  }

  ///
  /// thay đổi giới tính
  ///
  void onChangedSex(GioiTinhModel text) {
    gioiTinh = text;

    //check value giới tính
    String temp = '';
    if (text.toString() == 'Giới tính') {
      temp = '0';
    } else {
      temp = text.toString();
    }
    //add new conditions
    addNewConditions(
        condition: TimKiemUngVienModel(key: "gioiTinh", value: temp),
        isButtonSearch: false);
    update();
  }

  ///
  /// addNewConditions
  ///
  void addNewConditions(
      {required TimKiemUngVienModel condition, required bool isButtonSearch}) {
    // check exists
    bool flg = false;
    int i;

    // check condition exists
    for (i = 0; i < conditions.length; i++) {
      if (conditions[i].key == condition.key) {
        flg = true;
        break;
      }
    }

    // remove old key
    if (flg) {
      conditions.removeAt(i);
    }

    // insert new seach condition if !=0
    if (condition.value != '0') {
      conditions.add(condition);
    }
    //check nếu không phải button search thì onchange luôn
    if (!isButtonSearch) {
      createConditionFilter(conditions);
    }
  }

  ///
  /// createConditionFilter
  ///
  void createConditionFilter(List<TimKiemUngVienModel> conditions) {
    isLoadingCadidate = true;
    update();
    conditionFilter = '';
    for (final TimKiemUngVienModel item in conditions) {
      {
        if (conditionFilter == '') {
          conditionFilter = '${item.key!}=${item.value}';
        } else {
          conditionFilter += '&${item.key!}=${item.value}';
        }
      }
    }

    if (conditionFilter != '') {
      if (conditionFilter.substring(
              conditionFilter.length - 1, conditionFilter.length) ==
          '&') {
        conditionFilter =
            conditionFilter.substring(0, conditionFilter.length - 1);
      }
    }

    print('conditionFilter $conditionFilter');
    getDataSeach(textFilter: conditionFilter);
  }

  ///
  ///getDataSeach
  ///
  void getDataSeach({required String textFilter}) {
    print('có vô ko');
    if (textFilter != '') {
      // ignore: parameter_assignments
      textFilter = '&$textFilter';
    }
    dangKyViecMoiProvider.paginate(
        page: 1,
        limit: 20,
        filter: textFilter,
        onSuccess: (value) {
          print('conditionFilter value ${value.length}');
          //reset và add value
          dangKyViecMoiListModel.clear();
          dangKyViecMoiListModel.addAll(value);
          isLoadingCadidate = false;
          update();
        },
        onError: (error) =>
            print('V1CandidateController getDataTrinhDo $error'));
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
  void onClickProfile({required DangKyViecMoiResponse dangKyViecMoiModel}) {
    Get.toNamed(AppRoutes.V1_CANDICATE_PROFILE, arguments: dangKyViecMoiModel);
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
              createConditionFilter(conditions);
            },
            child: const Text("Tìm kiếm")));
  }
}
