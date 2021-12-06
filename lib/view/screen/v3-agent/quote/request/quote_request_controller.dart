import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/chi_tiet_vat_tu_response.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/validate.dart';
import 'package:url_launcher/url_launcher.dart';

class V3QuoteRequestController extends GetxController {
  final DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider =
      GetIt.I.get<ChiTietVatTuProvider>();

  String tieuDeBaoGia = "Cần báo giá xi măng";
  String loaiCongTrinh = "Nhà tư";
  String tinhThanh = "TP. HCM";
  String quan = "Quận Gò Vấp";
  String phuong = "Phường 9";
  String diaChiCuThe = "Đường Lê Lợi, P9, Quận Gò Vấp, TP.HCM";

  String from = "";
  String to = "";
  String? filepath = "";

  String title = "Yêu cầu báo giá";

  List<List<Map<String, dynamic>>> infoCard = [];

  List<String>? noiDungYeuCau = [];

  List<Map<String, dynamic>>? features = [];
  List<String> images = [];

  DonDichVuResponse? idDonDichVu;

  bool isCheck = true;
  bool isLoading = true;
  bool isHidden = true;

  @override
  void onInit() {
    super.onInit();

    // get arguments
    idDonDichVu = Get.arguments as DonDichVuResponse;

    // load thông tin
    loadInfo(idDonDichVu!);

    sl.get<SharedPreferenceHelper>().userId.then((userid) {
      loadHidden(idDonDichVu!, userid!);
      loadVatTu(userid.toString(), idDonDichVu!);
    });

    // tính năng báo giá
    _twoFeatures();
  }

  ///
  /// load thongo tin don gia dich vu bằng id
  ///
  void loadInfo(DonDichVuResponse donGiaDichVuId) {
    noiDungYeuCau!.clear();
    filepath = (Validate.checkValueIsNullEmpty(donGiaDichVuId.files) == false)
        ? donGiaDichVuId.files![0].toString()
        : '';
    from =
        DateConverter.formatDateTimeFull(dateTime: donGiaDichVuId.ngayBatDau!)
            .split(" ")
            .last;
    to = DateConverter.formatDateTimeFull(dateTime: donGiaDichVuId.ngayKetThuc!)
        .split(" ")
        .last;
    tieuDeBaoGia = donGiaDichVuId.tieuDe.toString();
    loaiCongTrinh = donGiaDichVuId.idCongTrinh.toString() == "null"
        ? "Không xác định"
        : donGiaDichVuId.idCongTrinh.toString();
    images =
        donGiaDichVuId.hinhAnhBanKhoiLuongs!.map((e) => e.toString()).toList();
    if (donGiaDichVuId.files != null && donGiaDichVuId.files!.isNotEmpty) {
      filepath = donGiaDichVuId.files!.first;
    }
    if (donGiaDichVuId.moTa != null) {
      noiDungYeuCau!.add(donGiaDichVuId.moTa.toString());
    }

    if (noiDungYeuCau!.isEmpty) {
      noiDungYeuCau!.add("Không có");
    }

    if (donGiaDichVuId.idTinhTp != null) {
      tinhThanh = donGiaDichVuId.idTinhTp!.ten.toString();
    } else {
      tinhThanh = "Chưa có thông tin";
    }

    if (donGiaDichVuId.idQuanHuyen != null) {
      quan = donGiaDichVuId.idQuanHuyen!.ten.toString();
    } else {
      quan = "Chưa có thông tin";
    }

    if (donGiaDichVuId.idPhuongXa != null) {
      phuong = donGiaDichVuId.idPhuongXa!.ten.toString();
    } else {
      phuong = "Chưa có thông tin";
    }

    if (donGiaDichVuId.diaChiCuThe != null) {
      diaChiCuThe = donGiaDichVuId.diaChiCuThe.toString();
    } else {
      diaChiCuThe = "Chưa có thông tin";
    }
    update();
  }

  ///
  /// loai vat tu
  ///
  void loadVatTu(String userId, DonDichVuResponse idDonDichVu) {
    infoCard.clear();
    List<TextEditingController> textControllerList = [];

    chiTietVatTuProvider.paginate(
      page: 1,
      limit: 30,
      filter: '&idDonDichVu=${idDonDichVu.id}&sortBy=created_at:desc',
      onSuccess: (models) {
        for (int i = 0; i < models.length; i++) {
          textControllerList.add(TextEditingController(text: ""));
        }
        for (int index = 0; index < models.length; index++) {
          ChiTietVatTuResponse model = models[index];
          if (model.idVatTu != null && model.idTaiKhoan == "null") {
            infoCard.add([
              {
                "input": false,
                "value": model.idVatTu!.tenVatTu,
                "label": "Tên vật liệu",
              },
              {
                "input": false,
                "value": model.idVatTu!.quyCach.toString() == "null"
                    ? ""
                    : model.idVatTu!.quyCach.toString(),
                "label": "Quy cách",
              },
              {
                "input": false,
                "value": model.soLuong.toString() == "null"
                    ? "0"
                    : model.soLuong.toString(),
                "label": "Số lượng",
              },
              {
                "input": false,
                "value": model.idVatTu!.donVi.toString() == "null"
                    ? ""
                    : model.idVatTu!.donVi.toString(),
                "label": "Đơn vị",
              },
              {
                "visible": false,
                "input": true,
                "controller": textControllerList[index],
                "value": textControllerList[index].text,
                "label": "Đơn giá",
                "id": model.idVatTu!.id,
              },
            ]);
          }
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3QuoteRequestController loadVatTu onError $error");
      },
    );
  }

  ///
  /// load thông để set
  ///
  void loadHidden(DonDichVuResponse ddv, String userid) {
    danhSachBaoGiaDonDichVuProvider.paginate(
      filter: "&idDonDichVu=${ddv.id}&idTaiKhoanBaoGia=$userid",
      limit: 5,
      page: 1,
      onSuccess: (data) {
        if (data.isNotEmpty) {
          isHidden = false;
          update();
        }
      },
      onError: (error) {
        print(error);
      },
    );
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
  /// 2 tính năng báo giá
  ///
  void _twoFeatures() {
    features = [
      {
        "title": "Từ chối báo giá",
        "onTap": () {
          Get.back();
        },
        "color": ColorResources.LIGHT_GREY //Color(0XFFB0BAC1)
      },
      {
        "title": "Đồng ý báo giá",
        "onTap": () {
          onPhanHoiClick();
        },
        "color": ColorResources.THEME_DEFAULT
      },
    ];
  }

  ///
  /// on phan hoi
  ///
  void onPhanHoiClick() {
    Get.toNamed(AppRoutes.V3_QUOTE_RESPONSE,
        arguments: [idDonDichVu, infoCard]);
  }
}
