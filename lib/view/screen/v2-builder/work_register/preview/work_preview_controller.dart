import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/dang_ky_viec_moi_model.dart';
import 'package:template/data/model/request/bang_bang_cap_request.dart';
import 'package:template/data/model/request/dang_ky_viec_moi_request.dart';
import 'package:template/data/model/request/danh_sach_ung_tuyen_request.dart';
import 'package:template/data/model/request/dia_diem_dang_ky_lam_viec_request.dart';
import 'package:template/data/model/response/dang_ky_viec_moi_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/data/repository/dang_ky_viec_moi_repository.dart';
import 'package:template/data/repository/danh_sach_ung_tuyen_repository.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/dang_ky_viec_moi_provider.dart';
import 'package:template/provider/danh_sach_ung_tuyen_provider.dart';
import 'package:template/provider/dia_diem_dang_ky_lam_viec_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart' as constant;

class V2WorkPreviewController extends GetxController {
  // Tài khoản Provider
  final TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();

  //Tài khoản Response
  TaiKhoanResponse? taiKhoanResponse;

  //Đăng kí việc mới Request
  DangKyViecMoiRequest dangKyViecMoiRequest = DangKyViecMoiRequest();

  //Image Update Provider
  final ImageUpdateProvider imageUpdateProvider =
      GetIt.I.get<ImageUpdateProvider>();

  //Đăng ký việc mới Responsitory
  DangKyViecMoiRepository dangKyViecMoiRepository = DangKyViecMoiRepository();

  //Danh sách ứng tuyển Responsitory
  DanhSachUngTuyenRepository danhSachUngTuyenRepository =
      DanhSachUngTuyenRepository();

  //Danh sách ứng tuyển Provider
  DanhSachUngTuyenProvider danhSachUngTuyenProvider =
      GetIt.I.get<DanhSachUngTuyenProvider>();

  //Danh sách ứng tuyển Request
  DanhSachUngTuyenRequest danhSachUngTuyenRequest = DanhSachUngTuyenRequest();

  //Đăng kí việc mới Provider
  DangKyViecMoiProvider dangKyViecMoiProvider =
      GetIt.I.get<DangKyViecMoiProvider>();
  BangBangCapRequest bangCapRequest = BangBangCapRequest();

  DiaDiemDangKyLamViecProvider diaDiemDangKyLamViecProvider =
      GetIt.I.get<DiaDiemDangKyLamViecProvider>();

  //Khai báo isLoading
  bool isLoading = true;

  //Khai báo IdUser
  String idUser = "";

  //Khai báo ID Đăng ký việc mới
  String idDangKyViecMoi = "";

  //Khai báo Giới tính
  String gioiTinhRequest = "";

  List<String> idDiaDiemDangKylamViecPush = [];

  // string id tương ứng khi checkbox
  String hoChiMinhId = constant.HO_CHI_MINH;
  String haNoiid = constant.HA_NOI;
  String daNangId = constant.DA_NANG;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadInit();
  }

  ///
  ///Load Init
  ///
  void loadInit() {
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      idUser = id!;
      taiKhoanProvider.find(
          id: idUser,
          onSuccess: (value) {
            taiKhoanResponse = value;
            isLoading = false;
            dangKyViecMoiProvider.paginate(
              page: 1,
              limit: 1,
              filter: "&idTaiKhoan=$id",
              onSuccess: (models) {
                if (models.isNotEmpty) {
                  idDangKyViecMoi = models.first.id.toString();
                } else {}

                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          });
    });
  }

  ///
  /// Custom Get back to delelte List IdNganhNgheMongMuon
  ///
  void backToCreatePage() {
    Get.back();
  }

  String honNhanConvert = "1";

  ///
  /// go to done page
  ///
  Future<void> toDonePage(
    DangKyViecMoiModel dangKiModel,
  ) async {
    EasyLoading.show(status: "Loading...");
    String? idPhuongXa;
    //check Phường Xã Null
    if (dangKiModel.phuongXaResponse != null) {
      idPhuongXa = dangKiModel.phuongXaResponse!.id.toString();
    } else {
      idPhuongXa = null;
    }

    if (dangKiModel.honNhan!.toLowerCase() == "độc thân") {
      honNhanConvert = "1";
    } else if (dangKiModel.honNhan!.toLowerCase() == "đã lập gia đình") {
      honNhanConvert = "2";
    } else if (dangKiModel.honNhan!.toLowerCase() == "khác") {
      honNhanConvert = "3";
    }

    sl.get<SharedPreferenceHelper>().userId.then((userId) async {
      if (dangKiModel.isFirstRegister7Group == false) {
        final dangKyViecMoiRequestAdd = DangKyViecMoiRequest(
          idTaiKhoan: userId,
          tieuDe: dangKiModel.tieuDe,
          diaChi: dangKiModel.choOHienTai,
          honNhan: honNhanConvert,
          mucTieuNgheNghiep: dangKiModel.mucTieuNgheNghiep,
          anhHoSoXinViecs: dangKiModel.anhHoSoXinViecs,
          idKeKhaiKinhNghiem: dangKiModel.idKeKhaiKinhNghiems,
          idBangBangCap: dangKiModel.idBangBangCap,
          chucVuHienTai: dangKiModel.chucVuHienTai,
          chucVuMongMuon: dangKiModel.chucVuMongMuon,
          idSoNamKinhNghiem: dangKiModel.idSoNamKinhNghiem,
          noiLamViec: dangKiModel.idNoiLamViecs,
          email: dangKiModel.email,
          gioiTinh: dangKiModel.gioiTinh,
          idHinhThucLamViec: dangKiModel.hinhThucLamViec,
          kyNangSoTruong: dangKiModel.kyNangSoTruong,
          fileHoSoXinViec: dangKiModel.fileHoSoXinViec,
          idNganhNgheMongMuons: dangKiModel.idNganhNgheMongMuons,

          // Ngoại ngữ và tin học
          idNgoaiNgu: dangKiModel.idNgoaiNgu,
          idTinHoc: dangKiModel.idTinHoc,

          // Sở thích và kỹ năng
          phanMemHoTro: dangKiModel.phanMemHoTro,
          soThichKyNang: dangKiModel.soThichTheHienKyNang,
          soThichTrinhDo: dangKiModel.soThichTheHienTinhCach,
          soTichTinhCach: dangKiModel.soThichTheHienTrinhDo,
          idMucLuongDuKien: dangKiModel.mucLuongDeXuat!.id,

          // Tỉnh thành phố, quận huyện, phường xã
          idTinhTp: dangKiModel.tinhTpResponse!.id.toString(),
          idQuanHuyen: dangKiModel.quanHuyenResponse!.id.toString(),
          idPhuongXa: idPhuongXa,

          //Tham khảo
          nguoiThamKhao: dangKiModel.nguoiThamKhao,
          chucDanh: dangKiModel.chucDanh,
          congTy: dangKiModel.congTy,
          soDienThoai: dangKiModel.soDienThoai,

          //
          idNhomDichVu: dangKiModel.idNhomDichVu,
          idLoaiCongViec: dangKiModel.idLoaiConViec,
          thoiGianBatDau: dangKiModel.thoiGianBatDau,
        );

        if (dangKiModel.thoiGianKetThuc != null &&
            dangKiModel.thoiGianKetThuc!.isNotEmpty &&
            dangKiModel.thoiGianKetThuc.toString() != "null") {
          dangKyViecMoiRequestAdd.thoiGianKetThuc = dangKiModel.thoiGianKetThuc;
        }

        if (dangKiModel.thoiGianKetThuc != null &&
            dangKiModel.thoiGianKetThuc!.isNotEmpty &&
            dangKiModel.thoiGianKetThuc.toString() != "null") {
          dangKyViecMoiRequestAdd.soLuong = dangKiModel.soLuong;
        }

        dangKyViecMoiRequestAdd.soLuong = null;
        dangKyViecMoiProvider.add(
          data: dangKyViecMoiRequestAdd,
          onSuccess: (value) {
            themDiaDiemDangKyLamViec(dangKiModel, value.id.toString());
            EasyLoading.dismiss();
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      } else {
        final dangKyViecMoiRequest = DangKyViecMoiRequest(
          idTaiKhoan: userId,
          tieuDe: dangKiModel.tieuDe,
          diaChi: dangKiModel.choOHienTai,
          honNhan: honNhanConvert,
          mucTieuNgheNghiep: dangKiModel.mucTieuNgheNghiep,
          anhHoSoXinViecs: dangKiModel.anhHoSoXinViecs,
          idKeKhaiKinhNghiem: dangKiModel.idKeKhaiKinhNghiems,
          idBangBangCap: dangKiModel.idBangBangCap,
          chucVuHienTai: dangKiModel.chucVuHienTai,
          chucVuMongMuon: dangKiModel.chucVuMongMuon,
          idSoNamKinhNghiem: dangKiModel.idSoNamKinhNghiem,
          noiLamViec: dangKiModel.idNoiLamViecs,
          email: dangKiModel.email,
          gioiTinh: dangKiModel.gioiTinh,
          idHinhThucLamViec: dangKiModel.hinhThucLamViec,
          kyNangSoTruong: dangKiModel.kyNangSoTruong,
          fileHoSoXinViec: dangKiModel.fileHoSoXinViec,
          idNganhNgheMongMuons: dangKiModel.idNganhNgheMongMuons,

          // Ngoại ngữ và tin học
          idNgoaiNgu: dangKiModel.idNgoaiNgu,
          idTinHoc: dangKiModel.idTinHoc,

          // Sở thích và kỹ năng
          phanMemHoTro: dangKiModel.phanMemHoTro,
          soThichKyNang: dangKiModel.soThichTheHienKyNang,
          soThichTrinhDo: dangKiModel.soThichTheHienTinhCach,
          soTichTinhCach: dangKiModel.soThichTheHienTrinhDo,
          idMucLuongDuKien: dangKiModel.mucLuongDeXuat!.id,

          // Tỉnh thành phố, quận huyện, phường xã
          idTinhTp: dangKiModel.tinhTpResponse!.id.toString(),
          idQuanHuyen: dangKiModel.quanHuyenResponse!.id.toString(),
          idPhuongXa: idPhuongXa,

          //Tham khảo
          nguoiThamKhao: dangKiModel.nguoiThamKhao,
          chucDanh: dangKiModel.chucDanh,
          congTy: dangKiModel.congTy,
          soDienThoai: dangKiModel.soDienThoai,
        );
        if (idDangKyViecMoi != null && idDangKyViecMoi.toString() != "null") {
          dangKyViecMoiRequest.id = idDangKyViecMoi;
        } else {
          dangKyViecMoiRequest.id =
              await sl.get<SharedPreferenceHelper>().viecMoi;
        }

        dangKyViecMoiProvider.update(
          data: dangKyViecMoiRequest,
          onSuccess: (value) {
            EasyLoading.dismiss();
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      }
    });
    EasyLoading.dismiss();
    Get.toNamed(AppRoutes.V2_REGISTER_DONE)!.then((value) {
      if (value != null && value == true) {
        Get.back(result: true);
      }
    });
  }

  void themDiaDiemDangKyLamViec(
      DangKyViecMoiModel dangKiModel, String idViecMoi) {
    if (dangKiModel.isCheckHCM.toString().toLowerCase() == "true") {
      diaDiemDangKyLamViecProvider.add(
        data: DiaDiemDangKyLamViecRequest(
          idQuanHuyen: dangKiModel.quanHuyenHoChiMinh,
          idPhuongXa: dangKiModel.phuongXaHoChiMinh,
          idTinhTp: hoChiMinhId,
        ),
        onSuccess: (data) {
          idDiaDiemDangKylamViecPush.add(data.id.toString());
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    }
    if (dangKiModel.isCheckHN.toString().toLowerCase() == "true") {
      diaDiemDangKyLamViecProvider.add(
        data: DiaDiemDangKyLamViecRequest(
          idQuanHuyen: dangKiModel.quanHuyenHaNoi,
          idPhuongXa: dangKiModel.phuongXaHaNoi,
          idTinhTp: haNoiid,
        ),
        onSuccess: (data) {
          idDiaDiemDangKylamViecPush.add(data.id.toString());
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    }
    if (dangKiModel.isCheckDN.toString().toLowerCase() == "true") {
      //Check null Phường/Xã của quận Hoàng sa

      final diaDiemDangKyLamViecRequest = DiaDiemDangKyLamViecRequest(
        idQuanHuyen: dangKiModel.quanHuyenDaNang,
        idTinhTp: daNangId,
      );
      if (dangKiModel.phuongXaDaNang != null &&
          dangKiModel.phuongXaDaNang.toString() != "null") {
        diaDiemDangKyLamViecRequest.idPhuongXa = dangKiModel.phuongXaDaNang;
      }
      diaDiemDangKyLamViecProvider.add(
        data: diaDiemDangKyLamViecRequest,
        onSuccess: (data) {
          idDiaDiemDangKylamViecPush.add(data.id.toString());
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    }

    if (dangKiModel.isCheckTinhTPKhac.toString().toLowerCase() == "true") {
      diaDiemDangKyLamViecProvider.add(
        data: DiaDiemDangKyLamViecRequest(
          idQuanHuyen: dangKiModel.quanHuyenKhac,
          idPhuongXa: dangKiModel.phuongXaKhac,
          idTinhTp: dangKiModel.tinhTpKhac,
        ),
        onSuccess: (data) {
          idDiaDiemDangKylamViecPush.add(data.id.toString());
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    }

    if (dangKiModel.listDiaDiemKhac != null) {
      for (final idModel in dangKiModel.listDiaDiemKhac!.toList()) {
        diaDiemDangKyLamViecProvider.add(
          data: DiaDiemDangKyLamViecRequest(
            idTinhTp: idModel.toString(),
          ),
          onSuccess: (data) {
            idDiaDiemDangKylamViecPush.add(data.id.toString());
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      }
    }

    //Update địa điểm
    Future.delayed(const Duration(milliseconds: 500)).then((val) {
      updateDiaDiem(idViecMoi);
    });
  }

  ///
  /// update dia diem
  ///
  void updateDiaDiem(String viecMoiId) {
    diaDiemDangKyLamViecProvider.paginate(
      page: 1,
      limit: 30,
      filter: "",
      onSuccess: (data) {
        dangKyViecMoiProvider.update(
          data: DangKyViecMoiRequest(
            id: viecMoiId,
            idDiaDiemDangKyLamViecs: idDiaDiemDangKylamViecPush,
          ),
          onSuccess: (data) {
            update();
          },
          onError: (error) {
            print("TermsAndPolicyController getTermsAndPolicy onError $error");
          },
        );
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  ///format date time
  ///
  String formatDateTime({required String dateTime}) {
    return DateConverter.isoStringToVNDateOnly(
            dateTime.replaceAll("T", " ").substring(0, dateTime.length - 1))
        .toString();
  }

  ///
  ///update thông tin
  ///
  void dangKyTuyenDung({
    required String? idTuyenDung,
    required DangKyViecMoiModel dangKiModel,
  }) {
    EasyLoading.show(status: "Loading...");
    if (dangKiModel.honNhan!.toLowerCase() == "độc thân") {
      honNhanConvert = "1";
    } else if (dangKiModel.honNhan!.toLowerCase() == "đã lập gia đình") {
      honNhanConvert = "2";
    } else if (dangKiModel.honNhan!.toLowerCase() == "khác") {
      honNhanConvert = "3";
    }
    sl.get<SharedPreferenceHelper>().userId.then((userId) async {
      final dangKyViecMoiTuyenDung = DangKyViecMoiRequest(
        idTaiKhoan: userId,
        tieuDe: dangKiModel.tieuDe,
        diaChi: dangKiModel.choOHienTai,
        honNhan: honNhanConvert,
        mucTieuNgheNghiep: dangKiModel.mucTieuNgheNghiep,
        anhHoSoXinViecs: dangKiModel.anhHoSoXinViecs,
        idKeKhaiKinhNghiem: dangKiModel.idKeKhaiKinhNghiems,
        idBangBangCap: dangKiModel.idBangBangCap,
        chucVuHienTai: dangKiModel.chucVuHienTai,
        chucVuMongMuon: dangKiModel.chucVuMongMuon,
        idSoNamKinhNghiem: dangKiModel.idSoNamKinhNghiem,
        noiLamViec: dangKiModel.idNoiLamViecs,
        email: dangKiModel.email,
        gioiTinh: dangKiModel.gioiTinh,
        idHinhThucLamViec: dangKiModel.hinhThucLamViec,
        kyNangSoTruong: dangKiModel.kyNangSoTruong,
        fileHoSoXinViec: dangKiModel.fileHoSoXinViec,
        idNganhNgheMongMuons: dangKiModel.idNganhNgheMongMuons,
        // Ngoại ngữ và tin học
        idNgoaiNgu: dangKiModel.idNgoaiNgu,
        idTinHoc: dangKiModel.idTinHoc,
        // Sở thích và kỹ năng
        phanMemHoTro: dangKiModel.phanMemHoTro,
        soThichKyNang: dangKiModel.soThichTheHienKyNang,
        soThichTrinhDo: dangKiModel.soThichTheHienTinhCach,
        soTichTinhCach: dangKiModel.soThichTheHienTrinhDo,
        idMucLuongDuKien: dangKiModel.mucLuongDeXuat!.id,
        // Tỉnh thành phố, quận huyện, phường xã
        idTinhTp: dangKiModel.tinhTpResponse!.id.toString(),
        idQuanHuyen: dangKiModel.quanHuyenResponse!.id.toString(),
        idPhuongXa: dangKiModel.phuongXaResponse!.id.toString(),
        //Tham khảo
        nguoiThamKhao: dangKiModel.nguoiThamKhao,
        chucDanh: dangKiModel.chucDanh,
        congTy: dangKiModel.congTy,
        soDienThoai: dangKiModel.soDienThoai,
      );
      if (idDangKyViecMoi != null && idDangKyViecMoi.toString() != "null") {
        dangKyViecMoiTuyenDung.id = idDangKyViecMoi;
      }

      dangKyViecMoiProvider.update(
        data: dangKyViecMoiTuyenDung,
        onSuccess: (value) {
          danhSachUngTuyenProvider.paginate(
            page: 1,
            limit: 1,
            filter: "&idTaiKhoanUngTuyen=$userId&idTuyenDung=$idTuyenDung",
            onSuccess: (models) {
              if (models.isNotEmpty) {
                Alert.error(
                    message: 'Bạn đã ứng tuyển tin tuyển dụng này rồi!');
                Get.back();
                Get.back(result: true);
              } else {
                danhSachUngTuyenProvider.add(
                  data: DanhSachUngTuyenRequest(
                      idTuyenDung: idTuyenDung,
                      idTaiKhoanUngTuyen: userId,
                      idDangKyViecMoi: value.id.toString(),
                      daXem: "0"),
                  onSuccess: (model) {
                    EasyLoading.dismiss();
                    Alert.success(message: 'Nộp hồ sơ ứng tuyển thành công!');
                    Get.back();
                    Get.back(result: true);
                    update();
                  },
                  onError: (error) {
                    print(
                        "TermsAndPolicyController getTermsAndPolicy onError $error");
                  },
                );
              }
              update();
            },
            onError: (error) {
              print(
                  "TermsAndPolicyController getTermsAndPolicy onError $error");
            },
          );

          EasyLoading.dismiss();
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }
}
