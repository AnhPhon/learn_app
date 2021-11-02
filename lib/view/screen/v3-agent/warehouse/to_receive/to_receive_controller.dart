import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/kho_hang_dai_ly_request.dart';
import 'package:template/data/model/request/nhap_kho_hang_dai_ly_request.dart';
import 'package:template/data/model/response/kho_hang_dai_ly_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/kho_hang_dai_ly_provider.dart';
import 'package:template/provider/nhap_kho_hang_dai_ly_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';

class V3ToReceiveController extends GetxController {
  //TextEditingController
  final stockController = TextEditingController();

  //SanPham
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  SanPhamResponse? sanPhamResponse;
  List<SanPhamResponse> sanPhamList = [];

  //khoHangDaiLy
  KhoHangDaiLyProvider khoHangDaiLyProvider = GetIt.I.get();
  List<KhoHangDaiLyResponse> khoHangDaiLyList = [];
  KhoHangDaiLyResponse? khoHangDaiLyResponse;

  //nhap kho dai ly
  NhapKhoHangDaiLyProvider nhapKhoHangDaiLyProvider =
      GetIt.I.get<NhapKhoHangDaiLyProvider>();
  NhapKhoHangDaiLyRequest nhapKhoHangDaiLyRequest = NhapKhoHangDaiLyRequest();

  //userId
  String userId = "";

  //title appbar
  String title = "Nhập kho đại lý";

  @override
  void onInit() {
    super.onInit();
    getUserId().then((value) {
      getSanPham();
      getKhoHang();
    });
  }

  @override
  void onClose() {
    stockController.dispose();
    super.onClose();
  }

  ///
  ///get user id
  ///
  Future<void> getUserId() async {
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;
  }

  ///
  ///get san pham
  ///
  void getSanPham() {
    sanPhamProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (data) {
        //check is not empty
        if (data.isNotEmpty) {
          sanPhamList = data;
        }
        update();
      },
      onError: (error) {
        print("V3ToReceiveController getSanPham onError $error");
      },
    );
  }

  ///
  ///get kho hang
  ///
  void getKhoHang() {
    khoHangDaiLyProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idTaiKhoan=$userId&sortBy=created_at:desc",
      onSuccess: (data) {
        //check is not empty
        if (data.isNotEmpty) {
          khoHangDaiLyList = data;
        }
        update();
      },
      onError: (error) {
        print("V3ToReceiveController getSanPham onError $error");
      },
    );
  }

  ///
  ///onchanged khoHangDaiLy
  ///
  void onchangedSanPham(SanPhamResponse? value) {
    sanPhamResponse = value;
    update();
  }

  ///
  ///onchanged khoHangDaiLy
  ///
  void onchangedKhoHangDaiLy(KhoHangDaiLyResponse? value) {
    khoHangDaiLyResponse = value;
    update();
  }

  ///
  ///onchanged tinh trang san pham
  ///
  void onchangedTinhTrangSanPham(String? value) {
    nhapKhoHangDaiLyRequest.tinhTrangSanPham = value;
    update();
  }

  ///
  ///on update click
  ///
  void onUpdateClick() {
    //validate
    if (sanPhamResponse == null) {
      Alert.error(message: "Vui lòng chọn sản phẩm");
    } else if (khoHangDaiLyResponse == null) {
      Alert.error(message: "Vui lòng chọn kho hàng");
    } else if (stockController.text.isEmpty) {
      Alert.error(message: "Trường số lượng không được để trống");
    } else {
      //set data
      nhapKhoHangDaiLyRequest.idKhoHangDaiLy = khoHangDaiLyResponse!.id;
      nhapKhoHangDaiLyRequest.idSanPham = sanPhamResponse!.id;
      nhapKhoHangDaiLyRequest.soLuong = stockController.text;
      nhapKhoHangDaiLyRequest.idTaiKhoan = userId;
      // nhapKhoHangDaiLyRequest.loai = "1";

      //nhap kho
      nhapKhoHangDaiLyProvider.add(
        data: nhapKhoHangDaiLyRequest,
        onSuccess: (data) {
          Get.back(result: true);
          Alert.success(message: "Nhập kho sản phẩm thành công");
        },
        onError: (error) {
          print("V3ToReceiveController onUpdateClick onError $error");
        },
      );
    }
  }
}
