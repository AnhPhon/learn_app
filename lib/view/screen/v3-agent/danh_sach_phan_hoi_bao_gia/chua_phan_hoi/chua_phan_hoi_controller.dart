import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart' as constant;
import 'package:url_launcher/url_launcher.dart';

class V3ChuaPhanHoiController extends GetxController
    with SingleGetTickerProviderMixin {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider =
      GetIt.I.get<ChiTietVatTuProvider>();

  TextEditingController datetimeController = TextEditingController();

  List<List<Map<String, dynamic>>> infoCard = [];
  String tieuDeBaoGia = "Danh sách báo giá đơn hàng";
  List<String> images = [];
  double phiGiaoHang = 0;
  String loaiHinh = "Giao gấp";
  String? filepath = "";

  String timeStartGiaoHang = "";
  String timeEndGiaoHang = "";
  String ngayStartGiaoHang = "";
  String ngayEndGiaoHang = "";

  String title = "Báo giá chưa phản hồi";
  List<dynamic> giaVatTus = [];

  DonDichVuResponse? idDonDichVu;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    // load id đơn dịch vụ từ argument
    idDonDichVu = Get.arguments as DonDichVuResponse;

    // load dữ liệu từ id đơn dịch vụ
    sl.get<SharedPreferenceHelper>().userId.then((value) {
      loadData(value.toString(), idDonDichVu!);
    });

    update();
  }

  ///
  /// load data
  ///
  void loadData(String userId, DonDichVuResponse data) {
    // load dữ liệu theo đơn dịch được chọn
    if (data.files != null && data.files!.isNotEmpty) {
      filepath = data.files!.first;
    }

    // load danh sách hình ảnh báo giá
    images = data.hinhAnhBaoGias!.map((e) => e.toString()).toList();

    // load tiêu đề báo giá
    tieuDeBaoGia = data.tieuDe ?? constant.UNDEFINE_LABEL;

    // load trạng thái tiến độ giao hàng
    if (data.tienDoGiaoHang != null) {
      loaiHinh =
          data.tienDoGiaoHang.toString() == "1" ? "Giao gấp" : "Không gấp";
    } else {
      loaiHinh = constant.UNDEFINE_LABEL;
    }

    // load thông tin về thời gian
    danhSachBaoGiaDonDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter:
          "&idDonDichVu=${idDonDichVu!.id}&idTaiKhoanBaoGia=$userId&sortBy=created_by:desc",
      onSuccess: (baoGia) {
        for (final item in baoGia) {
          if (item.idTaiKhoanBaoGia!.id == userId) {
            DateTime start = DateTime.now();
            if (item.thoiGianVanChuyenBatDau.toString() != "null") {
              start = DateTime.parse(item.thoiGianVanChuyenBatDau.toString());
            }

            DateTime end = DateTime.now();

            if (item.thoiGianVanChuyenBatDau.toString() != "null") {
              end = DateTime.parse(item.thoiGianVanChuyenKetThuc.toString());
            }

            // Thiết lập thời gian giao hàng
            timeStartGiaoHang = DateConverter.toTime(start);
            timeEndGiaoHang = DateConverter.toTime(end);

            // thiết lập ngày bắt đầu giao hàng
            ngayStartGiaoHang = DateConverter.estimatedDateMonthYear(start);

            // thiết lpaja ngày kết thúc giao hàng
            ngayEndGiaoHang = DateConverter.estimatedDateMonthYear(end);

            // phí giao hàng
            phiGiaoHang = double.parse(item.phiVanChuyen ?? "0");
            break;
          }
        }

        // load chi tiết vật tư theo đơn dịch vụ
        chiTietVatTuProvider.paginate(
          page: 1,
          limit: 30,
          filter:
              "&idDonDichVu=${idDonDichVu!.id}&idTaiKhoan=$userId&sortBy=created_at:desc",
          onSuccess: (chiTietVatTuList) {
            for (final chiTietVatTu in chiTietVatTuList) {
              // check null với các trường chi tiết vật tư có id tham chiếu vật tư là null
              if (baoGia.first.idTaiKhoanBaoGia!.id == userId) {
                infoCard.add([
                  {
                    "input": false,
                    "value": chiTietVatTu.idVatTu!.tenVatTu,
                    "label": "Tên vật liệu",
                  },
                  {
                    "input": false,
                    "value": chiTietVatTu.idVatTu!.quyCach,
                    "label": "Quy cách",
                  },
                  {
                    "input": false,
                    "value": chiTietVatTu.soLuong.toString(),
                    "label": "Số lượng",
                  },
                  {
                    "input": false,
                    "value": chiTietVatTu.idVatTu!.donVi,
                    "label": "Đơn vị",
                  },
                  {
                    "input": false,
                    "value": chiTietVatTu.donGia.toString(),
                    "label": "Đơn giá",
                  }
                ]);
              }
            }
            isLoading = false;
            update();
          },
          onError: (error) {
            print("V3ChuaPhanHoiController loadData onError $error");
          },
        );
      },
      onError: (error) {
        print("V3ChuaPhanHoiController loadData onError $error");
      },
    );
  }

  ///
  ///onBtnDownCv
  ///
  Future<void> onBtnDownload() async {
    if (await canLaunch(filepath ?? "..")) {
      await launch(filepath ?? "..");
    } else {
      throw 'Could not launch $filepath';
    }
  }
}
