import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/san_pham_request.dart';
import 'package:template/provider/danh_muc_san_pham_provider.dart';
import 'package:template/routes/app_routes.dart';

class V3ReviewProductController extends GetxController {
  //SanPham
  SanPhamRequest sanPhamRequest = SanPhamRequest();

  //DanhMucSanPham
  DanhMucSanPhamProvider danhMucSanPhamProvider =
      GetIt.I.get<DanhMucSanPhamProvider>();

  //title appbar
  String title = "Thông tin sản phẩm";

  //danhmuc
  String danhMucSanPham = "";

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      sanPhamRequest = Get.arguments as SanPhamRequest;
      getDanhMucSanPham();
    }
  }

  ///
  ///get danh muc san pham
  ///
  void getDanhMucSanPham() {
    danhMucSanPhamProvider.find(
      id: sanPhamRequest.idDanhMucSanPham.toString(),
      onSuccess: (data) {
        danhMucSanPham = data.ten.toString();
        update();
      },
      onError: (error) {
        print("V3ReviewProductController getDanhMucSanPham onError $error");
      },
    );
  }

  ///
  ///on done click
  ///
  void onBtnDoneClick() {
    if (Get.parameters['isUpdateAndAdd'] == "false") {
      Get.offAllNamed(
        AppRoutes.V3_STORE,
        predicate: ModalRoute.withName(AppRoutes.V3_STORE),
      );
      Get.back();
    } else {
      Get.back();
    }
  }
}
