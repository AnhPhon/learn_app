import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/response/don_dich_vu_response.dart';
import 'package:template/provider/don_dich_vu_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class V3ThongTinKhachHangController extends GetxController
    with SingleGetTickerProviderMixin {
  String title = "Liện hệ khách hàng";
  List<dynamic> giaVatTus = [];

  String number = "033521521";
  String address = "25 Tôn Đức Thắng";

  String tenKhachHang = "";
  String diaChiKH = "";

  List<Map<String, dynamic>> twoButtons = [];
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  DonDichVuProvider donDichVuProvider = GetIt.I.get<DonDichVuProvider>();
  DonDichVuResponse? donDichVuResponse;

  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    twoButtons = [
      {
        "label": "Trang chủ",
        "onTap": () {
          onTrangChuClick();
        }
      },
      {
        "label": "Liên hệ",
        "onTap": () {
          onLienHeCLick();
        }
      }
    ];

    // get argument
    donDichVuResponse = Get.arguments as DonDichVuResponse;
    loadThongTinKhachHang(donDichVuResponse!);

    update();
  }

  ///
  /// load thong tin khach hang
  ///
  void loadThongTinKhachHang(DonDichVuResponse donDichVu) {
    donDichVuProvider.find(
      id: donDichVu.id!,
      onSuccess: (data) {
        final List<String> diaChi = [];
        if (data.idPhuongXa != null) {
          diaChi.add(data.idPhuongXa!.ten.toString());
        }

        if (data.idQuanHuyen != null) {
          diaChi.add(data.idQuanHuyen!.ten.toString());
        }

        if (data.idTinhTp != null) {
          diaChi.add(data.idTinhTp!.ten.toString());
        }
        address = diaChi.join(", ");
        if (address.trim() == "") address = "Không xác định";
        diaChiKH = data.diaChiCuThe.toString();

        // số điện thoại của tài khoản
        taiKhoanProvider.find(
          id: donDichVu.idTaiKhoan!.id!,
          onSuccess: (data) {
            number = data.soDienThoai.toString();
            tenKhachHang = data.hoTen.toString();
            isLoading = false;
            update();
          },
          onError: (error) {
            print(error);
          },
        );

        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// on Back CLick
  ///
  void onBackCLick() {
    Get.back();
  }

  ///
  /// on Back CLick
  ///
  void onTrangChuClick() {
    Get.back();
    Get.back();
  }

  ///
  /// liên hệ
  ///
  Future<void> onLienHeCLick() async {
    // btnContact(url: "tel: $number");
    await FlutterPhoneDirectCaller.callNumber(number);
  }
}
