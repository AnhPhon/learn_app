import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/vat_tu_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class V1ResponseController extends GetxController {
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  VatTuProvider vatTuProvider = GetIt.I.get<VatTuProvider>();

  String title = "Phản hồi đơn giá vật tư";
  String tenDonDichVu = "Cần báo giá vật liệu cát xi măng đá, gạch";
  String ngayBatDau = "";
  String ngayKetThuc = "";

  Map<String, List<Map<String, dynamic>>> infoCard = {};
  List<String> images = [];
  double tongTien = 0;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    infoCard = {};

    // load thong tin don dich vu
    loadThongTinDonDichVU();

    // load thong tin vat tu
    loadThongTinVatTu();
  }

  ///
  /// load thong tin don dich vu
  ///
  void loadThongTinDonDichVU() {
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      donDichVuProvider.find(
        id: workFlowId!,
        onSuccess: (donDichVu) {
          tenDonDichVu = donDichVu.tieuDe!;
          ngayBatDau = DateConverter.isoStringToVNDateOnly(
              donDichVu.ngayBatDau!.replaceAll("T", " "));
          ngayKetThuc = DateConverter.isoStringToFullVNDateOnly(
              donDichVu.ngayKetThuc!.replaceAll("T", " "));

          // xử lý trường dữ liệu image
          for (final image in donDichVu.hinhAnhBanKhoiLuong!.split(',')) {
            if (image.trim().isNotEmpty) {
              images.add(image);
            }
          }

          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
  }

  ///
  /// load thong tin vat tu
  ///
  void loadThongTinVatTu() {
    infoCard = {};
    sl.get<SharedPreferenceHelper>().workFlowId.then((workFlowId) {
      vatTuProvider.paginate(
        page: 1,
        limit: 10,
        filter: "&idDonDichVu=$workFlowId&sortBy=created_by:desc",
        onSuccess: (vatTuList) {
          for (final vatTu in vatTuList) {
            if (infoCard[vatTu.tenVatTu] == null) {
              infoCard[vatTu.tenVatTu!] = [
                {
                  "label": "Tên vật liệu",
                  "value": vatTu.tenVatTu,
                  "input": false,
                },
                {
                  "label": "Quy cách",
                  "value": vatTu.quyCach,
                  "input": false,
                },
                {
                  "label": "Số lượng",
                  "value": "1",
                  "input": false,
                },
                {
                  "label": "Đơn vị",
                  "value": vatTu.donVi,
                  "input": false,
                },
                {
                  "label": "Đơn giá",
                  "value": vatTu.donGia,
                  "input": false,
                },
              ];
            } else {
              infoCard[vatTu.tenVatTu!]![2]["value"] = (int.parse(
                          infoCard[vatTu.tenVatTu!]![2]["value"].toString()) +
                      1)
                  .toString();
            }

            tongTien += double.parse(vatTu.donGia!);
          }
          isLoading = false;
          update();
        },
        onError: (error) {
          print("TermsAndPolicyController getTermsAndPolicy onError $error");
        },
      );
    });
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
}
