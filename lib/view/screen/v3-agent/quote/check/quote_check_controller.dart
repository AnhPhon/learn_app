import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/yeu_cau_bao_gia_model.dart';
import 'package:template/data/model/request/danh_sach_bao_gia_don_dich_vu_request.dart';
import 'package:template/data/model/request/vat_tu_request.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:url_launcher/url_launcher.dart';

class V3QuoteCheckController extends GetxController {
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();

  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();

  TextEditingController datetimeController = TextEditingController();
  TextEditingController costController = TextEditingController(text: "0");

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
  String filepath = "";

  List<Map<String, dynamic>> features = [];

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    features = [
      {
        "title": "Chỉnh sửa",
        "onTap": () {
          Get.back();
          Get.back();
        },
        "color": ColorResources.LIGHT_GREY
      },
      {
        "title": "Xác nhận báo giá",
        "onTap": () {
          updateYeuCauBaoGia();
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

    // additional
    filepath = yeuCauBaoGiaModel.filepath.toString();
    phiGiaoHang = yeuCauBaoGiaModel.phiGiaoHang!;
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
  void updateYeuCauBaoGia() {
    sl.get<SharedPreferenceHelper>().idYeuCau.then((value) {
      danhSachBaoGiaDonDichVuProvider.update(
        data: DanhSachBaoGiaDonDichVuRequest(
          id: value,
          giaBao: giaTriDonHang.toString(),
          file: filepath,
          trangThaiBaoGia: "2",
        ),
        onSuccess: (data) {
          for (final id in vatTuIds) {
            int index = vatTuIds.indexOf(id);
            vatTuProvider.update(
              data: VatTuRequest(
                  id: id,
                  donGia:
                      (infoCard[index].last["controller"] as TextEditingValue)
                          .text),
              onSuccess: (data) {
                EasyLoading.showSuccess("Xác nhận báo giá thành công");
                Get.back();
                Get.back();
                Get.back();
              },
              onError: (error) {
                print("");
              },
            );
          }
          EasyLoading.showSuccess("Xác nhận báo giá thành công");
          Get.back();
          Get.back();
          Get.back();
        },
        onError: (error) {
          print("V3QuoteCheckController updateYeuCauBaoGia onError $error");
        },
      );
    });
  }
}
