import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/data/model/body/yeu_cau_bao_gia_model.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class V3QuoteResponseController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();

  String tieuDeBaoGia = "Phản hồi báo giá";

  TextEditingController datetimeController = TextEditingController();
  TextEditingController costController = TextEditingController(text: "0");

  bool isCheck = true;
  List<List<Map<String, dynamic>>> infoCard = [];
  String loaiCongTrinh = "Nhà tư";
  String tinhThanh = "TP. HCM";
  String quan = "Quận Gò Vấp";
  String phuong = "Phường 9";
  String diaChiCuThe = "Đường Lê Lợi, P9, Quận Gò Vấp, TP.HCM";
  String from = "25/08/2021";
  String to = "20/09/2021";
  String title = "Yêu cầu báo giá";
  List<String>? noiDungYeuCau;
  List<Map<String, dynamic>>? features;
  List<String> images = [];
  double giaTriDonHang = 0;

  String loaiHinh = "Giao gấp";
  String filepath = "";

  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // load thông tin
    sl.get<SharedPreferenceHelper>().idDonDichVu.then((idDonDichVu) {
      loadInfo(idDonDichVu.toString());
      loadVatTu(idDonDichVu.toString());
    });
  }

  ///
  /// loai vat tu
  ///
  void loadVatTu(String idDonDichVu) {
    infoCard.clear();
    vatTuProvider.paginate(
      page: 1,
      limit: 30,
      filter: '&idDonDichVu=$idDonDichVu',
      onSuccess: (models) {
        final Map<String, int> local = {};

        for (final model in models) {
          if (local.containsKey(model.id) == false) {
            local[model.id.toString()] = 1;
          } else {
            local[model.id.toString()] = local[model.id.toString()]! + 1;
          }

          giaTriDonHang +=
              local[model.id.toString()]! * int.parse(model.donGia.toString());

          infoCard.add([
            {
              "input": false,
              "value": model.tenVatTu,
              "label": "Tên vật liệu",
            },
            {
              "input": false,
              "value": model.quyCach,
              "label": "Quy cách",
            },
            {
              "input": false,
              "value": local[model.id.toString()].toString(),
              "label": "Số lượng",
            },
            {
              "input": false,
              "value": model.donVi,
              "label": "Đơn vị",
            },
            {
              "input": true,
              "value": (local[model.id.toString()]! *
                      int.parse(model.donGia.toString()))
                  .toString(),
              "label": "Đơn giá",
            }
          ]);
        }
        update();
      },
      onError: (error) {
        print("V3QuoteRequestController loadVatTu onError $error");
      },
    );
  }

  ///
  /// load thongo tin don gia dich vu bằng id
  ///
  void loadInfo(String donGiaDichVuId) {
    // load file
    sl.get<SharedPreferenceHelper>().idYeuCau.then((idYeuCau) {
      danhSachBaoGiaDonDichVuProvider.find(
        id: idYeuCau.toString(),
        onSuccess: (data) {
          images = data.hinhAnhBaoGias!.map((e) => e.toString()).toList();
          filepath = data.file.toString();
          update();
        },
        onError: (error) {
          print("V3QuoteRequestController loadInfo onError $error");
        },
      );
    });

    donDichVuProvider.find(
      id: donGiaDichVuId,
      onSuccess: (donDichVu) {
        tieuDeBaoGia = donDichVu.tieuDe.toString();
        loaiCongTrinh = donDichVu.loai.toString();

        if (donDichVu.idTaiKhoanNhanDon != null) {
          if (donDichVu.idTaiKhoanNhanDon!.idTinhTp != null) {
            tinhThanh = donDichVu.idTaiKhoanNhanDon!.idTinhTp!.ten.toString();
          }

          if (donDichVu.idTaiKhoanNhanDon!.idQuanHuyen != null) {
            quan = donDichVu.idTaiKhoanNhanDon!.idQuanHuyen!.ten.toString();
          }

          if (donDichVu.idTaiKhoanNhanDon!.idPhuongXa != null) {
            phuong = donDichVu.idTaiKhoanNhanDon!.idPhuongXa!.ten.toString();
          }
          diaChiCuThe = donDichVu.idTaiKhoanNhanDon!.diaDiemCuThe.toString();
        } else {
          tinhThanh = "";
          quan = "";
          phuong = "";
          diaChiCuThe = "";
        }
        isLoading = false;
        update();
      },
      onError: (error) {
        print("V3QuoteRequestController loadInfo onError $error");
      },
    );
  }

  ///
  /// datePicker
  ///
  void datePicker(BuildContext context, DateTime firstDate, DateTime lastDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime(2021, 10, 7),
      firstDate: firstDate,
      lastDate: lastDate,
    ).then((_dateTime) {
      if (_dateTime != null) {
        datetimeController = TextEditingController(
          text: DateFormat('dd/MM/yyyy').format(_dateTime),
        );
        update();
      }
    });
  }

  ///
  ///onBtnDownCv
  ///
  Future<void> onBtnDownload() async {
    if (await canLaunch(filepath)) {
      await launch(filepath);
    } else {
      throw 'Could not launch $filepath';
    }
  }

  ///
  /// on Cost Change
  ///
  void onCostChange(BuildContext context, String value) {
    if (value.isNotEmpty) {
      costController = TextEditingController(
        text: PriceConverter.convertPrice(context, double.parse(value)),
      );
      // update();
    }
  }

  ///
  /// on Continue Click
  ///
  void onContinueClick() {
    Get.toNamed(
      AppRoutes.V3_QUOTE_CHECK,
      arguments: YeuCauBaoGiaModel(
        diaChiCuThe: diaChiCuThe,
        features: features,
        from: from,
        giaTriDonHang: giaTriDonHang,
        images: images,
        loaiCongTrinh: loaiCongTrinh,
        noiDungYeuCau: noiDungYeuCau,
        phuong: phuong,
        quan: quan,
        tinhThanh: tinhThanh,
        title: title,
        to: to,
        infoCard: infoCard,
        isCheck: isCheck,
        tieuDeBaoGia: tieuDeBaoGia,
        phiGiaoHang: double.parse(costController.text),
        filepath: filepath,
        loaiHinh: loaiHinh,
      ),
    );
  }
}
