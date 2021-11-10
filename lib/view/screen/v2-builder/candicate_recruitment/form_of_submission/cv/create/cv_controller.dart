import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/dang_ky_viec_moi_request.dart';
import 'package:template/data/model/request/danh_sach_ung_tuyen_request.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/hinh_thuc_lam_viec_response.dart';
import 'package:template/data/model/response/hon_nhan_model.dart';
import 'package:template/data/model/response/phuong_xa_response.dart';
import 'package:template/data/model/response/quan_huyen_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/repository/dang_ky_viec_moi_repository.dart';
import 'package:template/data/repository/danh_sach_ung_tuyen_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/tinh_tp_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
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
  HonNhanModel honNhanModel = HonNhanModel();

  //DanhSachUngTuyen
  final danhSachUngTuyenProvider = GetIt.I.get<DanhSachUngTuyenProvider>();
  final danhSachUngTuyenRepository = DanhSachUngTuyenRepository();
  DanhSachUngTuyenRequest danhSachUngTuyenRequest = DanhSachUngTuyenRequest();

  // Tiêu đề
  final titleController = TextEditingController();
  // địa chỉ
  final addressController = TextEditingController();
  // địa chỉ
  final mucTieuController = TextEditingController();
  //ten ứng viên
  final tenUngVienController = TextEditingController();
  //Giới tính
  final gioiTinhVienController = TextEditingController();
  //ngày sinh
  final ngaySinhController = TextEditingController();
  //điện thoại
  final dienThoaiController = TextEditingController();
  //email
  final emailController = TextEditingController();

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idTuyenDung = Get.parameters['idTuyenDung'];
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      userId = value;
      getDataUserViecMoi();
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
  ///getDataUserViecMoi
  ///
  void getDataUserViecMoi() {
    dangKyViecMoiProvider.paginate(
        page: 1,
        limit: 1,
        filter:
            '&idTaiKhoan=$userId&idNhomDichVu=${app_constants.NHOM_DICH_VU_7}',
        onSuccess: (value) {
          if (value.isNotEmpty) {
            dangKyViecMoiResponse = value.first;

            //isCheckUserDb
            isCheckUserDb = true;

            //set địa chỉ
            addressController.text = dangKyViecMoiResponse.diaChi.toString();
            //set tiêu đề
            titleController.text = dangKyViecMoiResponse.tieuDe.toString();
            //set mục tiêu
            mucTieuController.text =
                dangKyViecMoiResponse.mucTieuNgheNghiep.toString();

            //set hôn nhân
            honNhanModel = honNhanListModel.firstWhere((element) =>
                element.id == dangKyViecMoiResponse.honNhan.toString());

            //set tên file
            tenFile = dangKyViecMoiResponse.fileHoSoXinViec!.split('/').last;
            //tên ứng viên
            tenUngVienController.text = dangKyViecMoiResponse.tenUngVien!;
            //giới tính
            gioiTinhVienController.text = dangKyViecMoiResponse.gioiTinh!;
            //ngày sinh
            ngaySinhController.text = dangKyViecMoiResponse.ngaySinh!;
            //điện thoại
            dienThoaiController.text =
                dangKyViecMoiResponse.idTaiKhoan!.soDienThoai!;
            //email
            emailController.text = dangKyViecMoiResponse.idTaiKhoan!.email!;

            getDataHinhThucLamViec();
          } else {
            //isCheckUserDb
            isCheckUserDb = false;
            getDataInfomationUser();
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
          //tên ứng viên
          tenUngVienController.text = value.hoTen!;
          //giới tính
          gioiTinhVienController.text = value.gioiTinh!;
          //ngày sinh
          ngaySinhController.text = value.ngaySinh!;
          //điện thoại
          dienThoaiController.text = value.soDienThoai!;
          //email
          emailController.text = value.email!;
          //địa chỉ
          addressController.text = value.diaChi!;

          //hôn nhân
          honNhanModel = honNhanListModel.first;

          //hình thức việc làm
          getDataHinhThucLamViec();
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
          if (dangKyViecMoiResponse.idHinhThucLamViec != null) {
            hinhThucLamViec = hinhThucLamViecListModel.firstWhere((element) =>
                element.id ==
                dangKyViecMoiResponse.idHinhThucLamViec!.id.toString());
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
              tinhTp = value.firstWhere((element) =>
                  element.ten!.contains(taiKhoanResponse.idTinhTp.toString()));

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
  ///onBtnSummit
  ///
  void onBtnSummit({required int number}) {
    //check validate
    if (titleController.text.isEmpty) {
      Alert.error(message: 'Vui lòng nhập tiêu đề');
    } else if (tinhTp == null) {
      Alert.error(message: 'Vui lòng chọn tỉnh thành phố');
    } else if (quanHuyenResponse == null) {
      Alert.error(message: 'Vui lòng chọn quận huyện');
    } else if (phuongXaResponse == null) {
      Alert.error(message: 'Vui lòng chọn phường xã');
    } else if (addressController.text.isEmpty) {
      Alert.error(message: 'Vui lòng nhập địa chỉ');
    } else if (hinhThucLamViec == null) {
      Alert.error(message: 'Vui lòng chọn hình thức việc làm');
    } else if (mucTieuController.text.isEmpty) {
      Alert.error(message: 'Vui lòng nhập mục tiêu nghề nghiệp');
    } else if (dangKyViecMoiResponse.fileHoSoXinViec.toString() == 'null') {
      Alert.error(message: 'Vui lòng tải file hồ sơ xin việc');
    } else {
      EasyLoading.show(status: 'loading...');
      //check xem có lưu chưa
      danhSachUngTuyenProvider.paginate(
          page: 1,
          limit: 5,
          filter: '&idTuyenDung=$idTuyenDung&idTaiKhoanUngTuyen=$userId',
          onSuccess: (value) {
            if (value.isEmpty) {
              //set data
              danhSachUngTuyenRequest.idTuyenDung = idTuyenDung;
              danhSachUngTuyenRequest.idTaiKhoanUngTuyen = userId;
              danhSachUngTuyenRequest.daXem = '0';

              //set data request
              dangKyViecMoiRequest.tieuDe = titleController.text.trim();
              dangKyViecMoiRequest.tenUngVien = tenUngVienController.text;
              dangKyViecMoiRequest.gioiTinh = gioiTinhVienController.text;
              dangKyViecMoiRequest.ngaySinh = ngaySinhController.text;
              dangKyViecMoiRequest.email = emailController.text;
              dangKyViecMoiRequest.idTinhTp = tinhTp!.id;
              dangKyViecMoiRequest.idQuanHuyen = quanHuyenResponse!.id;
              dangKyViecMoiRequest.idPhuongXa = phuongXaResponse!.id;
              dangKyViecMoiRequest.diaChi = addressController.text.trim();
              dangKyViecMoiRequest.honNhan = honNhanModel.id;
              dangKyViecMoiRequest.idHinhThucLamViec = hinhThucLamViec!.id;
              dangKyViecMoiRequest.mucTieuNgheNghiep =
                  mucTieuController.text.trim();
              dangKyViecMoiRequest.fileHoSoXinViec =
                  dangKyViecMoiResponse.fileHoSoXinViec;
              dangKyViecMoiRequest.idNhomDichVu = app_constants.NHOM_DICH_VU_7;
              dangKyViecMoiRequest.idTaiKhoan = userId;

              if (number != 1) {
                //insert db
                danhSachUngTuyenRepository
                    .add(danhSachUngTuyenRequest)
                    .then((value) {
                  if (value.response.data != null) {
                    //check insert db
                    if (!isCheckUserDb) {
                      dangKyViecMoiRepository
                          .add(dangKyViecMoiRequest)
                          .then((value) {
                        if (value.response.data != null) {
                          EasyLoading.dismiss();
                          dangKyViecMoiRequest.id =
                              value.response.data['id'].toString();
                          //on next Page
                          btnNextPage(number: number);
                        } else {
                          EasyLoading.dismiss();
                          Alert.error(message: 'Vui lòng thực hiện lại');
                        }
                      });
                    } else {
                      dangKyViecMoiRequest.id = dangKyViecMoiResponse.id;
                      EasyLoading.dismiss();
                      //on next Page
                      btnNextPage(number: number);
                    }
                  } else {
                    EasyLoading.dismiss();
                    Alert.error(message: 'Vui lòng thử lại');
                  }
                });
              } else {
                if (!isCheckUserDb) {
                  dangKyViecMoiRepository
                      .add(dangKyViecMoiRequest)
                      .then((value) {
                    if (value.response.data != null) {
                      EasyLoading.dismiss();
                      dangKyViecMoiRequest.id =
                          value.response.data['id'].toString();
                      //on next Page
                      btnNextPage(number: 1);
                    } else {
                      EasyLoading.dismiss();
                      Alert.error(message: 'Vui lòng thực hiện lại');
                    }
                  });
                } else {
                  dangKyViecMoiRequest.id = dangKyViecMoiResponse.id;
                  EasyLoading.dismiss();
                  //on next Page
                  btnNextPage(number: 1);
                }
              }
            } else {
              EasyLoading.dismiss();
              Alert.info(message: 'Bạn đã ứng tuyển tin tuyển dụng này rồi');
            }
          },
          onError: (error) => print('V2CvController onBtnSummit $error'));
    }
  }

  ///
  ///btnNextPage
  ///
  void btnNextPage({required int number}) {
    //xem trước
    if (number == 1) {
      // update thông tin
      dangKyViecMoiRepository.update(dangKyViecMoiRequest).then((value) => {
            if (value.response.data != null)
              {
                EasyLoading.dismiss(),
                //chuyển qua trang review
                Get.toNamed('${AppRoutes.V2_PREVIEW}?idTuyenDung=$idTuyenDung')!
                    .then((value) => {
                          if (value != null && value == true)
                            {Get.back(result: true)}
                        }),
              }
            else
              {EasyLoading.dismiss(), Alert.error(message: 'Vui lòng thử lại')}
          });
    } else {
      //show dialog
      Get.defaultDialog(
          title: "Xác nhận thông tin",
          content: CandidateRecruitmentDialogAccept(
            textContent: 'Bạn chắc chắn đồng ý nộp hồ sơ ứng tuyển',
          ),
          confirm: ElevatedButton(
              onPressed: () {
                EasyLoading.show(status: 'loading...');

                // update thông tin
                dangKyViecMoiRepository
                    .update(dangKyViecMoiRequest)
                    .then((value) => {
                          if (value.response.data != null)
                            {
                              EasyLoading.dismiss(),
                              Alert.success(
                                  message: 'Nộp hồ sơ ứng tuyển thành công'),
                              Get.back(),
                              Get.back(result: true)
                            }
                          else
                            {
                              EasyLoading.dismiss(),
                              Alert.error(message: 'Vui lòng thử lại')
                            }
                        });
              },
              child: const Text("Đồng ý")),
          cancel: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorResources.GREY,
              ),
              onPressed: () {
                Get.back();
              },
              child: const Text("Hủy")));
    }
  }
}
