import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/dang_ky_viec_moi_request.dart';
import 'package:template/data/model/request/danh_sach_luu_tin_tuyen_dung_request.dart';
import 'package:template/data/model/request/danh_sach_ung_tuyen_request.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/hon_nhan_model.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/repository/dang_ky_viec_moi_repository.dart';
import 'package:template/data/repository/danh_sach_luu_tin_tuyen_dung_repository.dart';
import 'package:template/data/repository/danh_sach_ung_tuyen_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/danh_sach_luu_tin_tuyen_dung_provider.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart' as app_constants;
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v2-builder/candicate_recruitment/components/cadidate_recruitment_dialog_accept.dart';
import 'package:url_launcher/url_launcher.dart';

class V2CvController extends GetxController {
  //Provider
  final dangKyViecMoiProvider = GetIt.I.get<DangKyViecMoiProvider>();
  final hinhThucLamViecProvider = GetIt.I.get<HinhThucLamViecProvider>();
  final tinhTpProvider = GetIt.I.get<TinhTpProvider>();
  final quanHuyenProvider = GetIt.I.get<QuanHuyenProvider>();
  final phuongXaProvider = GetIt.I.get<PhuongXaProvider>();
  final taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  //Danh sách lưu tin tuyển dụng Provider
  DanhSachLuuTinTuyenDungProvider danhSachLuuTinTuyenDungProvider =
      GetIt.I.get<DanhSachLuuTinTuyenDungProvider>();
  //Danh sách lưu tin tuyển dụng Responsitory
  DanhSachLuuTinTuyenDungRepository danhSachLuuTinTuyenDungRepository =
      DanhSachLuuTinTuyenDungRepository();
  //Request
  DanhSachLuuTinTuyenDungRequest danhSachLuuTinTuyenDungRequest =
      DanhSachLuuTinTuyenDungRequest();

  //Repository
  DangKyViecMoiRepository dangKyViecMoiRepository = DangKyViecMoiRepository();

  //Response
  DangKyViecMoiResponse dangKyViecMoiResponse = DangKyViecMoiResponse();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();

  //request
  DangKyViecMoiRequest dangKyViecMoiRequest = DangKyViecMoiRequest();

  //model value
  List<HinhThucLamViecResponse> hinhThucLamViecListModel = [];
  List<TinhTpResponse> tinhTpListModel = [];
  List<QuanHuyenResponse> quanHuyenListModel = [];
  List<PhuongXaResponse> phuongXaListModel = [];

  //model choose
  HinhThucLamViecResponse? hinhThucLamViec;
  TinhTpResponse? tinhTp;
  QuanHuyenResponse? quanHuyenResponse;
  PhuongXaResponse? phuongXaResponse;

  //value hôn nhân
  List<HonNhanModel> honNhanListModel = [
    HonNhanModel(id: '1', tieuDe: 'Độc thân'),
    HonNhanModel(id: '2', tieuDe: 'Đã lập gia đình'),
    HonNhanModel(id: '3', tieuDe: 'Khác'),
  ];
  HonNhanModel? honNhanModel;

  //DanhSachUngTuyen
  final danhSachUngTuyenProvider = GetIt.I.get<DanhSachUngTuyenProvider>();
  final danhSachUngTuyenRepository = DanhSachUngTuyenRepository();
  DanhSachUngTuyenRequest danhSachUngTuyenRequest = DanhSachUngTuyenRequest();

  // Tiêu đề
  TextEditingController titleController = TextEditingController();
  // địa chỉ
  TextEditingController addressController = TextEditingController();
  // địa chỉ
  TextEditingController mucTieuController = TextEditingController();
  //ten ứng viên
  TextEditingController tenUngVienController = TextEditingController();
  //Giới tính
  TextEditingController gioiTinhVienController = TextEditingController();
  //ngày sinh
  TextEditingController ngaySinhController = TextEditingController();
  //điện thoại
  TextEditingController dienThoaiController = TextEditingController();
  //email
  TextEditingController emailController = TextEditingController();

  //foscusNode
  final titleFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final mucTieuFocusNode = FocusNode();

  //ImageUpdateProvider
  final imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();

  //idTuyenDung
  String? idTuyenDung;

  //userId
  String? userId;

  //isLoading
  bool isLoading = true;

  //tên File
  String? tenFile;

  //isCheckUserDb
  bool isCheckUserDb = false;

  String idDangKyViecMoi = "";
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idTuyenDung = Get.parameters['idTuyenDung'];
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
      getDataInfomationUser();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    titleController.dispose();
    addressController.dispose();
    mucTieuController.dispose();
    tenUngVienController.dispose();
    gioiTinhVienController.dispose();
    ngaySinhController.dispose();
    dienThoaiController.dispose();
    emailController.dispose();
    titleFocusNode.dispose();
    addressFocusNode.dispose();
    mucTieuFocusNode.dispose();
    super.onClose();
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

      print('Count files select ${files.length}');
      // load files
      imageUpdateProvider.addFiles(
        files: files,
        onSuccess: (value) {
          print('V2QuotationG1Controller pickFiles addFiles ${value.files}');
          EasyLoading.dismiss();
          if (value.files != null && value.files!.isNotEmpty) {
            dangKyViecMoiResponse.fileHoSoXinViec = value.files![0];
            //set tên file
            tenFile = value.files![0].split('/').last;
          }
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          IZIAlert.error(message: e.toString());
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIAlert.error(message: e.toString());
    }
  }

  ///
  ///getDataUserViecMoi
  ///
  void getDataUserViecMoi() {
    dangKyViecMoiProvider.paginate(
        page: 1,
        limit: 1,
        filter: '&idTaiKhoan=$userId',
        onSuccess: (value) {
          if (value.isNotEmpty) {
            dangKyViecMoiResponse = value.first;
            idDangKyViecMoi = dangKyViecMoiResponse.id.toString();
            isCheckUserDb = true;

            //set địa chỉ
            if (dangKyViecMoiResponse.diaChi != null &&
                dangKyViecMoiResponse.diaChi.toString() != "null") {
              addressController.text = dangKyViecMoiResponse.diaChi.toString();
            } else {
              addressController.text = taiKhoanResponse.diaChi!;
            }

            //set tiêu đề
            if (dangKyViecMoiResponse.tieuDe != null &&
                dangKyViecMoiResponse.tieuDe.toString() != "null") {
              titleController.text = dangKyViecMoiResponse.tieuDe.toString();
            }

            //set mục tiêu
            if (dangKyViecMoiResponse.mucTieuNgheNghiep != null &&
                dangKyViecMoiResponse.mucTieuNgheNghiep.toString() != "null") {
              mucTieuController.text =
                  dangKyViecMoiResponse.mucTieuNgheNghiep.toString();
            }

            //set hôn nhân
            if (dangKyViecMoiResponse.honNhan != null &&
                dangKyViecMoiResponse.honNhan.toString() != "null") {
              honNhanModel = honNhanListModel.firstWhere((element) =>
                  element.id == dangKyViecMoiResponse.honNhan.toString());
            }

            //set tên file
            if (dangKyViecMoiResponse.fileHoSoXinViec != null &&
                dangKyViecMoiResponse.fileHoSoXinViec.toString() != "null") {
              tenFile = dangKyViecMoiResponse.fileHoSoXinViec!.split('/').last;
            }

            //tên ứng viên
            if (dangKyViecMoiResponse.tenUngVien != null &&
                dangKyViecMoiResponse.tenUngVien.toString() != "null") {
              tenUngVienController.text = dangKyViecMoiResponse.tenUngVien!;
            } else {
              tenUngVienController.text = taiKhoanResponse.hoTen!;
            }

            //giới tính
            if (dangKyViecMoiResponse.gioiTinh != null &&
                dangKyViecMoiResponse.gioiTinh.toString() != "null") {
              gioiTinhVienController.text = dangKyViecMoiResponse.gioiTinh!;
            } else {
              gioiTinhVienController.text = taiKhoanResponse.gioiTinh!;
            }

            //ngày sinh
            if (dangKyViecMoiResponse.ngaySinh != null &&
                dangKyViecMoiResponse.ngaySinh.toString() != "null") {
              ngaySinhController.text = dangKyViecMoiResponse.ngaySinh!;
            } else {
              ngaySinhController.text = taiKhoanResponse.ngaySinh!;
            }

            //điện thoại
            if (dangKyViecMoiResponse.idTaiKhoan!.soDienThoai != null &&
                dangKyViecMoiResponse.idTaiKhoan!.soDienThoai.toString() !=
                    "null") {
              dienThoaiController.text =
                  dangKyViecMoiResponse.idTaiKhoan!.soDienThoai!;
            } else {
              dienThoaiController.text = taiKhoanResponse.soDienThoai!;
            }

            //email
            if (dangKyViecMoiResponse.idTaiKhoan!.email!.toString() != "null") {
              emailController.text = dangKyViecMoiResponse.idTaiKhoan!.email!;
            } else {
              emailController.text = taiKhoanResponse.email!;
            }

            getDataHinhThucLamViec();
          } else {
            isCheckUserDb = false;

            //set địa chỉ
            if (taiKhoanResponse.diaChi != null &&
                taiKhoanResponse.diaChi.toString() != "null") {
              addressController.text = taiKhoanResponse.diaChi.toString();
            }

            //tên ứng viên
            if (taiKhoanResponse.hoTen != null &&
                taiKhoanResponse.hoTen.toString() != "null") {
              tenUngVienController.text = taiKhoanResponse.hoTen!;
            }

            //giới tính
            if (taiKhoanResponse.gioiTinh != null &&
                taiKhoanResponse.gioiTinh.toString() != "null") {
              gioiTinhVienController.text = taiKhoanResponse.gioiTinh!;
            }

            //ngày sinh
            if (taiKhoanResponse.ngaySinh != null &&
                taiKhoanResponse.ngaySinh.toString() != "null") {
              ngaySinhController.text = taiKhoanResponse.ngaySinh!;
            }

            //điện thoại
            if (taiKhoanResponse.soDienThoai != null &&
                taiKhoanResponse.soDienThoai.toString() != "null") {
              dienThoaiController.text = taiKhoanResponse.soDienThoai!;
            }

            //email
            if (taiKhoanResponse.email!.toString() != "null") {
              emailController.text = taiKhoanResponse.email!;
            }

            getDataHinhThucLamViec();
          }
          update();
        },
        onError: (error) => print('V2CvController getDataUserViecMoi $error'));
  }

  ///
  ///getDataInfomationUser
  ///
  void getDataInfomationUser() {
    taiKhoanProvider.find(
        id: userId!,
        onSuccess: (value) {
          taiKhoanResponse = value;
          getDataUserViecMoi();

          update();
        },
        onError: (error) =>
            print('V2CvController getDataInfomationUser $error '));
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

          //set hình thức việc làm
          if (dangKyViecMoiResponse != null) {
            if (dangKyViecMoiResponse.idHinhThucLamViec != null) {
              hinhThucLamViec = hinhThucLamViecListModel.firstWhere((element) =>
                  element.id ==
                  dangKyViecMoiResponse.idHinhThucLamViec!.id.toString());
            }
          }

          // isLoading = false;
          getDataTinhTp(isLoadFrist: true);
          update();
        },
        onError: (error) =>
            print('V2CvController getDataHinhThucLamViec $error'));
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
          // isLoading = false;

          if (isLoadFrist) {
            if (dangKyViecMoiResponse.idTinhTp != null) {
              //set idTinh
              tinhTp = value.firstWhere((element) => element.ten!
                  .contains(dangKyViecMoiResponse.idTinhTp.toString()));

              getDataQuanHuyen(
                  idTinh: tinhTp!.id.toString(), isLoadFrist: true);
            } else {
              //set idTinh

              tinhTp = value.firstWhereOrNull((element) => element.ten!
                  .contains(taiKhoanResponse.idTinhTp!.ten.toString()));

              getDataQuanHuyen(
                  idTinh: tinhTp!.id.toString(), isLoadFrist: true);
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
              if (dangKyViecMoiResponse.idQuanHuyen != null) {
                quanHuyenResponse = quanHuyenListModel.firstWhere((element) =>
                    element.ten!.contains(
                        dangKyViecMoiResponse.idQuanHuyen.toString()));
              } else {
                quanHuyenResponse = quanHuyenListModel.firstWhere((element) =>
                    element.ten!
                        .contains(taiKhoanResponse.idQuanHuyen.toString()));
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
              if (dangKyViecMoiResponse.idPhuongXa != null) {
                phuongXaResponse = phuongXaListModel.firstWhere((element) =>
                    element.ten!
                        .contains(dangKyViecMoiResponse.idPhuongXa.toString()));
              } else {
                phuongXaResponse = phuongXaListModel.firstWhere((element) =>
                    element.ten!
                        .contains(taiKhoanResponse.idPhuongXa.toString()));
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
  ///chọn hình thức làm việc
  ///
  void onChangeHinhThucLamViec(HinhThucLamViecResponse item) {
    hinhThucLamViec = item;
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
  ///Thay đổi hôn nhân
  ///
  void onChangedHonNhan(HonNhanModel honnhan) {
    honNhanModel = honnhan;
    update();
  }

  ///
  /// Xem trươc
  ///
  void onClickPreviewButton() {
    Get.toNamed(AppRoutes.V2_PREVIEW);
  }

  ///
  ///onBtnDownCv
  ///
  Future<void> onBtnDownloadCv({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///
  /// validate ke khai
  ///
  bool validate() {
    if (titleController.text.isEmpty) {
      IZIAlert.error(message: 'Vui lòng nhập tiêu đề');
      return false;
    }

    if (tinhTp == null) {
      IZIAlert.error(message: 'Vui lòng chọn tỉnh thành phố');
      return false;
    }

    if (quanHuyenResponse == null) {
      IZIAlert.error(message: 'Vui lòng chọn quận huyện');
      return false;
    }

    if (phuongXaResponse == null) {
      IZIAlert.error(message: 'Vui lòng chọn phường xã');
      return false;
    }

    if (addressController.text.isEmpty) {
      IZIAlert.error(message: 'Vui lòng nhập địa chỉ');
      return false;
    }

    if (hinhThucLamViec == null) {
      IZIAlert.error(message: 'Vui lòng chọn hình thức việc làm');
      return false;
    }

    if (mucTieuController.text.isEmpty) {
      IZIAlert.error(message: 'Vui lòng nhập mục tiêu nghề nghiệp');
      return false;
    }

    if (dangKyViecMoiResponse.fileHoSoXinViec.toString() == 'null') {
      IZIAlert.error(message: 'Vui lòng tải file hồ sơ xin việc');
      return false;
    }

    return true;
  }

  ///
  ///Nộp hồ sơ
  ///
  void nopHoSO() {
    Get.defaultDialog(
      title: "Xác nhận thông tin",
      content: CandidateRecruitmentDialogAccept(
        textContent: 'Bạn chắc chắn đồng ý nộp hồ sơ ứng tuyển',
      ),
      confirm: ElevatedButton(
        onPressed: () {
          onBtnSummit();
          Get.back(result: true);
        },
        child: const Text("Đồng ý"),
      ),
      cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ColorResources.GREY,
        ),
        onPressed: () {
          Get.back();
        },
        child: const Text("Hủy"),
      ),
    );
  }

  ///
  ///onBtnSummitFix
  ///
  void onBtnSummit() {
    if (validate()) {
      if (isCheckUserDb == true) {
        dangKyViecMoiProvider.update(
            data: DangKyViecMoiRequest(
              tieuDe: titleController.text.trim(),
              id: idDangKyViecMoi.toString(),
              idTinhTp: tinhTp!.id,
              idQuanHuyen: quanHuyenResponse!.id,
              idPhuongXa: phuongXaResponse!.id,
              diaChi: addressController.text.trim(),
              honNhan: honNhanModel!.id,
              idHinhThucLamViec: hinhThucLamViec!.id,
              mucTieuNgheNghiep: mucTieuController.text.trim(),
              fileHoSoXinViec: tenFile,
            ),
            onSuccess: (values) {
              danhSachUngTuyenProvider.add(
                  data: DanhSachUngTuyenRequest(
                    idDangKyViecMoi: values.id.toString(),
                    idTaiKhoanUngTuyen: userId,
                    idTuyenDung: idTuyenDung,
                    daXem: "0",
                  ),
                  onSuccess: (model) {
                    danhSachLuuTinTuyenDungProvider.add(
                        data: DanhSachLuuTinTuyenDungRequest(
                          idTaiKhoan: userId,
                          idTuyenDung: model.idTuyenDung,
                        ),
                        onSuccess: (models) {
                          IZIAlert.success(
                              message: 'Bạn đã nộp hồ sơ thành công!');
                          Get.back(result: true);
                          update();
                        },
                        onError: (error) {
                          print(
                              "TermsAndPolicyController getTermsAndPolicy onError $error");
                        });
                    update();
                  },
                  onError: (error) {
                    print(
                        "TermsAndPolicyController getTermsAndPolicy onError $error");
                  });
              update();
            },
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            });
      } else {
        dangKyViecMoiProvider.add(
            data: DangKyViecMoiRequest(
              tieuDe: titleController.text.trim(),
              gioiTinh: gioiTinhVienController.text,
              ngaySinh: ngaySinhController.text,
              email: emailController.text,
              tenUngVien: tenUngVienController.text,
              idTinhTp: tinhTp!.id,
              idQuanHuyen: quanHuyenResponse!.id,
              idPhuongXa: phuongXaResponse!.id,
              diaChi: addressController.text.trim(),
              honNhan: honNhanModel!.id,
              idHinhThucLamViec: hinhThucLamViec!.id,
              mucTieuNgheNghiep: mucTieuController.text.trim(),
              fileHoSoXinViec: tenFile,
              idTaiKhoan: userId,
              idNhomDichVu: app_constants.NHOM_DICH_VU_7,
            ),
            onSuccess: (values) {
              danhSachUngTuyenProvider.add(
                  data: DanhSachUngTuyenRequest(
                    idDangKyViecMoi: values.id.toString(),
                    idTaiKhoanUngTuyen: userId,
                    idTuyenDung: idTuyenDung,
                    daXem: "0",
                  ),
                  onSuccess: (model) {
                    danhSachLuuTinTuyenDungProvider.add(
                        data: DanhSachLuuTinTuyenDungRequest(
                          idTaiKhoan: userId,
                          idTuyenDung: model.idTuyenDung,
                        ),
                        onSuccess: (models) {
                          IZIAlert.success(
                              message: 'Bạn đã nộp hồ sơ thành công!');
                          Get.back(result: true);
                          update();
                        },
                        onError: (error) {
                          print(
                              "TermsAndPolicyController getTermsAndPolicy onError $error");
                        });
                    update();
                  },
                  onError: (error) {
                    print(
                        "TermsAndPolicyController getTermsAndPolicy onError $error");
                  });
              update();
            },
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            });
      }
    }
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
