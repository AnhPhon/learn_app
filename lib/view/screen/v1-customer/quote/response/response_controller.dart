// ignore_for_file: type_annotate_public_apis

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/don_dich_vu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/cai_dat_chung_provider.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phi_app_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/v1-customer/services/g7-recruitment/pricelist/g7_price_dialog_accept.dart';
import 'package:url_launcher/url_launcher.dart';

class V1ResponseController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider =
      GetIt.I.get<ChiTietVatTuProvider>();

  PhiAppProvider phiAppProvider = GetIt.I.get<PhiAppProvider>();
  CaiDatChungProvider caiDatChungProvider = GetIt.I.get<CaiDatChungProvider>();

  TextEditingController costController = TextEditingController(text: "");
  String title = "Phản hồi đơn giá vật tư";
  String tenDonDichVu = "";
  String ngayBatDau = "";
  String ngayKetThuc = "";

  List<List<Map<String, dynamic>>> infoCard = [];
  List<String> images = [];
  double tongTien = 0;
  double phiVanChuyen = 0;
  String? fileURL = "";
  bool isLoading = true;
  bool isHidden = false;
  DonDichVuResponse? idDonDichVu;
  String loaiHinh = "";
  double giaTriDonHang = 0;
  double phiDichVu = 0;
  double khuyenMaiCuaApp = 0;

  String timeStart = "";
  String timeEnd = "";

  @override
  void onInit() {
    super.onInit();

    // Load đơn dịch vụ từ argument
    idDonDichVu = Get.arguments as DonDichVuResponse;

    loaiHinh = idDonDichVu!.tienDoGiaoHang.toString() == "1"
        ? "Giao gấp"
        : "Không gấp";

    // load thong tin don dich vu
    sl.get<SharedPreferenceHelper>().userId.then((userId) {
      loadThongTinDonDichVU(userId!, idDonDichVu!);
      // load thong tin vat tu
      loadThongTinVatTu(userId, idDonDichVu);
    });

    // load hidden
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      loadHidden(idDonDichVu!, value!);
    });
  }

  ///
  /// load thong tin don dich vu
  ///
  void loadThongTinDonDichVU(String idTaiKhoan, DonDichVuResponse donDichVu) {
    tenDonDichVu = donDichVu.tieuDe!;

    danhSachBaoGiaDonDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idDonDichVu=${donDichVu.id}&idTaiKhoanBaoGia=$idTaiKhoan",
      onSuccess: (data) {
        if (data.isNotEmpty) {
          for (final item in data) {
            if (donDichVu.idTaiKhoanNhanDon!.id == idTaiKhoan) {
              tongTien = double.parse(item.tongTien.toString());
              if (item.phiVanChuyen.toString() != "null") {
                if (item.thoiGianVanChuyenBatDau.toString() != "null") {
                  final List<String> temp =
                      DateConverter.isoStringToVNTimeDateOnly(item
                              .thoiGianVanChuyenBatDau!
                              .replaceAll("T", " "))
                          .split(" ");
                  timeStart = temp[0];
                  ngayBatDau = temp[1];
                }
                if (item.thoiGianVanChuyenKetThuc.toString() != "null") {
                  final List<String> temp =
                      DateConverter.isoStringToVNTimeDateOnly(item
                              .thoiGianVanChuyenKetThuc!
                              .replaceAll("T", " "))
                          .split(" ");
                  timeEnd = temp[0];
                  ngayKetThuc = temp[1];
                }
                phiVanChuyen = double.parse(item.phiVanChuyen.toString());
              }

              // xử lý trường dữ liệu image
              if (item.hinhAnhBaoGias != null) {
                images = item.hinhAnhBaoGias!.map((e) => e.toString()).toList();
              }
              update();
              break;
            }
          }
        }
      },
      onError: (error) {
        print("V3QuoteRequestController loadThongTinDonDichVU onError $error");
      },
    );

    if (donDichVu.files != null && donDichVu.files!.isNotEmpty) {
      fileURL = donDichVu.files!.first;
    }
    update();
  }

  ///
  /// tinh tiền
  ///
  void tinhTien() {
    // load khuyến mãi
    phiAppProvider.all(onSuccess: (phiApps) {
      double phanTramPhi = 0;
      for (final phi in phiApps) {
        final double donGiaBatDau = double.parse(phi.donGiaBatDau.toString());
        final double donGiaKetThuc = double.parse(phi.donGiaKetThuc.toString());

        if (donGiaBatDau <= tongTien && tongTien <= donGiaKetThuc) {
          phanTramPhi = double.parse(phi.phi.toString());
          phiDichVu = tongTien * phanTramPhi / 100;

          // set value cho khuyến mãi app
          caiDatChungProvider.all(
            onSuccess: (data) {
              if (data.isNotEmpty) {
                khuyenMaiCuaApp =
                    double.parse(data.first.khuyenMai.toString()) /
                        100 *
                        phiDichVu;
              }
              isLoading = false;
              update();
            },
            onError: (error) {
              print(error);
            },
          );
          update();
        }
      }
    }, onError: (error) {
      print(error);
    });
  }

  ///
  /// load thong tin vat tu
  ///
  void loadThongTinVatTu(String idTaiKhoan, DonDichVuResponse? donDichVu) {
    infoCard = [];
    // load vat tu theo don dich vu
    chiTietVatTuProvider.paginate(
      page: 1,
      limit: 30,
      filter:
          "&idDonDichVu=${donDichVu!.id}&idTaiKhoan=$idTaiKhoan&sortBy=dateStart:desc",
      onSuccess: (data) {
        for (final model in data) {
          if (model.idDonDichVu != null) {
            final String soLuong = model.soLuong.toString() == "null"
                ? "0"
                : model.soLuong.toString();
            if (model.idVatTu != null) {
              final String donGia = model.donGia.toString();
              infoCard.add([
                {
                  "input": false,
                  "value": model.idVatTu!.tenVatTu!,
                  "label": "Tên vật liệu",
                },
                {
                  "input": false,
                  "value": model.idVatTu!.quyCach,
                  "label": "Quy cách",
                },
                {
                  "input": false,
                  "value": soLuong,
                  "label": "Số lượng",
                },
                {
                  "input": false,
                  "value": model.idVatTu!.donVi,
                  "label": "Đơn vị",
                },
                {
                  "input": false,
                  "value": donGia,
                  "label": "Đơn giá",
                }
              ]);
            }
          }
        }

        // tinh tien
        tinhTien();

        update();
      },
      onError: (error) {
        print("V3QuoteRequestController loadVatTu onError $error");
      },
    );
  }

  ///
  /// show download progress
  ///
  Future<void> showDownloadProgress(received, total) async {
    if (total != -1) {
      EasyLoading.showProgress((received as int) / (total as int));
    }
  }

  ///
  /// load thông để set
  ///
  void loadHidden(DonDichVuResponse ddv, String userid) {
    donDichVuProvider.find(
      id: ddv.id!,
      onSuccess: (data) {
        if (data.idTrangThaiThanhToanKhac != null &&
            data.idTrangThaiThanhToanKhac!.id == DA_THANH_TOAN) {
          isHidden = true;
        }
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// xác nhận
  ///
  void onxacNhanClick() {
    Get.toNamed(AppRoutes.V1_PAYMENT_METHOD, arguments: [
      idDonDichVu,
      [
        tongTien,
        phiDichVu,
        khuyenMaiCuaApp,
        (tongTien * .1),
      ],
    ])!
        .then((value) {
      donDichVuProvider.update(
        data: DonDichVuRequest(
          id: idDonDichVu!.id,
          tienCoc: (tongTien * .1).toString(),
          phiDichVu: phiDichVu.toString(),
          phiDichVuKhac: phiDichVu.toString(),
          tienCocKhac: (tongTien * .1).toString(),
          khuyenMaiKhac: khuyenMaiCuaApp.toString(),
        ),
        onSuccess: (data) {},
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
      Get.toNamed(AppRoutes.V1_PAYMENT_METHOD,
              arguments: [idDonDichVu, Get.arguments[0] as List<double>])!
          .then(
        (value) {
          if (value != null) {
            donDichVuProvider.update(
              data: DonDichVuRequest(
                id: idDonDichVu!.id,
                tienCoc: (tongTien * .1).toString(),
                phiDichVu: phiDichVu.toString(),
                phiDichVuKhac: phiDichVu.toString(),
                tienCocKhac: (tongTien * .1).toString(),
                khuyenMaiKhac: khuyenMaiCuaApp.toString(),
              ),
              onSuccess: (data) {},
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );
          }
        },
      );
    });
  }

  ///
  /// không đồng ý
  ///
  void khongDongY() {
    Get.defaultDialog(
      title: "Thông báo",
      content: DialogContentPriceAccept(
        textContent: 'Bạn có muốn hủy đơn hàng này không',
      ),
      confirm: ElevatedButton(
          onPressed: () {
            Alert.error(message: "Đã hủy đơn hàng");
            donDichVuProvider.update(
              data: DonDichVuRequest(
                id: idDonDichVu!.id,
                idTrangThaiDonDichVu: DA_HUY,
              ),
              onSuccess: (data) {
                Get.back(result: true);
              },
              onError: (error) {
                print(
                    "V3QuotePhanHoiBaoGiaController onXoaDonHangClick onError $error");
              },
            );
          },
          child: const Text("Đồng ý")),
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
  ///onBtnDownCv
  ///
  Future<void> onBtnDownload() async {
    if (await canLaunch(fileURL!)) {
      await launch(fileURL!);
    } else {
      throw 'Could not launch $fileURL';
    }
  }
}
