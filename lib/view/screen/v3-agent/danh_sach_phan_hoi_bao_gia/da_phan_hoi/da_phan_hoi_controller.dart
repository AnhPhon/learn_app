import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/cai_dat_chung_provider.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phi_app_provider.dart';
import 'package:template/provider/upload_image_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class V3DaPhanHoiController extends GetxController
    with SingleGetTickerProviderMixin {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  PhiAppProvider phiAppProvider = GetIt.I.get<PhiAppProvider>();
  CaiDatChungProvider caiDatChungProvider = GetIt.I.get<CaiDatChungProvider>();
  ImageUpdateProvider imageUpdateProvider = GetIt.I.get<ImageUpdateProvider>();
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider =
      GetIt.I.get<ChiTietVatTuProvider>();

  TextEditingController datetimeController = TextEditingController();
  TextEditingController costController = TextEditingController(text: "");

  bool isCheck = true;
  List<List<Map<String, dynamic>>> infoCard = [];
  String tieuDeBaoGia = "Danh sách báo giá đơn hàng";
  String loaiCongTrinh = "Nhà tư";
  String tinhThanh = "TP. HCM";
  String quan = "Quận Gò Vấp";
  String phuong = "Phường 9";
  String diaChiCuThe = "Đường Lê Lợi, P9, Quận Gò Vấp, TP.HCM";
  String from = "25/08/2021";
  String to = "20/09/2021";
  List<String> noiDungYeuCau = [];
  List<String> images = [];
  List<String> vatTuIds = [];
  double giaTriDonHang = 0;
  double phiGiaoHang = 0;
  String loaiHinh = "Giao gấp";
  String? filepath = "";

  String timeStartGiaoHang = "";
  String timeEndGiaoHang = "";
  String ngayStartGiaoHang = "";
  String ngayEndGiaoHang = "";

  String title = "Báo giá đã phản hồi";
  List<dynamic> giaVatTus = [];

  DonDichVuResponse? idDonDichVu;

  bool isLoading = true;

  double soTien = 0;
  double phiDichVu = 0;
  double khuyenMaiCuaApp = 0;

  @override
  void onInit() {
    super.onInit();

    idDonDichVu = Get.arguments as DonDichVuResponse;

    // load dữ liệu theo id đơn dịch vụ
    loadData(idDonDichVu!);

    update();
  }

  ///
  /// load data
  ///
  void loadData(DonDichVuResponse data) {
    // Load dữ liệu theo đơn dịch được chọn
    if (data.files != null && data.files!.isNotEmpty) {
      filepath = data.files!.first.toString();
    }
    images = data.hinhAnhBaoGias!.map((e) => e.toString()).toList();

    // Load thông tin về thời gian
    danhSachBaoGiaDonDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idDonDichVu=${idDonDichVu!.id}",
      onSuccess: (data) {
        if (data.isNotEmpty) {
          if (data.first.phiVanChuyen.toString() != "null") {
            phiGiaoHang = double.parse(data.first.phiVanChuyen ?? "0");
            DateTime start = DateTime.now();

            if (data.first.thoiGianVanChuyenBatDau != null) {
              start = DateTime.parse(data.first.thoiGianVanChuyenBatDau!);
            }

            DateTime end = DateTime.now();

            if (data.first.thoiGianVanChuyenKetThuc != null) {
              end = DateTime.parse(data.first.thoiGianVanChuyenKetThuc!);
            }

            // Thiết lập thời gian giao hàng
            timeStartGiaoHang = DateConverter.toTime(start);
            timeEndGiaoHang = DateConverter.toTime(end);

            // thiết lập ngày bắt đầu giao hàng
            ngayStartGiaoHang = DateConverter.estimatedDateMonthYear(start);

            // thiết lpaja ngày kết thúc giao hàng
            ngayEndGiaoHang = DateConverter.estimatedDateMonthYear(end);
          }
        }
      },
      onError: (error) {
        print("V3ChuaPhanHoiController loadData onError $error");
      },
    );

    // load chi tiết vật tư theo đơn dịch vụ
    chiTietVatTuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idDonDichVu=${idDonDichVu!.id}&sortBy=created_at:desc",
      onSuccess: (chiTietVatTuList) {
        for (final chiTietVatTu in chiTietVatTuList) {
          final String soLuong = chiTietVatTu.soLuong.toString() == 'null'
              ? "0"
              : chiTietVatTu.soLuong.toString();
          // check null với các trường chi tiết vật tư có id tham chiếu vật tư là null
          if (chiTietVatTu.idVatTu != null) {
            vatTuProvider.find(
              id: chiTietVatTu.idVatTu!.id.toString(),
              onSuccess: (vatTu) {
                // thêm bảng báo giá
                infoCard.add([
                  {
                    "input": false,
                    "value": vatTu.tenVatTu,
                    "label": "Tên vật liệu",
                  },
                  {
                    "input": false,
                    "value": vatTu.quyCach,
                    "label": "Quy cách",
                  },
                  {
                    "input": false,
                    "value": soLuong,
                    "label": "Số lượng",
                  },
                  {
                    "input": false,
                    "value": vatTu.donVi,
                    "label": "Đơn vị",
                  },
                  {
                    "input": true,
                    "controller":
                        TextEditingController(text: vatTu.donGia.toString()),
                    "value": vatTu.donGia.toString(),
                    "label": "Đơn giá",
                  }
                ]);
                giaTriDonHang += double.parse(vatTu.donGia.toString() == "null"
                        ? "0"
                        : vatTu.donGia.toString()) *
                    int.parse(soLuong);

                // tinh tien
                tinhTien();
                update();
              },
              onError: (error) {
                print("V3ChuaPhanHoiController loadData onError $error");
              },
            );
          }
        }
      },
      onError: (error) {
        print("V3ChuaPhanHoiController loadData onError $error");
      },
    );
    update();
  }

  ///
  ///onBtnDownCv
  ///
  Future<void> onBtnDownload() async {
    if (await canLaunch(filepath!)) {
      await launch(filepath!);
    } else {
      throw 'Could not launch $filepath';
    }
  }

  ///
  /// onThanhToanPhiDichVuClick
  ///
  void onThanhToanPhiDichVuClick() {
    Get.toNamed(AppRoutes.V3_THANH_TOAN_PHI_DICH_VU, arguments: [
      giaTriDonHang,
      khuyenMaiCuaApp,
      phiDichVu,
    ])!
        .then((value) {
      loadData(idDonDichVu!);
    });
  }

  ///
  /// check is valid date
  ///
  bool isValidDate(String input) {
    try {
      final date = DateTime.parse(input);
      final originalFormatString = toOriginalFormatString(date);
      return input == originalFormatString;
    } catch (e) {
      return false;
    }
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

        if (donGiaBatDau <= giaTriDonHang && giaTriDonHang <= donGiaKetThuc) {
          phanTramPhi = double.parse(phi.phi.toString());
          phiDichVu = giaTriDonHang * phanTramPhi / 100;

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
  /// to origial format string
  ///
  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y$m$d";
  }
}
