import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/phan_hoi_don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart' as constants;
import 'package:url_launcher/url_launcher.dart';

class V1NoResponseController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider =
      GetIt.I.get<ChiTietVatTuProvider>();
  PhanHoiDonDichVuProvider phanHoiDonDichVuProvider =
      GetIt.I.get<PhanHoiDonDichVuProvider>();

  String title = "Yêu cầu báo giá vật tư";
  String tenDonDichVu = "";
  String congTrinh = "";
  String ngayBatDau = "";
  String ngayKetThuc = "";
  String tinhTp = "";
  String diaChi = "";
  String quanHuyen = "";
  String phuongXa = "";
  String yeuCau = "";
  String loaiHinh = "";

  List<List<Map<String, dynamic>>> infoCard = [];
  List<String> images = [];
  double tongTien = 0;
  String? fileURL = "";
  bool isLoading = true;

  DonDichVuResponse? idDonDichVu;

  @override
  void onInit() {
    super.onInit();

    // Load đơn dịch vụ từ argument
    idDonDichVu = Get.arguments as DonDichVuResponse;

    // load thong tin don dich vu
    loadThongTinDonDichVU(idDonDichVu!);

    // load thong tin vat tu
    loadThongTinVatTu(idDonDichVu!);
  }

  ///
  /// load thong tin don dich vu
  ///
  void loadThongTinDonDichVU(DonDichVuResponse donDichVu) {
    // biến chưa địa chỉ tạm
    final List<String> addressTemp = [];

    // reset ngayBatDau và ngay kết thúc
    tenDonDichVu = donDichVu.tieuDe!;

    if (donDichVu.ngayBatDau.toString() != "null") {
      ngayBatDau = DateConverter.isoStringToVNDateOnly(
          donDichVu.ngayBatDau!.replaceAll("T", " "));
    }

    if (donDichVu.ngayKetThuc.toString() != "null") {
      ngayKetThuc = DateConverter.isoStringToVNDateOnly(
          donDichVu.ngayKetThuc!.replaceAll("T", " "));
    }

    // loai hình
    loaiHinh = donDichVu.tienDoGiaoHang ?? constants.UNDEFINE_LABEL;

    // loai công trình
    congTrinh = donDichVu.idCongTrinh.toString();
    if (congTrinh == "null") congTrinh = "Không xác định";

    // Load địa chỉ
    tinhTp = donDichVu.idTinhTp.toString();
    quanHuyen = donDichVu.idQuanHuyen.toString();
    phuongXa = donDichVu.idPhuongXa.toString();

    if (phuongXa != "null") addressTemp.add(phuongXa);
    if (quanHuyen != "null") addressTemp.add(quanHuyen);
    if (tinhTp != "null") addressTemp.add(tinhTp);
    if (addressTemp.isNotEmpty) diaChi = addressTemp.join(" - ");

    // xử lý trường dữ liệu image
    for (final image in donDichVu.hinhAnhBanKhoiLuongs!) {
      if (image.toString().trim().isNotEmpty) {
        images.add(image.toString());
      }
    }

    if (donDichVu.files != null && donDichVu.files!.isNotEmpty) {
      fileURL = donDichVu.files!.first;
    }

    update();
  }

  ///
  /// load thong tin vat tu
  ///
  void loadThongTinVatTu(DonDichVuResponse idDonDichVu) {
    infoCard = [];

    // Load nội dung yêu cầu
    yeuCau = idDonDichVu.moTa ?? "Không có";

    if (yeuCau.trim().isEmpty) {
      yeuCau = "Không có";
    }

    // load danh sách vật tư theo idDonDichVu
    chiTietVatTuProvider.paginate(
      page: 1,
      limit: 10,
      filter: "&idDonDichVu=${idDonDichVu.id}&sortBy=created_at:desc",
      onSuccess: (dataList) {
        for (final chiTietVatTu in dataList) {
          if (chiTietVatTu.idVatTu != null &&
              chiTietVatTu.idTaiKhoan == "null") {
            vatTuProvider.find(
              id: chiTietVatTu.idVatTu!.id.toString().trim(),
              onSuccess: (vatTu) {
                infoCard.add([
                  {
                    "label": "Tên vật liệu",
                    "value": vatTu.tenVatTu ?? "",
                    "input": false,
                  },
                  {
                    "label": "Quy cách",
                    "value": vatTu.quyCach ?? "Không xác định",
                    "input": false,
                  },
                  {
                    "label": "Số lượng",
                    "value": chiTietVatTu.soLuong ?? "0",
                    "input": false,
                  },
                  {
                    "label": "Đơn vị",
                    "value": vatTu.donVi ?? "0",
                    "input": false,
                  },
                ]);
                update();
              },
              onError: (error) {
                print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error");
              },
            );
          }
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// show download progress
  ///
  void showDownloadProgress(received, total) {
    if (total != -1) {
      EasyLoading.showProgress((received as int) / (total as int));
    }
  }

  ///
  /// xác nhận
  ///
  void onxacNhanClick() {
    sl.get<SharedPreferenceHelper>().saveGiaTriDonHang(tongTien);
    Get.toNamed(AppRoutes.V1_BILL_DETAIL);
  }

  ///
  /// không đồng ý
  ///
  void khongDongY() {
    Get.back();
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
