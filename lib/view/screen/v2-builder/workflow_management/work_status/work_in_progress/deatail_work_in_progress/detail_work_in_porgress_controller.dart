import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/provider/chi_tiet_vat_tu_provider.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';

class V2DetailWorkInProgressController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  ChiTietVatTuProvider chiTietVatTuProvider =
      GetIt.I.get<ChiTietVatTuProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();
  DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  //Khai báo isLoading
  bool isLoading = true;

  String title = "Thợ ốp lát công trình khách 5 sao";
  String description = "Mô tả công việc";
  String address = "Địa chị (quận huyện)";
  String startTime = "12/09/2021";
  String endTime = "12/09/2021";

  //Bảng khối lượng công việc
  String nameJob = "Lát gạch phòng ngủ 600*600";
  String ruleJob = "Dùng keo, gạch thạch bàn mã TB123";
  String mass = "20";
  String unit = "m2";

  List<Map<String, String>> bangKhoiLuongCongViecs = [];
  List<String> urlHinhAnhKhoiLuongList = [];
  List<String> urlHinhAnhBangVeList = [];

  String idDonDichVu = "";

  // file
  String fileName = "không có";

  @override
  void onInit() {
    super.onInit();

    idDonDichVu = Get.arguments as String;

    // get don dich vu
    getDonDichVu(idDonDichVu);

    // get bao gia
    getBaoGia(idDonDichVu);
  }

  ///
  /// get data don dich vu
  ///
  void getDonDichVu(String idDonDichVu) {
    donDichVuProvider.find(
      id: idDonDichVu.trim(),
      onSuccess: (model) {
        // set adress
        address = "";
        if (model.idQuanHuyen != null) {
          address += model.idQuanHuyen!.ten!;
        }

        if (model.idQuanHuyen != null) {
          address += model.idQuanHuyen!.ten!;
        }

        // set title
        title = model.tieuDe!;

        // set start time
        startTime = formatDate(model.ngayBatDau!);

        // set end time
        endTime = formatDate(model.ngayKetThuc!);
        description = model.moTaChiTiet ?? model.moTa!;

        // xử lý trường dữ liệu image
        for (final image in model.hinhAnhBanKhoiLuongs!) {
          if (image.toString().trim().isNotEmpty) {
            urlHinhAnhKhoiLuongList.add(image.toString());
          }
        }

        // Load hình ảnh bảng vẽ
        for (final banVe in model.hinhAnhBanVes!) {
          if (banVe.trim().isNotEmpty) {
            urlHinhAnhBangVeList.add(banVe);
          }
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// get bao gia
  ///
  void getBaoGia(String id) {
    // load danh sách báo giá đơn dịch vụ
    danhSachBaoGiaDonDichVuProvider.paginate(
      page: 1,
      limit: 30,
      filter: "&idDonDichVu=${id.trim()}",
      onSuccess: (models) {
        if (models.isNotEmpty) {
          fileName = models[0].file ?? "";
        }
        for (final element in models) {
          // Load hình ảnh báo giá
          donDichVuProvider.find(
            id: id,
            onSuccess: (data) {
              urlHinhAnhKhoiLuongList = data.hinhAnhBanKhoiLuongs!;
              urlHinhAnhBangVeList = data.hinhAnhBanVes!;

              // Load các thông tin về vật tư
              chiTietVatTuProvider.paginate(
                page: 1,
                limit: 50,
                filter: "&idDonDichVu=${element.idDonDichVu!.id.toString()}",
                onSuccess: (vatTuList) {
                  // duyệt vật tư liên quan với id đơn dịch vụ
                  for (final vatTu in vatTuList) {
                    vatTuProvider.find(
                      id: vatTu.id.toString(),
                      onSuccess: (_vatTu) {
                        bangKhoiLuongCongViecs.add({
                          "tencongviec": data.tieuDe.toString(),
                          "quycach": _vatTu.quyCach.toString(),
                          "unit": _vatTu.donVi.toString(),
                        });
                        update();
                      },
                      onError: (error) {
                        print(
                          "TermsAndPolicyController getTermsAndPolicy onError $error",
                        );
                      },
                    );
                  }
                  isLoading = false;
                  update();
                },
                onError: (error) {
                  print(
                    "TermsAndPolicyController getTermsAndPolicy onError $error",
                  );
                },
              );
              update();
            },
            onError: (error) {
              print(
                  "V2DetailWorkInProgressController getBaoGia onError $error");
            },
          );
        }
        update();
      },
      onError: (error) {
        print("TermsAndPolicyController getTermsAndPolicy onError $error");
      },
    );
  }

  ///
  /// get file khoi luong
  ///

  ///
  /// format date
  ///
  String formatDate(String date) {
    return DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
  }
}
