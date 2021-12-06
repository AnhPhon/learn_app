import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/body/yeu_cau_bao_gia_model.dart';
import 'package:template/data/model/request/chi_tiet_vat_tu_request.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/data/model/request/vat_tu_request.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/color_resources.dart';
import 'package:url_launcher/url_launcher.dart';

class V3QuoteCheckController extends GetxController {
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider =
      GetIt.I.get<ChiTietVatTuProvider>();

  TextEditingController datetimeController = TextEditingController();
  TextEditingController costController = TextEditingController(text: "");

  bool isCheck = true;
  List<List<Map<String, dynamic>>> infoCard = [];
  String tieuDeBaoGia = "";
  String loaiCongTrinh = "";
  String tinhThanh = "";
  String quan = "";
  String phuong = "";
  String diaChiCuThe = "";
  String from = "";
  String to = "";
  List<String> noiDungYeuCau = [];
  List<String> images = [];
  List<String> vatTuIds = [];
  double giaTriDonHang = 0;
  double phiVanChuyen = 0;
  String loaiHinh = "";
  String? filepath = "";

  String timeStart = "";
  String timeEnd = "";
  List<Map<String, dynamic>> features = [];
  DonDichVuResponse? idDonDichVu;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    features = [
      {
        "title": "Chỉnh sửa",
        "onTap": () {
          Get.back();
        },
        "color": ColorResources.LIGHT_GREY
      },
      {
        "title": "Xác nhận báo giá",
        "onTap": () {
          sl.get<SharedPreferenceHelper>().userId.then((value) {
            updateYeuCauBaoGia(value.toString());
          });
        },
        "color": ColorResources.THEME_DEFAULT
      },
    ];

    // load data
    final YeuCauBaoGiaModel yeuCauBaoGiaModel =
        Get.arguments as YeuCauBaoGiaModel;

    infoCard = List.from(yeuCauBaoGiaModel.infoCard ?? []);
    loaiCongTrinh = yeuCauBaoGiaModel.loaiCongTrinh ?? "";
    tinhThanh = yeuCauBaoGiaModel.tinhThanh ?? "";
    quan = yeuCauBaoGiaModel.quan ?? "";
    phuong = yeuCauBaoGiaModel.phuong ?? "";
    diaChiCuThe = yeuCauBaoGiaModel.diaChiCuThe ?? "";
    from = yeuCauBaoGiaModel.from ?? "";
    to = yeuCauBaoGiaModel.to ?? "";
    noiDungYeuCau = yeuCauBaoGiaModel.noiDungYeuCau ?? [];
    images = yeuCauBaoGiaModel.images ?? [];
    giaTriDonHang = yeuCauBaoGiaModel.giaTriDonHang ?? 0;
    tieuDeBaoGia = yeuCauBaoGiaModel.tieuDeBaoGia ?? "";
    vatTuIds = yeuCauBaoGiaModel.vatTuIds ?? [];
    timeStart = yeuCauBaoGiaModel.timeStart ?? "";
    timeEnd = yeuCauBaoGiaModel.timeEnd ?? "";
    idDonDichVu = yeuCauBaoGiaModel.idDonDichVu;

    // additional
    filepath = yeuCauBaoGiaModel.filepath.toString();
    phiVanChuyen = yeuCauBaoGiaModel.phiGiaoHang!;
    loaiHinh = yeuCauBaoGiaModel.loaiHinh.toString();

    isLoading = false;
    update();
  }

  ///
  /// get filename by filepath
  ///
  String getFilename(String filePath) {
    return filePath.split("/").last;
  }

  ///
  ///onBtnDownCv
  ///
  Future<void> onBtnDownload({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///
  /// update dữ liệu
  ///
  void updateYeuCauBaoGia(String userId) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final List<String> fromTime = timeStart.split(":");
    final List<String> toTime = timeEnd.split(":");
    DateTime fromDate = inputFormat.parse(from);
    DateTime toDate = inputFormat.parse(to);

    fromDate = DateTime(fromDate.year, fromDate.month, fromDate.day,
        int.parse(fromTime[0]), int.parse(fromTime[1]));
    toDate = DateTime(toDate.year, toDate.month, toDate.day,
        int.parse(toTime[0]), int.parse(toTime[1]));

    // update don gia cho chi tiet vat tu
    for (final info in infoCard) {
      String donGia = "0";
      String soLuong = "0";
      String? id;
      for (final index in info) {
        if (index["label"].toString().toLowerCase() == "đơn giá") {
          donGia = index['controller']
              .text
              .toString()
              .replaceAll(".", "")
              .replaceAll("VND", "")
              .trim();
          id = index["id"].toString();
        }

        if (index["label"].toString().toLowerCase() == "số lượng") {
          soLuong = int.parse(index["value"].toString()).toString();
        }
      }
      final ChiTietVatTuRequest request = ChiTietVatTuRequest(
        idDonDichVu: idDonDichVu!.id,
        donGia: donGia,
        soLuong: soLuong,
        idTaiKhoan: userId,
        idVatTu: id,
      );

      chiTietVatTuProvider.add(
        data: request,
        onSuccess: (data) {},
        onError: (error) {
          print("V3QuoteCheckController updateYeuCauBaoGia onError $error");
        },
      );
    }

    // danh sách báo giá đơn dịch vụ
    danhSachBaoGiaDonDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idDonDichVu=${idDonDichVu!.id}&sortBy=created_at:desc",
      onSuccess: (data) {
        final DanhSachBaoGiaDonDichVuRequest request =
            DanhSachBaoGiaDonDichVuRequest(
          tongTien: giaTriDonHang.toString(),
          phiVanChuyen: phiVanChuyen.toString(),
          thoiGianVanChuyenBatDau: fromDate.toIso8601String(),
          thoiGianVanChuyenKetThuc: toDate.toIso8601String(),
          idDonDichVu: idDonDichVu!.id,
          idTaiKhoanBaoGia: userId,
          file: filepath!.isEmpty ? '...' : filepath,
          hinhAnhBaoGias: images,
          daXem: "0",
        );

        // thêm vào danh sách báo giá
        danhSachBaoGiaDonDichVuProvider.add(
          data: request,
          onSuccess: (data) {
            Alert.success(message: "Xác nhận báo giá thành công");
            Get.back();
            Get.back();
            Get.back();
            Get.back();
          },
          onError: (error) {
            print("V3QuoteCheckController updateYeuCauBaoGia onError $error");
          },
        );
      },
      onError: (error) {
        print("V3QuoteCheckController updateYeuCauBaoGia onError $error");
      },
    );
  }
}
