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
import 'package:template/data/model/response/tinh_tp_response.dart';
import 'package:template/data/repository/dang_ky_viec_moi_repository.dart';
import 'package:template/data/repository/danh_sach_ung_tuyen_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/provider/hinh_thuc_lam_viec_provider.dart';
import 'package:template/provider/phuong_xa_provider.dart';
import 'package:template/provider/quan_huyen_provider.dart';
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

  //Repository
  DangKyViecMoiRepository dangKyViecMoiRepository = DangKyViecMoiRepository();

  //Response
  DangKyViecMoiResponse dangKyViecMoiResponse = DangKyViecMoiResponse();

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
    super.onClose();
  }

  ///
  ///pick pickFile
  ///
  Future pickFile() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      final PlatformFile file = result.files.first;
      EasyLoading.show(status: 'loading...');
      if (file.size > 50240000) {
        EasyLoading.dismiss();
        Alert.error(
            message:
                'Dung lượng file không quá 50 MB, vui lòng chọn file khác');
      } else {
        // load file
        imageUpdateProvider.addFile(
            file: file,
            onSuccess: (value) {
              EasyLoading.dismiss();
              dangKyViecMoiResponse.fileHoSoXinViec = value.data;

              //set tên file
              tenFile = value.data!.split('/').last;

              update();
            },
            onError: (e) {
              EasyLoading.dismiss();
              Alert.error(message: 'Vui lòng chọn lại file');
            });
      }
      update();
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
    }
  }

  ///
  ///getDataUserViecMoi
  ///
  void getDataUserViecMoi() {
    dangKyViecMoiProvider.paginate(
        page: 1,
        limit: 1,
        filter: '&idTaiKhoan=$userId&idNhomDichVu=${app_constants.NHOM_DICH_VU_7}',
        onSuccess: (value) {
          dangKyViecMoiResponse = value.first;

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
          getDataHinhThucLamViec();
          update();
        },
        onError: (error) => print('V2CvController getDataUserViecMoi $error'));
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
          hinhThucLamViec = hinhThucLamViecListModel.firstWhere((element) =>
              element.id ==
              dangKyViecMoiResponse.idHinhThucLamViec!.id.toString());
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
            //set idTinh
            tinhTp = value.firstWhere((element) => element.ten!
                .contains(dangKyViecMoiResponse.idTinhTp.toString()));

            getDataQuanHuyen(idTinh: tinhTp!.id.toString(), isLoadFrist: true);
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
              quanHuyenResponse = quanHuyenListModel.firstWhere((element) =>
                  element.ten!
                      .contains(dangKyViecMoiResponse.idQuanHuyen.toString()));
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
              phuongXaResponse = phuongXaListModel.firstWhere((element) =>
                  element.ten!
                      .contains(dangKyViecMoiResponse.idPhuongXa.toString()));
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
    } else {
      //set data request
      dangKyViecMoiRequest.id = dangKyViecMoiResponse.id;
      dangKyViecMoiRequest.tieuDe = titleController.text.trim();
      dangKyViecMoiRequest.idTinhTp = tinhTp!.id;
      dangKyViecMoiRequest.idQuanHuyen = quanHuyenResponse!.id;
      dangKyViecMoiRequest.idPhuongXa = phuongXaResponse!.id;
      dangKyViecMoiRequest.diaChi = addressController.text.trim();
      dangKyViecMoiRequest.honNhan = honNhanModel.id;
      dangKyViecMoiRequest.idHinhThucLamViec = hinhThucLamViec!.id;
      dangKyViecMoiRequest.mucTieuNgheNghiep = mucTieuController.text.trim();
      dangKyViecMoiRequest.fileHoSoXinViec =
          dangKyViecMoiResponse.fileHoSoXinViec;

      if (number == 1) {
        EasyLoading.show(status: 'loading...');
        // update thông tin
        dangKyViecMoiRepository.update(dangKyViecMoiRequest).then((value) => {
              if (value.response.data != null)
                {
                  EasyLoading.dismiss(),
                  //chuyển qua trang review
                  Get.toNamed(
                          '${AppRoutes.V2_PREVIEW}?idTuyenDung=$idTuyenDung')!
                      .then((value) => {
                            if (value != null && value == true)
                              {Get.back(result: true)}
                          }),
                }
              else
                {
                  EasyLoading.dismiss(),
                  Alert.error(message: 'Vui lòng thử lại')
                }
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
                                //check xem có lưu chưa
                                danhSachUngTuyenProvider.paginate(
                                    page: 1,
                                    limit: 5,
                                    filter:
                                        '&idTuyenDung=$idTuyenDung&idTaiKhoanUngTuyen=$userId',
                                    onSuccess: (value) {
                                      if (value.isEmpty) {
                                        //set data
                                        danhSachUngTuyenRequest.idTuyenDung =
                                            idTuyenDung;
                                        danhSachUngTuyenRequest
                                            .idTaiKhoanUngTuyen = userId;
                                        danhSachUngTuyenRequest.daXem = '0';
                                        //insert db
                                        danhSachUngTuyenRepository
                                            .add(danhSachUngTuyenRequest)
                                            .then((value) => {
                                                  if (value.response.data !=
                                                      null)
                                                    {
                                                      EasyLoading.dismiss(),
                                                      Alert.success(
                                                          message:
                                                              'Nộp hồ sơ ứng tuyển thành công'),
                                                      Get.back(),
                                                      Get.back(result: true)
                                                    }
                                                  else
                                                    {
                                                      EasyLoading.dismiss(),
                                                      Alert.error(
                                                          message:
                                                              'Vui lòng thử lại')
                                                    }
                                                });
                                      } else {
                                        EasyLoading.dismiss();
                                        Get.back();
                                        Alert.info(
                                            message:
                                                'Bạn đã ứng tuyển tin tuyển dụng này rồi');
                                      }
                                    },
                                    onError: (error) => print(
                                        'V2CvController onBtnSummit $error')),
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
}
