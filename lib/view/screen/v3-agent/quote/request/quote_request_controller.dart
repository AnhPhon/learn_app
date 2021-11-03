import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/danh_sach_bao_gia_don_dich_vu_provider.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';

class V3QuoteRequestController extends GetxController {
  final DanhSachBaoGiaDonDichVuProvider danhSachBaoGiaDonDichVuProvider =
      GetIt.I.get<DanhSachBaoGiaDonDichVuProvider>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();

  String tieuDeBaoGia = "Cần báo giá xi măng";
  String loaiCongTrinh = "Nhà tư";
  String tinhThanh = "TP. HCM";
  String quan = "Quận Gò Vấp";
  String phuong = "Phường 9";
  String diaChiCuThe = "Đường Lê Lợi, P9, Quận Gò Vấp, TP.HCM";

  String from = "25/08/2021";
  String to = "20/09/2021";

  String title = "Yêu cầu báo giá";

  List<List<Map<String, dynamic>>> infoCard = [];

  List<String>? noiDungYeuCau;

  List<Map<String, dynamic>>? features;
  List<String> images = [];

  bool isCheck = true;
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    noiDungYeuCau = [
      "Yêu cầu cát sạch",
      "Xi măng kim đỉnh",
      "Gạch đại hiệp",
    ];

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

    // load thông tin
    sl.get<SharedPreferenceHelper>().idDonDichVu.then((idDonDichVu) {
      loadInfo(idDonDichVu.toString());
      loadVatTu(idDonDichVu.toString());
    });
  }

  ///
  /// load thongo tin don gia dich vu bằng id
  ///
  void loadInfo(String donGiaDichVuId) {
    sl.get<SharedPreferenceHelper>().idYeuCau.then((idYeuCau) {
      danhSachBaoGiaDonDichVuProvider.find(
        id: idYeuCau.toString(),
        onSuccess: (data) {
          images = data.hinhAnhBaoGias!.map((e) => e.toString()).toList();

          donDichVuProvider.find(
            id: data.idDonDichVu!.id.toString(),
            onSuccess: (donDichVu) {
              tieuDeBaoGia = donDichVu.tieuDe.toString();
              loaiCongTrinh = donDichVu.loai.toString();

              if (donDichVu.idTaiKhoanNhanDon != null) {
                if (donDichVu.idTaiKhoanNhanDon!.idTinhTp != null) {
                  tinhThanh =
                      donDichVu.idTaiKhoanNhanDon!.idTinhTp!.ten.toString();
                }

                if (donDichVu.idTaiKhoanNhanDon!.idQuanHuyen != null) {
                  quan =
                      donDichVu.idTaiKhoanNhanDon!.idQuanHuyen!.ten.toString();
                }

                if (donDichVu.idTaiKhoanNhanDon!.idPhuongXa != null) {
                  phuong =
                      donDichVu.idTaiKhoanNhanDon!.idPhuongXa!.ten.toString();
                }
                diaChiCuThe =
                    donDichVu.idTaiKhoanNhanDon!.diaDiemCuThe.toString();
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
          print(images);
          update();
        },
        onError: (error) {
          print("V3QuoteRequestController loadInfo onError $error");
        },
      );
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
  /// on phan hoi
  ///
  void onPhanHoiClick() {
    Get.toNamed(AppRoutes.V3_QUOTE_RESPONSE);
  }
}
