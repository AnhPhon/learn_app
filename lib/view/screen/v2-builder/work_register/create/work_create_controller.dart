import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/body/dang_ky_viec_moi_model.dart';
import 'package:template/data/model/request/bang_bang_cap_request.dart';
import 'package:template/data/model/request/ke_khai_kinh_nghiem_request.dart';
import 'package:template/data/model/request/ngoai_ngu_request.dart';
import 'package:template/data/model/request/tin_hoc_request.dart';
import 'package:template/data/model/response/bang_bang_cap_response.dart';
import 'package:template/data/model/response/chuc_vu_response.dart';
import 'package:template/data/model/response/chuyen_nganh_chinh_response.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/dia_diem_dang_ky_lam_viec_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/hon_nhan_model.dart';
import 'package:template/data/model/response/ke_khai_kinh_nghiem_response.dart';
import 'package:template/data/model/response/loai_cong_viec_response.dart';
import 'package:template/data/model/response/loai_tot_nghiep_response.dart';
import 'package:template/data/model/response/muc_luong_du_kien_response.dart';
import 'package:template/data/model/response/ngoai_ngu_response.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/so_nam_kinh_nghiem_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/tin_hoc_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/model/response/trinh_do_hoc_van_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/currency_covert.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/bang_bang_cap_provider.dart';
import 'package:template/provider/chuc_vu_provider.dart';
import 'package:template/provider/chuyen_mon_provider.dart';
import 'package:template/provider/chuyen_nganh_chinh_provider.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/dia_diem_dang_ky_lam_viec_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/ke_khai_kinh_nghiem_provider.dart';
import 'package:template/provider/loai_cong_viec_provider.dart';
import 'package:template/provider/loai_tot_nghiep_provider.dart';
import 'package:template/provider/muc_luong_du_kien_provider.dart';
import 'package:template/provider/ngoai_ngu_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/so_nam_kinh_nghiem_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tin_hoc_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/trinh_do_hoc_van_provider.dart';
import 'package:template/provider/trinh_do_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart' as app_constants;
import 'package:template/view/screen/v2-builder/work_register/preview/work_preview_page.dart';
import 'package:url_launcher/url_launcher.dart';

class V2WorkCreateController extends GetxController {
  // Image
  final ImageUpdateProvider imageUpdateProvider =
      GetIt.I.get<ImageUpdateProvider>();

  //Provider Loại Công việc
  LoaiCongViecProvider loaiCongViecProvider =
      GetIt.I.get<LoaiCongViecProvider>();

  //Kê khai kinh nghiệm Provider
  KeKhaiKinhNghiemProvider keKhaiKinhNghiemProvider =
      GetIt.I.get<KeKhaiKinhNghiemProvider>();

  // Đăng ký việc mới Provider
  DangKyViecMoiProvider dangKyViecMoiProvider =
      GetIt.I.get<DangKyViecMoiProvider>();

  // Tài khoản Provider
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  //Hình thức làm việc Provider
  HinhThucLamViecProvider hinhThucLamViecProvider =
      GetIt.I.get<HinhThucLamViecProvider>();

  //Trình độ học vấn Provider
  TrinhDoHocVanProvider trinhDoHocVanProvider =
      GetIt.I.get<TrinhDoHocVanProvider>();

  //Chuyên môn Provider
  ChuyenMonProvider chuyenMonProvider = GetIt.I.get<ChuyenMonProvider>();

  //Loại tốt nghiệp Provider
  LoaiTotNghiepProvider loaiTotNghiepProvider =
      GetIt.I.get<LoaiTotNghiepProvider>();

  //Chức vụ Provider
  ChucVuProvider chucVuProvider = GetIt.I.get<ChucVuProvider>();

  //Mức lương dự kiến Provider
  MucLuongDuKienProvider mucLuongDuKienProvider =
      GetIt.I.get<MucLuongDuKienProvider>();

  //Số năm kinh nghiệm Provider
  SoNamKinhNghiemProvider soNamKinhNghiemProvider =
      GetIt.I.get<SoNamKinhNghiemProvider>();

  //Địa điểm đăng kí làm việc Provider
  DiaDiemDangKyLamViecProvider diaDiemDangKyLamViecProvider =
      GetIt.I.get<DiaDiemDangKyLamViecProvider>();

  //Chuyên ngành chính Provider
  ChuyenNganhChinhProvider chuyenNganhChinhProvider =
      GetIt.I.get<ChuyenNganhChinhProvider>();

  //Bằng cấp Provider
  BangBangCapProvider bangBangCapProvider = GetIt.I.get<BangBangCapProvider>();

  // Ngoại ngữ Provider
  NgoaiNguProvider ngoaiNguProvider = GetIt.I.get<NgoaiNguProvider>();

  // Tin học Provider
  TinHocProvider tinHocProvider = GetIt.I.get<TinHocProvider>();

  //Trình độ Provider
  TrinhDoProvider trinhDoProvider = GetIt.I.get<TrinhDoProvider>();

  //Tỉnh TP Provider
  TinhTpProvider tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  List<TinhTpResponse> tinhTpResponseList = [];
  List<TinhTpResponse?> noiLamViecSelected = [];
  List<String?> noiLamViecSelectedString = [];
  List<String?> noiLamViecListString = [];
  List<TinhTpResponse> tinhTpListModel = [];
  List<QuanHuyenResponse> quanHuyenListModel = [];
  List<PhuongXaResponse> phuongXaListModel = [];
  TinhTpResponse? tinhTp;
  QuanHuyenResponse? quanHuyenResponse;
  PhuongXaResponse? phuongXaResponse;
  TinhTpResponse? tinhTpResponse;

  ///
  /// TextEditingController Thông tin cá nhân
  ///

  // Tiêu đề đăng kí việc mới
  TextEditingController titleController = TextEditingController();

  // Chổ ở hiện tại đăng kí việc mới
  TextEditingController addressController = TextEditingController();

  // Mục tiêu nghề nghiệp đăng kí việc mới
  TextEditingController mucTieuNgheNghiepController = TextEditingController();

  //năm tốt nghiệp
  TextEditingController namTotNghiepController = TextEditingController();

  ///
  /// TextEditingController Thêm kê khai kinh nghiệm
  ///

  //Đơn vị đào tạo thêm bằng cấp
  TextEditingController donViDaotaoController = TextEditingController();

  // Ngày bắt đầu kê khai kinh nghiệm
  TextEditingController startTimeController = TextEditingController();

  // Đến ngày kê khai kinh nghiệm
  TextEditingController endTimeController = TextEditingController();

  // Đơn vị
  TextEditingController donViController = TextEditingController();

  // Chức vụ
  TextEditingController chucVuController = TextEditingController();

  // Mức lương
  TextEditingController mucLuongController = TextEditingController();

  // Mức lương
  TextEditingController vndController = TextEditingController(text: "VND");

  // Công việc phụ trách
  TextEditingController congViecPhuTrachController = TextEditingController();

  // Kế quả/Thành tích đạt được
  TextEditingController ketQuaController = TextEditingController();

  // Kỹ năng và sở trường làm việc
  TextEditingController kyNangVaSoTruongLamViecController =
      TextEditingController();

  ///
  /// TextEditingController Thêm bằng tin học
  ///

  // phần mềm hỗ trợ công việ từng ngành
  TextEditingController phanMemHoTroController = TextEditingController();

  // sở thích thể hiện trình ododj / khả năng tư duy
  TextEditingController soThichTheHienTrinhDoController =
      TextEditingController();

  // sở thích thể hiện kỹ năng
  TextEditingController soThichTheHienKyNangController =
      TextEditingController();

  // Sở thích thể hiện tích cách
  TextEditingController soThichTheHienTinhCachController =
      TextEditingController();

  ///
  /// Tham khảo
  ///

  // Người tham khảo
  TextEditingController nguoiThamKhaoController = TextEditingController();

  // Chức danh
  TextEditingController chucdanhController = TextEditingController();

  // Công ty
  TextEditingController congTyController = TextEditingController();

  // Số điện thoại
  TextEditingController soDienThoaiController = TextEditingController();

  // Tình trạng Hôn nhân
  final honNhanRefer = ["Độc thân", "Đã lập gia đình", "Khác"];

  //Hôn nhân List
  List<HonNhanModel> honNhanListModel = [
    HonNhanModel(id: '1', tieuDe: 'Độc thân'),
    HonNhanModel(id: '2', tieuDe: 'Đã lập gia đình'),
    HonNhanModel(id: '3', tieuDe: 'Khác'),
  ];
  HonNhanModel? honNhanModel;
//String Hon nhan
  List<String> honNhanListString = ["Độc thân", "Đã lập gia đình", "Khác"];
  String? honNhanString;

  /////
  final gioiTinhRefer = ["Nữ", "Nam"];

//Tài khoản Response
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();

  //Đăng kí việc mới Response
  DangKyViecMoiResponse? dangKyViecMoiResponse;

  //Hình thức làm việc
  List<HinhThucLamViecResponse> hinhThucLamViec = [];
  HinhThucLamViecResponse? hinhThucLamViecIndex;

  //Trình độ học vấn
  List<TrinhDoHocVanResponse> trinhDo = [];
  TrinhDoHocVanResponse? trinhDoIndex;

  //Chuyên môn
  List<LoaiCongViecResponse> chuyenMon = [];
  LoaiCongViecResponse? chuyenMonIndex;

  //Loại tốt nghiệp
  List<LoaiTotNghiepResponse> loaiTotNghiep = [];
  LoaiTotNghiepResponse? loaiTotNghiepIndex;

  //Ảnh bằng cấp
  List<File> anhBangCap = [];
  List<BangBangCapRequest> bangBangCap = [];

  List<Map<String, String>> bangBangCapDisplay = [];
  List<BangBangCapResponse> bangBangCapDisplayResponse = [];
  List<BangBangCapRequest> bangBangCapRequestList = [];
  BangBangCapResponse? bangBangCapModel;

  //Chức vụ hiện tại
  ChucVuResponse? chucVuHienTaiIndex;
  ChucVuResponse? chucVuMongMuonIndex;
  List<ChucVuResponse> chucVuList = [];

  //Mức lương dự kiến
  MucLuongDuKienResponse? mucLuongDuKienIndex;
  List<MucLuongDuKienResponse> mucLuongDuKienList = [];

  //Số năm kinh nghiệm
  SoNamKinhNghiemResponse? soNamKinhNghiemIndex;
  List<SoNamKinhNghiemResponse> soNamKinhNghiemList = [];

  //Địa điểm đăng ký làm việc
  DiaDiemDangKyLamViecResponse? diaDiemDangKyLamViecIndex;
  List<DiaDiemDangKyLamViecResponse> diaDiemDangKyLamViecList = [];

  //Chuyên ngành chính
  ChuyenNganhChinhResponse? chuyenNganhChinhIndex;

  //change
  List<LoaiCongViecResponse>? chuyenNganhChinhList;
  List<LoaiCongViecResponse?> chuyenNganhChinhSelected = [];
  LoaiCongViecResponse? chuyenMonResponse;

  //Kê khai kinh nghiệm
  List<KeKhaiKinhNghiemRequest> keKhaiKinhNghiemRequestList = [];

  List<KeKhaiKinhNghiemResponse> keKhaiKinhNghiemResponseList = [];

  //Trình độ
  List<TrinhDoHocVanResponse> trinhDoHocVanList = [];
  TrinhDoHocVanResponse? trinhDoHocVanResponseIndex;

  //Ngoại ngữ
  List<NgoaiNguResponse> ngoaiNguResponseList = [];
  List<NgoaiNguRequest> ngoaiNguList = [];
  NgoaiNguResponse? ngoaiNguResponseIndex;

  //Đăng kí việc Mới
  DangKyViecMoiResponse? dangKiViecMoiGetId;

  //Chọn ngoại ngữ
  String? ngoaiNgu;
  List<String> ngoaiNguListString = [
    "Tiếng Anh",
    "Tiếng Pháp",
    "Tiếng Nhật",
    "Tiếng Đức",
    "Tiếng Hàn",
    "Tiếng Trung Quốc"
  ];

  //Chọn trình độ
  String? trinhDoNgoaiNgu;
  List<String> trinhDoNgoaiNguList = [
    "Sơ cấp - Bậc 1",
    "Sơ cấp - Bậc 2",
    "Trung cấp - Bậc 1",
    "Trung cấp - Bậc 2",
    "Cao cấp - Bậc 1",
    "Cao cấp - Bậc 2",
  ];

  //Tin học
  List<TinHocRequest> tinHocList = [];
  List<TinHocResponse> tinHocResponseList = [];
  TinHocRequest? tinHocRequest;
  TinHocResponse? tinHocResponse;

  //List ID Bằng Cấp
  List<dynamic> idBangBangCap = [];

  //List ID kê Khai kinh nghiệm
  List<dynamic> idKeKhaiKinhNghiems = [];

  //List  ID Ngoại ngữ
  List<dynamic> idNgoaiNgu = [];

  //List ID Tin học
  String idTinHoc = "";

  //List String ảnh bằng cấp list
  List<String> anhBangCapsList = [];

  //List String ảnh bằng cấp
  List<String> anhBangCaps = [];

  //List String ảnh hồ sơ xin việc
  List<String> anhHoSoXinViecs = [];

  //List id ngành nghề mong muốn
  List<dynamic> idNganhNgheMongMuonsList = [];

  //File hồ sơ xin việc
  // File
  String hoSoXinViecsFile = "";

  String tenUngVien = "";
  String gioiTinh = "";
  String ngaySinh = "";
  String dienThoai = "";
  String noiOHienTai = "";
  String email = "";

  String donVi = "";
  String chucVu = "";
  String mucLuong = "";
  String congViecPhuTrach = "";
  String ketQuaThanhTich = "";
  String kyNangSotruong = "";
  String filePath = "";
  String? honNhan;
  String tinhTranHonNhan = "";

  //ngoại ngữ
  int ngoaiNguListenSkill = 1;
  int ngoaiNguSpeakSkill = 1;
  int ngoaiNguReadSkill = 1;
  int ngoaiNguWriteSkill = 1;

  //Tin học
  int tinHocWordSkill = 1;
  int tinHocExcelSkill = 1;
  int tinHocInternetSkill = 1;

  int lengthBangCap = 0;
  //Khai báo isLoading
  bool isLoading = true;

  // Chỉ thêm một lần bằng tin học
  bool isAddTinHoc = false;

  //Bool tuyển dụng
  bool tuyenDung = false;

  //String id Tuyển dụng
  String? idTuyenDung;

  //String id Việc mới
  String idViecMoi = "";

  //String id User
  String idUser = "";

  //bool xem thêm
  bool xemThem = false;

  //bool customHintTextTrinhDo
  bool customHintTextTrinhDo = true;

  //bool customHintTextChuyenMon
  bool customHintTextChuyenMon = true;

  //Id toàn quốc
  String idTinhToanQuoc = "61a8445b58935e5fc0cfec49";

  FocusNode focusChucVu = FocusNode();
  FocusNode focusMucLuong = FocusNode();
  FocusNode focusCongViecPhuTrach = FocusNode();
  FocusNode focusKetQuaThanhTich = FocusNode();
  FocusNode focusSoThichTrinhDo = FocusNode();
  FocusNode focusSoThichKyNang = FocusNode();
  FocusNode focusSoThichTinhCach = FocusNode();
  FocusNode focusCapTren = FocusNode();
  FocusNode focusChucDanh = FocusNode();
  FocusNode focusCongTy = FocusNode();
  FocusNode focusSDT = FocusNode();
  FocusNode focusUpKeKhaiKinhNghiem = FocusNode();

  //Ngoại Ngữ
  TextEditingController ngoaiNguController = TextEditingController();
  TextEditingController trinhDoController = TextEditingController();

  //value request
  dynamic getDataParamRegister;

  bool isFirstRegister7Group = false;

  void clickXemThem() {
    xemThem = true;
    update();
  }

  void clickRutGon() {
    xemThem = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    //check isTuyenDung
    if (Get.parameters['tuyenDung'] != null &&
        Get.parameters['tuyenDung'] == 'true') {
      tuyenDung = true;
      update();
    } else {
      tuyenDung = false;
      update();
    }

    //check id Tuyển dụng
    if (Get.parameters['idTuyenDung'] != null) {
      idTuyenDung = Get.parameters['idTuyenDung'].toString();
      update();
    }

    //Get param
    getDataParam();

    sl.get<SharedPreferenceHelper>().userId.then((value) {
      idUser = value!;

      //Get id đăng kí việc mới
      getIdViecMoi();
      loadThongTinUser();
      update();
    });

    ///
    /// check is register
    ///

    // get đăng ký việc kiểm tra đã có đăng ký chưa
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      dangKyViecMoiProvider.paginate(
        page: 1,
        limit: 1,
        filter:
            "&idTaiKhoan=$userId&idNhomDichVu=${app_constants.NHOM_DICH_VU_7}",
        onSuccess: (data) {
          if (data.isNotEmpty) {
            isFirstRegister7Group = true;
          } else {
            isFirstRegister7Group = false;
          }

          update();
        },
        onError: (error) {
          print("TermsAndPolicyController checkRegister onError $error");
        },
      );
    });

    honNhan = honNhanRefer.first;
  }

  @override
  void onClose() {
    titleController.dispose();
    addressController.dispose();
    mucTieuNgheNghiepController.dispose();
    namTotNghiepController.dispose();
    donViDaotaoController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    donViController.dispose();
    chucVuController.dispose();
    mucLuongController.dispose();
    congViecPhuTrachController.dispose();
    ketQuaController.dispose();
    kyNangVaSoTruongLamViecController.dispose();
    phanMemHoTroController.dispose();
    soThichTheHienTrinhDoController.dispose();
    soThichTheHienKyNangController.dispose();
    soThichTheHienTinhCachController.dispose();
    nguoiThamKhaoController.dispose();
    chucdanhController.dispose();
    congTyController.dispose();
    soDienThoaiController.dispose();
    super.onClose();
  }

  ///
  ///Get data from register
  ///
  void getDataParam() {
    getDataParamRegister = Get.arguments;
    update();
  }

  ///
  ///Get id việc Mới
  ///
  void getIdViecMoi() {
    if (tuyenDung == false) {
      dangKyViecMoiProvider.paginate(
        page: 1,
        limit: 1,
        filter: "&idTaiKhoan=$idUser",
        onSuccess: (models) {
          if (models.isNotEmpty) {
            dangKiViecMoiGetId = models.first;
            idViecMoi = dangKiViecMoiGetId!.id.toString();
            update();
            loadThongTinCoBan();
          } else {
            loadThongTinUser();
            //Get Hình thức làm việc
            loadHinhThucLamViec(isLoadFrist: true);

            //Get chức vụ hiện tại
            loadChucVu(isLoadFrist: true);

            //Get số năm kinh nghiệm
            loadNamKinhNghiem();

            //Get nơi làm việc
            loadNoilamViec(isLoadFrist: true);

            //Get ngành nghề mong muốn
            loadChonNganhNgheMongMuon(isLoadFrist: true);

            //Get Data TinhTP
            getDataTinhTp(isLoadFrist: true);

            ///
            /// mức lương đề xuất
            ///
            mucLuongDuKienProvider.all(
              onSuccess: (data) {
                if (data.isNotEmpty) {
                  mucLuongDuKienList = data;
                }
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );

            ///
            /// load trình độ
            ///
            trinhDoHocVanProvider.all(
              onSuccess: (data) {
                trinhDo = data;
                if (data.isNotEmpty) {
                  trinhDoIndex = data.first;
                }
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );

            ///
            /// load chuyên môn
            ///
            loaiCongViecProvider.paginate(
              page: 1,
              limit: 100,
              filter: "&idNhomDichVu=${app_constants.NHOM_DICH_VU_7}",
              onSuccess: (data) {
                chuyenMon = data;
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );

            ///
            /// load tốt nghiệp\
            ///
            loaiTotNghiepProvider.all(
              onSuccess: (data) {
                loaiTotNghiep = data;
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );

            ///
            /// load trinh do
            ///
            trinhDoHocVanProvider.all(onSuccess: (data) {
              trinhDoHocVanList = data;
            }, onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            });
          }

          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );

      update();
    } else if (tuyenDung == true) {
      dangKyViecMoiProvider.paginate(
        page: 1,
        limit: 1,
        filter: "&idTaiKhoan=$idUser",
        onSuccess: (models) {
          if (models.isNotEmpty) {
            dangKiViecMoiGetId = models.first;
            idViecMoi = dangKiViecMoiGetId!.id.toString();
            update();
            loadThongTinCoBan();
          } else {
            loadThongTinUser();
            //Get Hình thức làm việc
            loadHinhThucLamViec(isLoadFrist: true);

            //Get chức vụ hiện tại
            loadChucVu(isLoadFrist: true);

            //Get số năm kinh nghiệm
            loadNamKinhNghiem();

            //Get nơi làm việc
            loadNoilamViec(isLoadFrist: true);

            //Get ngành nghề mong muốn
            loadChonNganhNgheMongMuon(isLoadFrist: true);

            //Get Data TinhTP
            getDataTinhTp(isLoadFrist: true);

            ///
            /// mức lương đề xuất
            ///
            mucLuongDuKienProvider.all(
              onSuccess: (data) {
                if (data.isNotEmpty) {
                  mucLuongDuKienList = data;
                }
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );

            ///
            /// load trình độ
            ///
            trinhDoHocVanProvider.all(
              onSuccess: (data) {
                trinhDo = data;
                if (data.isNotEmpty) {
                  trinhDoIndex = data.first;
                }
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );

            ///
            /// load chuyên môn
            ///
            loaiCongViecProvider.paginate(
              page: 1,
              limit: 100,
              filter: "&idNhomDichVu=${app_constants.NHOM_DICH_VU_7}",
              onSuccess: (data) {
                chuyenMon = data;
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );

            ///
            /// load tốt nghiệp\
            ///
            loaiTotNghiepProvider.all(
              onSuccess: (data) {
                loaiTotNghiep = data;
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );

            ///
            /// load trinh do
            ///
            trinhDoHocVanProvider.all(onSuccess: (data) {
              trinhDoHocVanList = data;
            }, onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            });
          }

          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    }
  }

  ///
  ///Load thông tin User
  ///
  void loadThongTinUser() {
    ///
    /// load thông tin người dùng
    ///
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      taiKhoanProvider.find(
        id: value.toString(),
        onSuccess: (data) {
          taiKhoanResponse = data;
          tenUngVien = data.hoTen.toString();
          if (data.gioiTinh != null) {
            gioiTinh = data.gioiTinh.toString();
          }
          ngaySinh = data.ngaySinh.toString();
          dienThoai = data.soDienThoai.toString();

          email = data.email.toString();
          if (data.idPhuongXa != null) {
            noiOHienTai =
                "${data.diaChi.toString()}, ${data.idPhuongXa!.ten.toString()}, ${data.idQuanHuyen!.ten.toString()}, ${data.idTinhTp!.ten.toString()}";
          } else {
            noiOHienTai =
                "${data.diaChi.toString()}, ${data.idQuanHuyen!.ten.toString()}, ${data.idTinhTp!.ten.toString()}";
          }

          ///Mapping Chổ ở hiện tại
          if (taiKhoanResponse.diaChi != null) {
            addressController =
                TextEditingController(text: taiKhoanResponse.diaChi.toString());
          }

          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// load thông tin cơ bản
  ///
  void loadThongTinCoBan() {
    // viec mới
    dangKyViecMoiProvider.find(
      id: idViecMoi,
      onSuccess: (data) {
        dangKyViecMoiResponse = data;
        loadThongTinUser();
        //Tiêu đề
        if (data.tieuDe != null && data.tieuDe.toString() != "null") {
          titleController = TextEditingController(text: data.tieuDe.toString());
        }

        if (data.noiLamViec!.isNotEmpty) {
          data.noiLamViec!
              .map((e) => noiLamViecListString.add(e.toString()))
              .toList();
        }

        if (data.mucTieuNgheNghiep != null &&
            data.mucTieuNgheNghiep.toString() != "null") {
          mucTieuNgheNghiepController = TextEditingController(
              text: dangKyViecMoiResponse!.mucTieuNgheNghiep.toString());
        }

        if (data.kyNangSoTruong != null &&
            data.kyNangSoTruong.toString() != "null") {
          kyNangVaSoTruongLamViecController = TextEditingController(
              text: dangKyViecMoiResponse!.kyNangSoTruong.toString());
        }

        //Sở thích và trình độ
        if (data.phanMemHoTro != null &&
            data.phanMemHoTro.toString() != "null") {
          phanMemHoTroController = TextEditingController(
            text: dangKyViecMoiResponse!.phanMemHoTro.toString(),
          );
        }

        if (data.soThichKyNang != null &&
            data.soThichKyNang.toString() != "null") {
          soThichTheHienKyNangController = TextEditingController(
              text: dangKyViecMoiResponse!.soThichKyNang.toString());
        }

        if (data.soThichTrinhDo != null &&
            data.soThichTrinhDo.toString() != "null") {
          soThichTheHienTrinhDoController = TextEditingController(
              text: dangKyViecMoiResponse!.soThichTrinhDo.toString());
        }

        if (data.soTichTinhCach != null &&
            data.soTichTinhCach.toString() != "null") {
          soThichTheHienTinhCachController = TextEditingController(
              text: dangKyViecMoiResponse!.soTichTinhCach.toString());
        }

        //Tham khảo
        if (data.nguoiThamKhao != null &&
            data.nguoiThamKhao.toString() != "null") {
          nguoiThamKhaoController = TextEditingController(
              text: dangKyViecMoiResponse!.nguoiThamKhao.toString());
        }

        if (data.chucDanh != null && data.chucDanh.toString() != "null") {
          chucdanhController = TextEditingController(
              text: dangKyViecMoiResponse!.chucDanh.toString());
        }

        if (data.congTy != null && data.congTy.toString() != "null") {
          congTyController = TextEditingController(
              text: dangKyViecMoiResponse!.congTy.toString());
        }

        if (data.soDienThoai != null && data.soDienThoai.toString() != "null") {
          soDienThoaiController = TextEditingController(
              text: dangKyViecMoiResponse!.soDienThoai.toString());
        }

        //Maaping hôn nhân String
        if (dangKyViecMoiResponse!.honNhan != null ||
            dangKyViecMoiResponse!.honNhan.toString() != "null" ||
            dangKyViecMoiResponse!.honNhan!.isNotEmpty) {
          if (dangKyViecMoiResponse!.honNhan.toString().toLowerCase() == "1") {
            honNhanString = "Độc thân";
          } else if (dangKyViecMoiResponse!.honNhan.toString().toLowerCase() ==
              "2") {
            honNhanString = "Đã lập gia đình";
          } else if (dangKyViecMoiResponse!.honNhan.toString().toLowerCase() ==
              "3") {
            honNhanString = "Khác";
          }
        } else {
          honNhanString = "Độc Thân";
        }

        //Load ảnh hồ sơ xin việc
        for (final anhHoSoXinViecsModel in data.anhHoSoXinViecs!.toList()) {
          anhHoSoXinViecs.add(anhHoSoXinViecsModel.toString());
        }

        //Get Hình thức làm việc
        loadHinhThucLamViec(isLoadFrist: true);

        //Get chức vụ hiện tại
        loadChucVu(isLoadFrist: true);

        //Get số năm kinh nghiệm
        loadNamKinhNghiem();

        //Get nơi làm việc
        loadNoilamViec(isLoadFrist: true);

        //Get ngành nghề mong muốn
        loadChonNganhNgheMongMuon(isLoadFrist: true);

        ///
        /// Load Bảng bằng cấp của đăng ký việc mới
        ///
        for (final idBangBangCaps
            in dangKyViecMoiResponse!.idBangBangCaps!.toList()) {
          //add id bằng cấp
          idBangBangCap.add(idBangBangCaps.id);

          //add
          bangBangCapProvider.find(
            id: idBangBangCaps.toString(),
            onSuccess: (models) {
              bangBangCapDisplayResponse.add(idBangBangCaps);

              //add ảnh bằng cấp
              for (final anhBangCaps in idBangBangCaps.anhBangCap!.toList()) {
                anhBangCapsList.add(anhBangCaps as String);
                update();
              }
            },
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );
          update();
        }

        ///
        ///Load kê khai kinh nghiệm của đăng ký việc mới
        ///
        for (final idKeKhaiKinhNghiemModel
            in dangKyViecMoiResponse!.idKeKhaiKinhNghiems!.toList()) {
          //ad idKeKhaiKinh Nghiệm vào List
          idKeKhaiKinhNghiems.add(idKeKhaiKinhNghiemModel.id);
          //Add
          keKhaiKinhNghiemProvider.find(
            id: idKeKhaiKinhNghiemModel.toString(),
            onSuccess: (models) {
              //Add to List để format ngày bắt đầu và kết thúc
              keKhaiKinhNghiemResponseList.add(KeKhaiKinhNghiemResponse(
                id: idKeKhaiKinhNghiemModel.id,
                chucVu: idKeKhaiKinhNghiemModel.chucVu.toString(),
                congViecPhuTrach:
                    idKeKhaiKinhNghiemModel.congViecPhuTrach.toString(),
                donVi: idKeKhaiKinhNghiemModel.donVi.toString(),
                ketQua: idKeKhaiKinhNghiemModel.ketQua.toString(),
                mucLuong: CurrencyConverter.currencyConverterVND(
                    double.parse(idKeKhaiKinhNghiemModel.mucLuong.toString())),
                thoiGianBatDau: formatDateTime(
                    dateTime:
                        idKeKhaiKinhNghiemModel.thoiGianBatDau.toString()),
                thoiGianKetThuc: formatDateTime(
                    dateTime:
                        idKeKhaiKinhNghiemModel.thoiGianKetThuc.toString()),
              ));

              update();
            },
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );
          update();
        }

        ///
        /// mức lương đề xuất
        ///
        mucLuongDuKienProvider.all(
          onSuccess: (data) {
            if (data.isNotEmpty) {
              mucLuongDuKienList = data;

              if (dangKyViecMoiResponse!.idMucLuongDuKien != null) {
                mucLuongDuKienIndex = mucLuongDuKienList[
                    mucLuongDuKienList.indexWhere((element) =>
                        element.id ==
                        dangKyViecMoiResponse!.idMucLuongDuKien!.id)];
              }
            }
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );

        ///
        ///Load ngoại ngữ của đăng ký việc mới
        ///
        for (final idNgoaiNguModel
            in dangKyViecMoiResponse!.idNgoaiNgus!.toList()) {
          //ad id ngoại ngữ vào list
          idNgoaiNgu.add(idNgoaiNguModel.id);

          //add to list model
          ngoaiNguProvider.find(
            id: idNgoaiNguModel.id.toString(),
            onSuccess: (models) {
              ngoaiNguResponseList.add(NgoaiNguResponse(
                id: models.id,
                nghe: models.nghe,
                loaiNgoaiNgu: models.loaiNgoaiNgu,
                doc: models.doc,
                trinhDo: models.trinhDo,
                noi: models.noi,
                viet: models.viet,
              ));

              update();
            },
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );

          update();
        }

        ///
        ///Mapping tin học
        ///
        if (dangKyViecMoiResponse!.idTinHoc != null) {
          tinHocProvider.find(
            id: dangKyViecMoiResponse!.idTinHoc!.id.toString(),
            onSuccess: (models) {
              //add list
              idTinHoc = models.id!;

              //Mapping Word
              if (models.word!.isNotEmpty) {
                if (models.word.toString().toLowerCase() == "giỏi") {
                  tinHocWordSkill = 1;
                  update();
                } else if (models.word.toString().toLowerCase() == "khá") {
                  tinHocWordSkill = 2;
                  update();
                } else if (models.word.toString().toLowerCase() ==
                    "trung bình") {
                  tinHocWordSkill = 3;
                  update();
                } else if (models.word.toString().toLowerCase() == "yếu") {
                  tinHocWordSkill = 4;
                  update();
                }
              }

              //Mapping excel
              if (models.excel!.isNotEmpty) {
                if (models.excel.toString().toLowerCase() == "giỏi") {
                  tinHocExcelSkill = 1;
                  update();
                } else if (models.excel.toString().toLowerCase() == "khá") {
                  tinHocExcelSkill = 2;
                  update();
                } else if (models.excel.toString().toLowerCase() ==
                    "trung bình") {
                  tinHocExcelSkill = 3;
                  update();
                } else if (models.excel.toString().toLowerCase() == "yếu") {
                  tinHocExcelSkill = 4;
                  update();
                }
              }

              //Mapping Internet
              if (models.internet!.isNotEmpty) {
                if (models.internet.toString().toLowerCase() == "giỏi") {
                  tinHocInternetSkill = 1;
                  update();
                } else if (models.internet.toString().toLowerCase() == "khá") {
                  tinHocInternetSkill = 2;
                  update();
                } else if (models.internet.toString().toLowerCase() ==
                    "trung bình") {
                  tinHocInternetSkill = 3;
                  update();
                } else if (models.internet.toString().toLowerCase() == "yếu") {
                  tinHocInternetSkill = 4;
                  update();
                }
              }

              //add models
              tinHocRequest = TinHocRequest(
                id: models.id,
                excel: models.excel,
                internet: models.internet,
                word: models.word,
              );
              update();
            },
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );
        }

        //Mapping hồ sơ xin việc
        if (data.fileHoSoXinViec!.isNotEmpty &&
            data.fileHoSoXinViec != null &&
            data.fileHoSoXinViec.toString() != "null") {
          hoSoXinViecsFile = data.fileHoSoXinViec!;
        }

        //Mapping file hồ sơ xin việc
        if (data.fileHoSoXinViec!.isNotEmpty &&
            data.fileHoSoXinViec != null &&
            data.fileHoSoXinViec.toString() != "null") {
          filePath = data.fileHoSoXinViec.toString();
        }

        //Get Data TinhTP
        getDataTinhTp(isLoadFrist: true);

        ///Mapping Chổ ở hiện tại
        addressController = TextEditingController(
            text: dangKyViecMoiResponse!.diaChi
                .toString()
                .replaceAll("null", taiKhoanResponse.diaChi.toString()));

        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    ///
    /// load trình độ
    ///
    trinhDoHocVanProvider.all(
      onSuccess: (data) {
        trinhDo = data;
        if (data.isNotEmpty) {
          trinhDoIndex = data.first;
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    ///
    /// load chuyên môn
    ///
    loaiCongViecProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idNhomDichVu=${app_constants.NHOM_DICH_VU_7}",
      onSuccess: (data) {
        chuyenMon = data;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    ///
    /// load tốt nghiệp\
    ///
    loaiTotNghiepProvider.all(
      onSuccess: (data) {
        loaiTotNghiep = data;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );

    ///
    /// load trinh do
    ///
    trinhDoHocVanProvider.all(onSuccess: (data) {
      trinhDoHocVanList = data;
    }, onError: (error) {
      print("TermsAndPolicyController getTermsAndPolicy onError $error");
    });
  }

  ///
  ///Load nơi làm việc
  ///
  void loadNoilamViec({required bool isLoadFrist}) {
    tinhTpProvider.all(
      onSuccess: (model) {
        tinhTpResponseList = model;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///Load chọn ngành nghề mong muốn
  ///
  void loadChonNganhNgheMongMuon({required bool isLoadFrist}) {
    // ngành nghề muôn ứng chuyển tuyển
    loaiCongViecProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idNhomDichVu=${app_constants.NHOM_DICH_VU_7}",
      onSuccess: (data) {
        chuyenNganhChinhList = data;
        if (data.isNotEmpty) {
          chuyenNganhChinhList = data;
          if (dangKyViecMoiResponse != null) {
            if (dangKyViecMoiResponse!.idNganhNgheMongMuons != null) {
              for (final chuyenNganhModel
                  in dangKyViecMoiResponse!.idNganhNgheMongMuons!.toList()) {
                chuyenMonResponse = chuyenNganhChinhList![chuyenNganhChinhList!
                    .indexWhere((e) => e.id == chuyenNganhModel.id)];
                chuyenNganhChinhSelected.add(chuyenMonResponse);
                idNganhNgheMongMuonsList.add(chuyenMonResponse!.id);
                update();
              }
            }
          }
          isLoading = false;
        }

        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///Load năm kinh nghiệm
  ///
  void loadNamKinhNghiem() {
    // năm kinh nghiệm
    soNamKinhNghiemProvider.all(
      onSuccess: (data) {
        soNamKinhNghiemList = data;

        //mapping năm kinh nghiệm
        if (dangKyViecMoiResponse != null) {
          if (dangKyViecMoiResponse!.idSoNamKinhNghiem != null) {
            soNamKinhNghiemIndex = soNamKinhNghiemList[
                soNamKinhNghiemList.indexWhere((element) =>
                    element.id ==
                    dangKyViecMoiResponse!.idSoNamKinhNghiem!.id)];
          }
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// Chức vụ kinh nghiệm mưc lương
  ///
  void loadChucVu({required bool isLoadFrist}) {
    // chức vụ hiện tại
    chucVuProvider.all(
      onSuccess: (data) {
        chucVuList = data;

        //mapping chức vụ hiện tại
        if (isLoadFrist) {
          if (dangKyViecMoiResponse != null) {
            if (dangKyViecMoiResponse!.chucVuHienTai != null &&
                dangKyViecMoiResponse!.chucVuHienTai!.isNotEmpty &&
                dangKyViecMoiResponse!.chucVuHienTai.toString() != "" &&
                dangKyViecMoiResponse!.chucVuHienTai.toString() != "null") {
              // chucVuList
              chucVuHienTaiIndex = chucVuList[chucVuList.indexWhere((element) =>
                  element.tieuDe.toString().toLowerCase() ==
                  dangKyViecMoiResponse!.chucVuHienTai
                      .toString()
                      .toLowerCase())];
            }
          }
          if (isLoadFrist) {
            //mapping chức vụ mong muốn
            if (dangKyViecMoiResponse != null) {
              if (dangKyViecMoiResponse!.chucVuMongMuon != null &&
                  dangKyViecMoiResponse!.chucVuMongMuon!.isNotEmpty &&
                  dangKyViecMoiResponse!.chucVuMongMuon.toString() != "" &&
                  dangKyViecMoiResponse!.chucVuMongMuon.toString() != "null") {
                chucVuMongMuonIndex = chucVuList.firstWhere((element) =>
                    element.tieuDe.toString().toLowerCase() ==
                    dangKyViecMoiResponse!.chucVuMongMuon
                        .toString()
                        .toLowerCase());
              }
            }
          }
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///Load Hình thức làm việc
  ///
  void loadHinhThucLamViec({required bool isLoadFrist}) {
    hinhThucLamViecProvider.all(onSuccess: (data) {
      hinhThucLamViec = data;

      if (isLoadFrist) {
        if (dangKyViecMoiResponse != null) {
          if (dangKyViecMoiResponse!.idHinhThucLamViec != null) {
            hinhThucLamViecIndex = hinhThucLamViec[hinhThucLamViec.indexWhere(
                (element) =>
                    element.id ==
                    dangKyViecMoiResponse!.idHinhThucLamViec!.id)];
          }
        }
      }
    }, onError: (error) {
      print("TermsAndPolicyController getTermsAndPolicy onError $error");
    });
  }

  ///
  /// load data tỉnh Tp
  ///
  void getDataTinhTp({required bool isLoadFrist}) {
    //list hinh thuc lam iec
    tinhTpProvider.all(
        onSuccess: (value) {
          //add list
          tinhTpListModel = value;
          tinhTpListModel.removeWhere((e) => e.id == idTinhToanQuoc);

          if (isLoadFrist) {
            if (dangKyViecMoiResponse != null) {
              if (dangKyViecMoiResponse!.idTinhTp != null) {
//set idTinh
                tinhTp = value.firstWhere((element) => element.ten!
                    .contains(dangKyViecMoiResponse!.idTinhTp.toString()));

                getDataQuanHuyen(
                    idTinh: tinhTp!.id.toString(), isLoadFrist: true);
              }
            } else {
              if (taiKhoanResponse.idTinhTp != null) {
                //set idTinh
                tinhTp = value.firstWhereOrNull((element) => element.ten!
                    .contains(taiKhoanResponse.idTinhTp!.ten!.toString()));
                getDataQuanHuyen(
                    idTinh: tinhTp!.id.toString(), isLoadFrist: true);
              } else {
                tinhTp = tinhTpListModel.first;
                getDataQuanHuyen(
                    idTinh: tinhTp!.id.toString(), isLoadFrist: false);
              }
            }
          }
          update();
        },
        onError: (error) => print('V2CvController getDataTinhTp $error'));
  }

  ///
  /// load data quận huyện
  ///
  void getDataQuanHuyen({required String idTinh, required bool isLoadFrist}) {
    quanHuyenProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idTinhTp=$idTinh',
        onSuccess: (value) {
          quanHuyenResponse = null;
          phuongXaResponse = null;
          quanHuyenListModel.clear();
          phuongXaListModel.clear();
          if (value.isNotEmpty) {
            quanHuyenListModel.addAll(value);
            quanHuyenResponse = quanHuyenListModel.first;

            //mapping quận huyện lần đầu
            if (isLoadFrist) {
              if (dangKyViecMoiResponse != null) {
                if (dangKyViecMoiResponse!.idQuanHuyen != null) {
                  quanHuyenResponse = quanHuyenListModel.firstWhere((element) =>
                      element.ten!.contains(
                          dangKyViecMoiResponse!.idQuanHuyen.toString()));
                } else {
                  quanHuyenResponse = quanHuyenListModel.firstWhere((element) =>
                      element.ten!
                          .contains(taiKhoanResponse.idQuanHuyen.toString()));
                }
              }
              // xã khi chon huỵen
              getDataPhuongXa(
                  idHuyen: quanHuyenResponse!.id.toString(), isLoadFrist: true);
            }
            // xã khi chon huỵen
            getDataPhuongXa(
                idHuyen: quanHuyenResponse!.id.toString(), isLoadFrist: false);
          }

          update();
        },
        onError: (error) => print('V2CvController getDataQuanHuyen $error'));
  }

  ///
  /// load data phường xã
  ///
  void getDataPhuongXa({required String idHuyen, required bool isLoadFrist}) {
    phuongXaProvider.paginate(
        page: 1,
        limit: 100,
        filter: '&idQuanHuyen=$idHuyen',
        onSuccess: (value) {
          phuongXaResponse = null;
          phuongXaListModel.clear();
          if (value.isNotEmpty) {
            phuongXaListModel.addAll(value);
            phuongXaResponse = phuongXaListModel.first;

            //mapping xã phường lần đầu
            if (isLoadFrist) {
              if (dangKyViecMoiResponse != null) {
                if (dangKyViecMoiResponse!.idPhuongXa != null) {
                  phuongXaResponse = phuongXaListModel.firstWhere((element) =>
                      element.ten!.contains(
                          dangKyViecMoiResponse!.idPhuongXa.toString()));
                } else {
                  phuongXaResponse = phuongXaListModel.firstWhere((element) =>
                      element.ten!
                          .contains(taiKhoanResponse.idPhuongXa.toString()));
                }
              }
            }
          }
          //set isLoading
          isLoading = false;
          update();
        },
        onError: (error) => print('V2CvController getDataPhuongXa $error'));
  }

  ///
  ///Thay đổi hôn nhân
  ///
  void onChangedHonNhan(HonNhanModel honnhan) {
    honNhanModel = honnhan;
    update();
  }

  ///
  /// hình thức làm việc
  ///
  void hinhThucLamViecChange(HinhThucLamViecResponse val) {
    hinhThucLamViecIndex = val;
    update();
  }

  ///
  /// trình độ
  ///
  void trinhDoHocVanChange(TrinhDoHocVanResponse val) {
    trinhDoHocVanResponseIndex = val;
    customHintTextTrinhDo = false;
    update();
  }

  ///
  /// chuyên môn
  ///
  void chuyenMonChange(LoaiCongViecResponse val) {
    chuyenMonIndex = val;
    customHintTextChuyenMon = false;
    update();
  }

  ///
  /// hình thức làm việc
  ///
  void loaiTotNghiepChange(LoaiTotNghiepResponse val) {
    loaiTotNghiepIndex = val;
    update();
  }

  ///
  /// Xoá bằng cấp
  ///
  void deleteBangCap(BangBangCapResponse bangCap) {
    bangBangCapDisplayResponse
        .removeWhere((element) => element.hashCode == bangCap.hashCode);
    idBangBangCap
        .removeWhere((element) => element.hashCode == bangCap.id.hashCode);
    // Xóa ở server
    bangBangCapProvider.delete(
      id: bangCap.id.toString(),
      onSuccess: (value) {},
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
    update();
  }

  ///
  /// Xoá kê khai kinh nghiệm
  ///
  void deleteKeKhaiKinhNghiem(KeKhaiKinhNghiemResponse keKhaiKinhNghiem) {
    idKeKhaiKinhNghiems.removeWhere((e) => e == keKhaiKinhNghiem.id);
    keKhaiKinhNghiemResponseList
        .removeWhere((e) => e.hashCode == keKhaiKinhNghiem.hashCode);

    // Xóa ở server
    keKhaiKinhNghiemProvider.delete(
      id: keKhaiKinhNghiem.id.toString(),
      onSuccess: (value) {},
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
    update();
  }

  ///
  /// Xoá bằng ngoại ngữ
  ///
  void deleteNgoaiNgu(NgoaiNguResponse ngoaiNgu) {
    ngoaiNguResponseList
        .removeWhere((element) => element.hashCode == ngoaiNgu.hashCode);
    idNgoaiNgu
        .removeWhere((element) => element.hashCode == ngoaiNgu.id.hashCode);

    // Xóa ở server
    ngoaiNguProvider.delete(
      id: ngoaiNgu.id.toString(),
      onSuccess: (value) {},
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
    update();
  }

  ///
  /// thêm bằng cấp mới
  ///
  void themBangCapMoi() {
    EasyLoading.show(status: "Loading...");
    if (bangCapValidate()) {
      final DateTime year = DateFormat("yyyy").parse(
          namTotNghiepController.text.split("-").reversed.toList().join("-"));
      // Thêm bằng cấp
      sl.get<SharedPreferenceHelper>().userId.then((value) {
        bangBangCapProvider.add(
          data: BangBangCapRequest(
            idTaiKhoan: value,
            idTrinhDo: trinhDoHocVanResponseIndex!.id,
            idChuyenMon: chuyenMonIndex!.id,
            idLoaiTotNghiep: loaiTotNghiepIndex!.id,
            namTotNghiep: year.toString().substring(0, 4),
            donViDaoTao: donViDaotaoController.text.trim(),
            anhBangCaps: anhBangCaps,
          ),
          onSuccess: (model) {
            //Add id bằng cấp vào list
            idBangBangCap.add(model.id.toString());

            //Add ảnh bằng cấp vào list
            for (final anhBangCapModel in model.anhBangCaps!.toList()) {
              anhBangCapsList.add(anhBangCapModel as String);
            }

            // Thêm bảng bằng cấp
            bangBangCapDisplayResponse.add(BangBangCapResponse(
              id: model.id.toString(),
              donViDaoTao: donViDaotaoController.text.trim(),
              namTotNghiep: namTotNghiepController.text.trim(),
              idChuyenMon: chuyenMonIndex,
              idLoaiTotNghiep: loaiTotNghiepIndex,
              idTrinhDo: trinhDoHocVanResponseIndex,
            ));

            //clear data
            trinhDoHocVanResponseIndex = null;
            customHintTextTrinhDo = false;
            chuyenMonIndex = null;
            customHintTextChuyenMon = false;
            loaiTotNghiepIndex = null;
            donViDaotaoController.text = "";
            namTotNghiepController = TextEditingController();
            anhBangCaps.clear();
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );

        lengthBangCap += 1;
        Get.snackbar(
          "Thông báo!",
          "Bạn có thể thêm nhiều bằng cấp khác nhau!",
          backgroundColor: Colors.blue[200],
          duration: const Duration(seconds: 3),
        );
        EasyLoading.dismiss();
        update();
      });
    } else {
      EasyLoading.dismiss();
    }
    EasyLoading.dismiss();

    update();
  }

  ///
  /// validate ke khai
  ///
  bool bangCapValidate() {
    if (trinhDoHocVanResponseIndex == null) {
      Alert.error(message: "Trình độ học vấn không được để trống!");

      return false;
    }

    if (chuyenMonIndex == null) {
      Alert.error(message: "Chuyên môn không được để trống!");

      return false;
    }

    if (loaiTotNghiepIndex == null) {
      Alert.error(message: "Loại tốt nghiệp không được để trống!");

      return false;
    }

    if (namTotNghiepController.text.isEmpty) {
      Alert.error(message: "Năm tốt nghiệp không được để trống!");

      return false;
    }

    if (donViDaotaoController.text.isEmpty) {
      Alert.error(message: "Đơn vị đào tạo không được để trống!");

      return false;
    }

    return true;
  }

  ///
  /// Pick Ảnh Bằng Cấp
  ///
  Future pickAnhBangCaps({required List<String> data}) async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();
      // load images
      imageUpdateProvider.addImages(
        files: files,
        onSuccess: (value) {
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            data.addAll(value.files!);
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  ///
  /// Pick Ảnh Hồ Sơ Xin Việc
  ///
  Future pickAnhHoSoXinViecs({required List<String> data}) async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<File> files = images.map((e) => File(e.path)).toList();

      // load images
      imageUpdateProvider.addImages(
        files: files,
        onSuccess: (value) {
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            data.addAll(value.files!);
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  ///
  /// Pick multi files
  ///
  Future pickFiles() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      EasyLoading.show(status: 'Loading...');

      final List<PlatformFile> files = result.files;
      // load files
      imageUpdateProvider.addFiles(
        files: files,
        onSuccess: (value) {
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            hoSoXinViecsFile = value.files![0];
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          Alert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      Alert.error(message: e.toString());
    }
  }

  ///
  /// Xoá hình ảnh
  ///
  void onDeleteImage({required String file, required List<String> files}) {
    files.removeWhere((element) => element.hashCode == file.hashCode);
    update();
  }

  ///
  /// thêm kê khai kinh nghiệm
  ///
  void themKeKhaiKinhNghiem() {
    EasyLoading.show(status: "Loading...");
    final DateTime timeStart = DateTime.parse(DateFormat('dd-MM-yyyy')
        .parse(startTimeController.text.trim())
        .toString()
        .substring(0, 10));
    final DateTime timeEnd = DateTime.parse(DateFormat('dd-MM-yyyy')
        .parse(endTimeController.text.trim())
        .toString()
        .substring(0, 10));

    if (!timeEnd.isBefore(timeStart)) {
      if (keKhaiValidate()) {
        sl.get<SharedPreferenceHelper>().userId.then((value) {
          //Thêm data kê khai kinh nghiệm
          keKhaiKinhNghiemProvider.add(
            data: KeKhaiKinhNghiemRequest(
              idTaiKhoan: value,
              thoiGianBatDau: timeStart.toString(),
              thoiGianKetThuc: timeEnd.toString(),
              donVi: donViController.text.trim(),
              chucVu: chucVuController.text.trim(),
              mucLuong: mucLuongController.text.replaceAll(".", '').trim(),
              congViecPhuTrach: congViecPhuTrachController.text.trim(),
              ketQua: ketQuaController.text.trim(),
            ),
            onSuccess: (models) {
              // Add List Id Kê khai kinh nghiệm
              idKeKhaiKinhNghiems.add(models.id.toString());

              //Thêm bẳng kê khai kinh nghiệm
              keKhaiKinhNghiemResponseList.add(KeKhaiKinhNghiemResponse(
                id: models.id.toString(),
                chucVu: chucVuController.text.trim(),
                congViecPhuTrach: congViecPhuTrachController.text.trim(),
                donVi: donViController.text.trim(),
                ketQua: ketQuaController.text.trim(),
                mucLuong: mucLuongController.text.trim(),
                thoiGianBatDau: startTimeController.text.trim(),
                thoiGianKetThuc: endTimeController.text.trim(),
              ));

              //Clear data
              startTimeController = TextEditingController();
              endTimeController = TextEditingController();
              donViController.text = "";
              chucVuController.text = "";
              mucLuongController.text = "";
              congViecPhuTrachController.text = "";
              ketQuaController.text = "";
              EasyLoading.dismiss();
              Get.snackbar(
                "Thông báo!",
                "Bạn có thể thêm nhiều kê khai kinh nghiệm khác nhau!",
                backgroundColor: Colors.blue[200],
                duration: const Duration(seconds: 3),
              );

              update();
            },
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );

          EasyLoading.dismiss();
          update();
        });
      } else {
        EasyLoading.dismiss();
        update();
      }
    } else {
      Alert.error(
          message: "Ngày kết thúc không được phép sớm hơn ngày bắt đầu!");
      update();
    }

    EasyLoading.dismiss();
    update();
  }

  ///
  ///Chọn ngoại ngữ
  ///
  dynamic chonNgoaiNgu(String? value) {
    ngoaiNgu = value;
    update();
  }

  ///
  ///Chọn trình độ ngoại ngữ
  ///
  dynamic chonTrinhDoNgoaiNgu(String? value) {
    trinhDoNgoaiNgu = value;
    update();
  }

  ///
  /// ngoại ngữ - nghe
  ///
  dynamic ngoaiNguNghe(int? val) {
    ngoaiNguListenSkill = val!;
    update();
  }

  ///
  /// ngoại ngữ - nói
  ///
  dynamic ngoaiNguNoi(int? val) {
    ngoaiNguSpeakSkill = val!;
    update();
  }

  ///
  /// ngoại ngữ - đọc
  ///
  dynamic ngoaiNguDoc(int? val) {
    ngoaiNguReadSkill = val!;
    update();
  }

  ///
  /// ngoại ngữ - viết
  ///
  dynamic ngoaiNguViet(int? val) {
    ngoaiNguWriteSkill = val!;
    update();
  }

  ///
  /// ngoại ngữ -thêm
  ///
  void ngoaiNguThem() {
    final List<String> status = ["Giỏi", "Khá", "Trung Bình", "yếu"];
    if (ngoaiNguValidate()) {
      sl.get<SharedPreferenceHelper>().userId.then((value) {
        //Thêm data ngoại ngữ
        ngoaiNguProvider.add(
          data: NgoaiNguRequest(
            idTaiKhoan: value,
            loaiNgoaiNgu: ngoaiNguController.text.trim(),
            trinhDo: trinhDoController.text.trim(),
            nghe: status[ngoaiNguListenSkill - 1],
            noi: status[ngoaiNguSpeakSkill - 1],
            doc: status[ngoaiNguReadSkill - 1],
            viet: status[ngoaiNguWriteSkill - 1],
          ),
          onSuccess: (models) {
            idNgoaiNgu.add(models.id.toString());
            ngoaiNguResponseList.add(NgoaiNguResponse(
              id: models.id.toString(),
              loaiNgoaiNgu: ngoaiNguController.text.trim(),
              trinhDo: trinhDoController.text.trim(),
              nghe: status[ngoaiNguListenSkill - 1],
              noi: status[ngoaiNguSpeakSkill - 1],
              doc: status[ngoaiNguReadSkill - 1],
              viet: status[ngoaiNguWriteSkill - 1],
            ));

            //clear data
            ngoaiNguController = TextEditingController();
            trinhDoController = TextEditingController();
            ngoaiNguListenSkill = 1;
            ngoaiNguSpeakSkill = 1;
            ngoaiNguReadSkill = 1;
            ngoaiNguWriteSkill = 1;
            Get.snackbar(
              "Thông báo!",
              "Bạn có thể thêm nhiều bằng cấp ngoại ngữ khác nhau!",
              backgroundColor: Colors.blue[200],
              duration: const Duration(seconds: 3),
            );
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );

        update();
      });
    }
  }

  ///
  ///Validate Ngoại Ngữ
  ///
  bool ngoaiNguValidate() {
    if (ngoaiNguController.text.isEmpty) {
      Alert.error(message: "Loại ngoại ngữ không được để trống!");
      return false;
    }
    if (trinhDoController.text.isEmpty) {
      Alert.error(message: "Trình độ ngoại ngữ không được để trống!");
      return false;
    }
    return true;
  }

  void onchangHonNhanString(String? honNhan) {
    honNhanString = honNhan;
    update();
  }

  ///
  /// ngoại ngữ - word
  ///
  dynamic tinHocWord(int? val) {
    tinHocWordSkill = val!;
    update();
  }

  ///
  /// ngoại ngữ - excel
  ///
  dynamic tinHocExcel(int? val) {
    tinHocExcelSkill = val!;
    update();
  }

  ///
  /// ngoại ngữ - internet
  ///
  dynamic tinHocInternet(int? val) {
    tinHocInternetSkill = val!;
    update();
  }

  ///
  ///onChange TinhTP
  ///
  void onChangeTinhTP(TinhTpResponse? value) {
    tinhTpResponse = value;
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedTinhTp(TinhTpResponse idtinhTp) {
    tinhTp = idtinhTp;
    getDataQuanHuyen(idTinh: idtinhTp.id.toString(), isLoadFrist: false);
    update();
  }

  ///
  ///Thay đổi quận huyện
  ///
  void onChangedQuanHuyen(QuanHuyenResponse quanHuyen) {
    quanHuyenResponse = quanHuyen;
    getDataPhuongXa(idHuyen: quanHuyen.id.toString(), isLoadFrist: false);
    update();
  }

  ///
  ///Thay đổi tỉnh thành
  ///
  void onChangedPhuongXa(PhuongXaResponse phuongXa) {
    phuongXaResponse = phuongXa;
    update();
  }

  ///
  /// tin học -thêm
  ///
  void tinHocThem() {
    if (isAddTinHoc == false) {
      EasyLoading.show(status: 'Loading...');

      final List<String> status = ["Giỏi", "Khá", "Trung Bình", "yếu"];
      sl.get<SharedPreferenceHelper>().userId.then((value) {
        //Thêm data
        tinHocProvider.add(
          data: TinHocRequest(
            idTaiKhoan: value,
            word: status[tinHocWordSkill - 1],
            excel: status[tinHocExcelSkill - 1],
            internet: status[tinHocInternetSkill - 1],
          ),
          onSuccess: (models) {
            idTinHoc = models.id.toString();
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );

        tinHocRequest = TinHocRequest(
          excel: status[tinHocExcelSkill - 1],
          idTaiKhoan: value.toString(),
          internet: status[tinHocInternetSkill - 1],
          word: status[tinHocWordSkill - 1],
        );

        EasyLoading.dismiss();
        isAddTinHoc = true;
        update();
      });
      EasyLoading.dismiss();
      update();
    } else {
      Alert.error(message: "Bạn chỉ được thêm một bằng tin học!");
    }
  }

  ///
  /// chức vụ hiện tại
  ///
  void onChucVuHienTaiChange(ChucVuResponse val) {
    chucVuHienTaiIndex = val;
    update();
  }

  ///
  /// chức vụ mong muốn
  ///
  void onChucVuMongMuonChange(ChucVuResponse val) {
    chucVuMongMuonIndex = val;
    update();
  }

  ///
  /// on Nam Kinh Nghiem Change
  ///
  void onNamKinhNghiemChange(SoNamKinhNghiemResponse val) {
    soNamKinhNghiemIndex = val;
    update();
  }

  ///
  /// on Muc Luong De Xuat Change
  ///
  void onMucLuongDeXuatChange(MucLuongDuKienResponse val) {
    mucLuongDuKienIndex = val;
    update();
  }

  ///
  /// on Noi Lam Viec Change
  ///
  void onNoiLamViecChange(DiaDiemDangKyLamViecResponse? val) {
    diaDiemDangKyLamViecIndex = val;
    update();
  }

  ///
  /// on Nghe Nghiep Mong Muon Ung Tuyen Change
  ///
  void onNgheNghiepMongMuonUngTuyenChange(ChuyenNganhChinhResponse val) {
    chuyenNganhChinhIndex = val;
    update();
  }

  ///
  /// on NoiLam viec
  ///
  void onNoiLamViecMulti(List<TinhTpResponse?> val) {
    noiLamViecSelected = val;
    noiLamViecListString.clear();
    for (final model in noiLamViecSelected) {
      noiLamViecListString.add(model!.ten.toString());
    }
    update();
  }

  ///
  /// on Nghe Nghiep Mong Muon Ung Tuyen Change
  ///
  void onNgheNghiepMongMuonUngTuyenChanged(List<LoaiCongViecResponse?> val) {
    chuyenNganhChinhSelected = val;
    idNganhNgheMongMuonsList.clear();
    for (final model in chuyenNganhChinhSelected) {
      idNganhNgheMongMuonsList.add(model!.id);
    }
    update();
  }

  ///
  /// onMucLuongChange
  ///
  void onMucLuongChange(ChuyenNganhChinhResponse val) {
    chuyenNganhChinhIndex = val;
    update();
  }

  ///
  /// load file
  ///
  Future<void> launchURL() async => await canLaunch(filePath)
      ? await launch(filePath)
      : throw 'Could not launch $filePath';

  ///
  /// validate ke khai
  ///
  bool keKhaiValidate() {
    if (startTimeController.text.isEmpty) {
      Alert.error(message: "Ngày bắt đầu không được để trống!");

      return false;
    }

    if (endTimeController.text.isEmpty) {
      Alert.error(message: "Ngày kết thuc không được để trống!");

      return false;
    }

    if (donViController.text.isEmpty) {
      Alert.error(message: "Đơn vị không được để trống!");

      return false;
    }

    if (chucVuController.text.isEmpty) {
      Alert.error(message: "Chức vụ không được để trống!");

      return false;
    }

    if (mucLuongController.text.isEmpty) {
      Alert.error(message: "Mức lương không được để trống!");

      return false;
    }

    if (congViecPhuTrachController.text.isEmpty) {
      Alert.error(message: "Công việc phụ trách không được để trống!");

      return false;
    }

    if (ketQuaController.text.isEmpty) {
      Alert.error(message: "Kết quả/thành tích đạt được không được để trống!");

      return false;
    }

    return true;
  }

  ///
  /// Xem trươc
  ///
  void onClickPreviewButton() {
    if (validateGoto()) {
      EasyLoading.show(status: "Loading...");
      final List<String> status = ["Giỏi", "Khá", "Trung Bình", "yếu"];
      sl.get<SharedPreferenceHelper>().userId.then((value) {
        //Thêm data
        tinHocProvider.add(
          data: TinHocRequest(
            idTaiKhoan: value,
            word: status[tinHocWordSkill - 1],
            excel: status[tinHocExcelSkill - 1],
            internet: status[tinHocInternetSkill - 1],
          ),
          onSuccess: (models) {
            idTinHoc = models.id.toString();
            tinHocRequest = TinHocRequest(
              excel: status[tinHocExcelSkill - 1],
              idTaiKhoan: value.toString(),
              internet: status[tinHocInternetSkill - 1],
              word: status[tinHocWordSkill - 1],
            );

            if (isFirstRegister7Group == false) {
              print("Đã truyển $isFirstRegister7Group");
              Get.to(
                V2WorkPreviewPage(
                  dangKyModel: DangKyViecMoiModel(
                    isFirstRegister7Group: isFirstRegister7Group,
                    // maSoHoSo: dangKyViecMoiResponse!.maSoHoSo,
                    kyNangSoTruong:
                        kyNangVaSoTruongLamViecController.text.trim(),
                    lengthBangBangCap: lengthBangCap,
                    dienThoai: dienThoai,
                    email: email,
                    gioiTinh: gioiTinh,
                    hinhThucLamViecLabel: hinhThucLamViecIndex!.tieuDe,
                    hinhThucLamViec: hinhThucLamViecIndex!.id,
                    honNhan: honNhanString,
                    keKhaiKinhNghiems: keKhaiKinhNghiemResponseList,
                    mucTieuNgheNghiep: mucTieuNgheNghiepController.text.trim(),
                    ngaySinh: ngaySinh,
                    ngoaiNguList: ngoaiNguResponseList,

                    // sở thích
                    phanMemHoTro: phanMemHoTroController.text.trim(),
                    soThichTheHienKyNang:
                        soThichTheHienKyNangController.text.trim(),
                    soThichTheHienTinhCach:
                        soThichTheHienTinhCachController.text.trim(),
                    soThichTheHienTrinhDo:
                        soThichTheHienTrinhDoController.text.trim(),

                    //
                    tenUngVien: tenUngVien,
                    tieuDe: titleController.text.trim(),
                    tinHoc: tinHocRequest,

                    //Tuyển dụng
                    tuyenDung: tuyenDung,

                    // Địa chỉ
                    choOHienTai: addressController.text.trim(),
                    tinhTpResponse: tinhTp,
                    quanHuyenResponse: quanHuyenResponse,
                    phuongXaResponse: phuongXaResponse,

                    //
                    chucVuHienTai: chucVuHienTaiIndex!.tieuDe,
                    chucVuMongMuon: chucVuMongMuonIndex!.tieuDe,
                    namKinhNghiem: soNamKinhNghiemIndex!.tieuDe,
                    mucLuongDeXuat: mucLuongDuKienIndex,
                    noiLamViec: noiLamViecListString,
                    nghanhNgheMongMuon: chuyenNganhChinhSelected,
                    idSoNamKinhNghiem: soNamKinhNghiemIndex!.id,
                    idBangBangCap: idBangBangCap,
                    idKeKhaiKinhNghiems: idKeKhaiKinhNghiems,
                    idNgoaiNgu: idNgoaiNgu,
                    idTinHoc: idTinHoc,
                    anhBangCaps: anhBangCaps,
                    anhHoSoXinViecs: anhHoSoXinViecs,
                    idNganhNgheMongMuons: idNganhNgheMongMuonsList,
                    idNoiLamViecs: noiLamViecListString,
                    fileHoSoXinViec: hoSoXinViecsFile,
                    anhBangCapsList: anhBangCapsList,

                    //Tham khảo
                    nguoiThamKhao: nguoiThamKhaoController.text.trim(),
                    chucDanh: chucdanhController.text.trim(),
                    congTy: congTyController.text.trim(),
                    soDienThoai: soDienThoaiController.text.trim(),

                    //Data from Param
                    idNhomDichVu:
                        getDataParamRegister["idNhomDichVuParam"].toString(),
                    idLoaiConViec: getDataParamRegister["idLoaiCongViecVuParam"]
                        .toString(),
                    thoiGianBatDau:
                        getDataParamRegister["thoiGianBatDauParam"].toString(),
                    thoiGianKetThuc:
                        getDataParamRegister["thoiKetThucDauParam"].toString(),
                    soLuong: getDataParamRegister["soLuongParam"].toString(),
                    isCheckHCM: getDataParamRegister["isCheckHCM"].toString(),
                    quanHuyenHoChiMinh:
                        getDataParamRegister["quanHuyenHoChiMinhParam"]
                            .toString(),
                    phuongXaHoChiMinh:
                        getDataParamRegister["phuongXaHoChiMinhParam"]
                            .toString(),
                    isCheckHN: getDataParamRegister["isCheckHN"].toString(),
                    quanHuyenHaNoi:
                        getDataParamRegister["quanHuyenHaNoiParam"].toString(),
                    phuongXaHaNoi:
                        getDataParamRegister["phuongXaHaNoiParam"].toString(),
                    isCheckDN: getDataParamRegister["isCheckDN"].toString(),
                    quanHuyenDaNang:
                        getDataParamRegister["quanHuyenDaNangParam"].toString(),
                    phuongXaDaNang:
                        getDataParamRegister["phuongXaDaNangParam"].toString(),
                    isCheckTinhTPKhac:
                        getDataParamRegister["isCheckTinhTPKhac"].toString(),
                    tinhTpKhac:
                        getDataParamRegister["tinhTpKhacParam"].toString(),
                    quanHuyenKhac:
                        getDataParamRegister["quanHuyenKhacParam"].toString(),
                    phuongXaKhac:
                        getDataParamRegister["phuongXaKhacParam"].toString(),
                    listDiaDiemKhac: getDataParamRegister["listDiaDiemKhac"]
                        as List<String?>,
                  ),
                  bangBangCapDisplayResponse: bangBangCapDisplayResponse,
                  idTuyenDung: idTuyenDung,
                ),
              )!
                  .then((value) {
                if (value != null && value == true) {
                  Get.back(result: true);
                }
              });
            } else {
              print("Chưa thêm truyển $isFirstRegister7Group");
              Get.to(
                V2WorkPreviewPage(
                  dangKyModel: DangKyViecMoiModel(
                    isFirstRegister7Group: isFirstRegister7Group,
                    // maSoHoSo: dangKyViecMoiResponse!.maSoHoSo,
                    kyNangSoTruong:
                        kyNangVaSoTruongLamViecController.text.trim(),
                    lengthBangBangCap: lengthBangCap,
                    dienThoai: dienThoai,
                    email: email,
                    gioiTinh: gioiTinh,
                    hinhThucLamViecLabel: hinhThucLamViecIndex!.tieuDe,
                    hinhThucLamViec: hinhThucLamViecIndex!.id,
                    honNhan: honNhanString,
                    keKhaiKinhNghiems: keKhaiKinhNghiemResponseList,
                    mucTieuNgheNghiep: mucTieuNgheNghiepController.text.trim(),
                    ngaySinh: ngaySinh,
                    ngoaiNguList: ngoaiNguResponseList,

                    // sở thích
                    phanMemHoTro: phanMemHoTroController.text.trim(),
                    soThichTheHienKyNang:
                        soThichTheHienKyNangController.text.trim(),
                    soThichTheHienTinhCach:
                        soThichTheHienTinhCachController.text.trim(),
                    soThichTheHienTrinhDo:
                        soThichTheHienTrinhDoController.text.trim(),

                    //
                    tenUngVien: tenUngVien,
                    tieuDe: titleController.text.trim(),
                    tinHoc: tinHocRequest,

                    //Tuyển dụng
                    tuyenDung: tuyenDung,

                    // Địa chỉ
                    choOHienTai: addressController.text.trim(),
                    tinhTpResponse: tinhTp,
                    quanHuyenResponse: quanHuyenResponse,
                    phuongXaResponse: phuongXaResponse,

                    //
                    chucVuHienTai: chucVuHienTaiIndex!.tieuDe,
                    chucVuMongMuon: chucVuMongMuonIndex!.tieuDe,
                    namKinhNghiem: soNamKinhNghiemIndex!.tieuDe,
                    mucLuongDeXuat: mucLuongDuKienIndex,
                    noiLamViec: noiLamViecListString,
                    nghanhNgheMongMuon: chuyenNganhChinhSelected,
                    idSoNamKinhNghiem: soNamKinhNghiemIndex!.id,
                    idBangBangCap: idBangBangCap,
                    idKeKhaiKinhNghiems: idKeKhaiKinhNghiems,
                    idNgoaiNgu: idNgoaiNgu,
                    idTinHoc: idTinHoc,
                    anhBangCaps: anhBangCaps,
                    anhHoSoXinViecs: anhHoSoXinViecs,
                    idNganhNgheMongMuons: idNganhNgheMongMuonsList,
                    idNoiLamViecs: noiLamViecListString,
                    fileHoSoXinViec: hoSoXinViecsFile,
                    anhBangCapsList: anhBangCapsList,

                    //Tham khảo
                    nguoiThamKhao: nguoiThamKhaoController.text.trim(),
                    chucDanh: chucdanhController.text.trim(),
                    congTy: congTyController.text.trim(),
                    soDienThoai: soDienThoaiController.text.trim(),
                  ),
                  bangBangCapDisplayResponse: bangBangCapDisplayResponse,
                  idTuyenDung: idTuyenDung,
                ),
              )!
                  .then((value) {
                if (value != null && value == true) {
                  Get.back(result: true);
                }
              });
            }

            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
        update();
      });

      EasyLoading.dismiss();
      update();
    }
    EasyLoading.dismiss();
    update();
  }

  ///
  /// validate goto
  ///
  bool validateGoto() {
    if (titleController.text.isEmpty) {
      Alert.error(message: "Tiêu đề đăng ký không được để trống!");
      return false;
    }

    if (tinhTp == null) {
      Alert.error(message: "Vui lòng chọn Tỉnh/Tp!");
      return false;
    }

    if (quanHuyenResponse == null) {
      Alert.error(message: "Vui lòng chọn Quận/Huyện!");
      return false;
    }

    if (phuongXaResponse == null &&
        quanHuyenResponse!.ten.toString().toLowerCase() != "hoàng sa") {
      Alert.error(message: "Vui lòng chọn Phường/Xã!");
      return false;
    }
    if (addressController.text.isEmpty) {
      Alert.error(message: "Chỗ ở hiện tại không được để trống!");
      return false;
    }
    if (honNhanString == null) {
      Alert.error(message: "Hôn nhân không được để trống!");
      return false;
    }

    if (hinhThucLamViecIndex == null) {
      Alert.error(message: "Hình thức làm việc không được để trống!");
      return false;
    }

    if (mucTieuNgheNghiepController.text.isEmpty) {
      Alert.error(message: "Mục tiêu nghề nghiệp không được để trống!");
      return false;
    }

    if (bangBangCapDisplayResponse.isEmpty) {
      Alert.error(message: "Bằng cấp không được để trống!");
      return false;
    }

    if (chucVuHienTaiIndex == null) {
      Alert.error(message: "Chức vụ hiện tại không được để trống!");
      return false;
    }

    if (chucVuMongMuonIndex == null) {
      Alert.error(message: "Chức vụ mong muốn không được để trống!");
      return false;
    }

    if (soNamKinhNghiemIndex == null) {
      Alert.error(message: "Năm kinh nghiệm không được để trống!");
      return false;
    }
    if (mucLuongDuKienIndex == null) {
      Alert.error(message: "Mức lương đề xuất không được để trống!");
      return false;
    }

    if (noiLamViecListString.isEmpty) {
      Alert.error(message: "Vui lòng chọn nơi làm việc không được để trống!");
      return false;
    }

    if (chuyenNganhChinhSelected.isEmpty) {
      Alert.error(
          message: "Vui lòng chọn ngành nghề mong muốn không được để trống!");
      return false;
    }

    if (keKhaiKinhNghiemResponseList.isEmpty) {
      Alert.error(message: "Kê khai kinh nghiệm không được để trống!");
      return false;
    }

    if (kyNangVaSoTruongLamViecController.text.isEmpty) {
      Alert.error(
          message: "Kỹ năng và sở trường làm việc không được để trống!");
      return false;
    }

    if (ngoaiNguResponseList.isEmpty) {
      Alert.error(message: "Ngoại ngữ không được để trống!");
      return false;
    }

    return true;
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToLocalFullDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  ///
  ///Custom Get Back
  ///
  void getBackAndReload() {
    Get.back(result: true);
  }
}

// Kế thừa extension để tạo hàm firstWhereOrNull
extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
