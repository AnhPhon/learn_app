import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/chi_tiet_don_hang_request.dart';
import 'package:template/data/model/request/don_hang_request.dart';
import 'package:template/data/model/response/chi_tiet_don_hang_response.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/provider/chi_tiet_don_hang_provider.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/app_routes.dart';

class V1CartController extends GetxController {
  //donHang
  DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();
  DonHangRequest donHangRequest = DonHangRequest();
  DonHangResponse? donHangResponse;

  //ChiTietDonHang
  ChiTietDonHangProvider chiTietDonHangProvider =
      GetIt.I.get<ChiTietDonHangProvider>();
  ChiTietDonHangRequest chiTietDonHangRequest = ChiTietDonHangRequest();
  List<ChiTietDonHangResponse> chiTietDonHangList = [];

  //TaiKhoan
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();

  //quality list
  List<int>? qualityList;

  //loading
  bool isReloadAddress = false;

  //total
  double total = 0;
  double totalAmount = 0;

  //user id
  String userId = "";

  //loading
  // bool isLoading = true;

  //title appbar
  String title = "Giỏ hàng";

  @override
  void onInit() {
    super.onInit();
    //get arguments
    chiTietDonHangList =
        Get.arguments['chiTietDonHangList'] as List<ChiTietDonHangResponse>;
    donHangResponse = (Get.arguments['donHang'] != null)
        ? Get.arguments['donHang'] as DonHangResponse
        : null;

    //get quality
    qualityList = List<int>.generate(chiTietDonHangList.length,
        (index) => int.parse(chiTietDonHangList[index].soLuong.toString()));

    //get total
    getTotal();
  }

  ///
  ///get total
  ///
  void getTotal() {
    if (donHangResponse != null && chiTietDonHangList.isNotEmpty) {
      total = 0;
      totalAmount = 0;

      for (var i = 0; i < chiTietDonHangList.length; i++) {
        total = total +
            (qualityList![i].toDouble() *
                double.parse(
                  chiTietDonHangList[i].idSanPham!.gia.toString(),
                ));
      }

      donHangResponse!.phiDichVu = (total * .2).toString();
      totalAmount = total +
          double.parse(donHangResponse!.phiDichVu.toString()) +
          double.parse(donHangResponse!.phiVanChuyen.toString());

      update();
    }
  }

  ///
  ///reload address
  ///
  void reloadAddress() {
    donHangProvider.find(
      id: donHangResponse!.id.toString(),
      onSuccess: (data) {
        donHangResponse = data;
        isReloadAddress = false;
        update();
      },
      onError: (error) {
        print("V1ProductDetailController reloadAddress onError $error");
      },
    );
  }

  ///
  ///update chiTietDonHang
  ///
  void updateChiTietDonHang({required int index, required String quality}) {
    //set data
    chiTietDonHangRequest.id = chiTietDonHangList[index].id;
    chiTietDonHangRequest.soLuong = quality;

    //update chiTietDonHang
    chiTietDonHangProvider.update(
      data: chiTietDonHangRequest,
      onSuccess: (data) {
        print("update số lượng");
      },
      onError: (error) {
        print("V1ProductDetailController donHangAdd onError $error");
      },
    );
  }

  ///
  ///incre quality
  ///
  void increQuality({required int index}) {
    qualityList![index]++;
    getTotal();
    updateChiTietDonHang(index: index, quality: qualityList![index].toString());
    update();
  }

  ///
  ///decre quality
  ///
  void decreQuality({required int index}) {
    if (qualityList![index] > 1) {
      qualityList![index]--;
      getTotal();
      updateChiTietDonHang(
          index: index, quality: qualityList![index].toString());
    } else {
      return;
    }
    update();
  }

  ///
  ///go to shipping method
  ///
  void onSelectShippingMethod() {
    Get.toNamed(AppRoutes.V1_SHIPPING_METHOD);
  }

  ///
  ///go to shipping address
  ///
  void onSelectShippingAddress() {
    Get.toNamed(AppRoutes.V1_SHIPPING_ADDRESS, arguments: donHangResponse)!
        .then((value) {
      if (value == true) {
        isReloadAddress = true;
        reloadAddress();
      }
    });
  }

  ///
  ///go to payment account page
  ///
  void onCheckoutClick() {
    Get.toNamed(
            "${AppRoutes.PAYMENT_ACCOUNT}?tongTien=${total.toStringAsFixed(0)}&url=${AppRoutes.V1_DASHBOARD}")!
        .then((value) {
      //set data
      donHangRequest.id = donHangResponse!.id;
      donHangRequest.idTrangThaiThanhToan = "61604f4cc8e6fa122227e29f";
      donHangRequest.phiDichVu = donHangResponse!.phiDichVu;
      donHangRequest.phiVanChuyen = donHangResponse!.phiVanChuyen;
      donHangRequest.soTien = total.toString();
      donHangRequest.tongTien = totalAmount.toString();
      donHangRequest.idHinhThucThanhToan = (value == true)
          ? "616120008c19c11eb11f862a"
          : "61615180e87a9124404abe82";
      donHangRequest.idTrangThaiDonHang = "6169794b3391622ae920354b";

      //update donHang
      donHangProvider.update(
        data: donHangRequest,
        onSuccess: (data) {
          //success
          Get.offAllNamed(
            AppRoutes.V1_DASHBOARD,
            predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD),
          );
          Get.back();
        },
        onError: (error) {
          print("V1ProductDetailController onCheckoutClick onError $error");
        },
      );
    });
  }

  ///
  ///delete product
  ///
  void deleteProduct({required int index}) {
    chiTietDonHangProvider.delete(
      id: chiTietDonHangList[index].id.toString(),
      onSuccess: (data) {
        chiTietDonHangList.removeAt(index);
        getTotal();
        Get.back();
        update();
      },
      onError: (error) {
        print("V1ProductDetailController deleteProduct onError $error");
      },
    );
  }
}
