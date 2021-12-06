import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/request/chi_tiet_don_hang_request.dart';
import 'package:template/data/model/request/don_hang_request.dart';
import 'package:template/data/model/response/chi_tiet_don_hang_response.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chi_tiet_don_hang_provider.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/routes/route_path/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/helper/izi_validate.dart';

class CartController extends GetxController {
  //donHang
  DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();
  DonHangRequest donHangRequest = DonHangRequest();
  DonHangResponse? donHangResponse;

  //ChiTietDonHang
  ChiTietDonHangProvider chiTietDonHangProvider =
      GetIt.I.get<ChiTietDonHangProvider>();
  ChiTietDonHangRequest chiTietDonHangRequest = ChiTietDonHangRequest();
  List<ChiTietDonHangResponse> chiTietDonHangList = [];

  //quality list
  // List<int>? qualityList;
  List<TextEditingController> quanlityControllerList = [];

  //loading
  bool isReloadAddress = false;

  //total
  int total = 0;
  int totalAmount = 0;

  //title appbar
  String title = "Giỏ hàng";

  //timer
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    //get arguments
    if (Get.arguments['chiTietDonHangList'] != null) {
      donHangResponse = (Get.arguments['donHang'] != null)
          ? Get.arguments['donHang'] as DonHangResponse
          : null;
      chiTietDonHangList =
          Get.arguments['chiTietDonHangList'] as List<ChiTietDonHangResponse>;

      //get quality
      quanlityControllerList = List<TextEditingController>.generate(
          chiTietDonHangList.length,
          (index) =>
              TextEditingController(text: chiTietDonHangList[index].soLuong));

      //get total
      getTotal(isReloadTotal: false);
    }
  }

  ///
  ///get total
  ///
  void getTotal({required bool isReloadTotal}) {
    //clear data
    total = 0;
    totalAmount = 0;

    //is first
    if (donHangResponse != null &&
        chiTietDonHangList.isNotEmpty &&
        isReloadTotal == false) {
      for (var i = 0; i < chiTietDonHangList.length; i++) {
        total = total + int.parse(chiTietDonHangList[i].donGia.toString());
        if (i == chiTietDonHangList.length - 1) {
          totalAmount =
              total + int.parse(donHangResponse!.phiVanChuyen.toString());
        }
      }

      update();
    }

    //is reload
    if (isReloadTotal) {
      for (var i = 0; i < chiTietDonHangList.length; i++) {
        total = total +
            (int.parse(chiTietDonHangList[i].idSanPham!.gia!) *
                int.parse(quanlityControllerList[i].text));
        if (i == chiTietDonHangList.length - 1) {
          totalAmount =
              total + int.parse(donHangResponse!.phiVanChuyen.toString());
        }
      }
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
        print("ProductDetailController reloadAddress onError $error");
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
    chiTietDonHangRequest.donGia = (int.parse(chiTietDonHangRequest.soLuong!) *
            int.parse(chiTietDonHangList[index].idSanPham!.gia!))
        .toString();

    //update chiTietDonHang
    chiTietDonHangProvider.update(
      data: chiTietDonHangRequest,
      onSuccess: (data) {
        print("update số lượng");
      },
      onError: (error) {
        print("ProductDetailController donHangAdd onError $error");
      },
    );
  }

  ///
  ///incre quality
  ///
  void increQuality({required int index, required int onTap}) {
    //set data
    int quanlity = int.parse(quanlityControllerList[index].text);

    if (onTap == 0) {
      //if onPress
      quanlity++;
      quanlityControllerList[index].text = quanlity.toString();

      //reload data
      getTotal(isReloadTotal: true);
      updateChiTietDonHang(
          index: index, quality: quanlityControllerList[index].text);
    } else if (onTap == 1) {
      //if onLongPress
      timer = Timer.periodic(const Duration(milliseconds: 200), (t) {
        quanlity++;
        quanlityControllerList[index].text = quanlity.toString();

        //reload data
        getTotal(isReloadTotal: true);
        updateChiTietDonHang(
            index: index, quality: quanlityControllerList[index].text);
        update();
      });
    } else if (onTap == 2 || onTap == 3) {
      //cancel
      timer.cancel();
    }
    update();
  }

  ///
  ///decre quality
  ///
  void decreQuality({required int index, required int onTap}) {
    //check quanlity > 1
    if (int.parse(quanlityControllerList[index].text) > 1) {

      //set data
      int quanlity = int.parse(quanlityControllerList[index].text);
      if (onTap == 0) {
        //if onPress
        quanlity--;
        quanlityControllerList[index].text = quanlity.toString();

        //reload data
        getTotal(isReloadTotal: true);
        updateChiTietDonHang(
            index: index, quality: quanlityControllerList[index].text);
      } else if (onTap == 1) {
        //if onLongPress
        timer = Timer.periodic(const Duration(milliseconds: 200), (t) {
          quanlity--;
          if (int.parse(quanlityControllerList[index].text) == 1) {
            timer.cancel();
          }
          quanlityControllerList[index].text = quanlity.toString();

          //reload data
          getTotal(isReloadTotal: true);
          updateChiTietDonHang(
              index: index, quality: quanlityControllerList[index].text);
          update();
        });
      } else if (onTap == 2 || onTap == 3) {
        //cancel
        timer.cancel();
      }
    }
    update();
  }

  ///
  ///go to shipping method
  ///
  void onSelectShippingMethod() {
    Get.toNamed(AppRoutes.SHIPPING_METHOD, arguments: donHangResponse)!.then(
      (value) {
        //reload data
        if (value == true) {
          isReloadAddress = true;
          reloadAddress();
        }
      },
    );
  }

  ///
  ///go to shipping address
  ///
  void onSelectShippingAddress() {
    Get.toNamed(AppRoutes.SHIPPING_ADDRESS, arguments: donHangResponse)!.then(
      (value) {
        //reload data
        if (value == true) {
          isReloadAddress = true;
          reloadAddress();
        }
      },
    );
  }

  ///
  ///go to payment_account page
  ///
  void onCheckoutClick() {
    Get.toNamed(
            "${AppRoutes.ORDER_INFORMATION}?soTien=${total.toStringAsFixed(0)}&tienCoc=0&noiDung=${'Thanh toán đơn hàng: ${(donHangResponse!.maDonHang)!.replaceFirst('D', 'Đ')}'}")!
        .then(
      (value) {
        //check value != null
        if (value != null) {
          //da thanh toan
          if (value['type'] == 1) {
            //set data
            donHangRequest.id = donHangResponse!.id;
            donHangRequest.idTrangThaiThanhToan = DA_THANH_TOAN;
            donHangRequest.phiDichVu = value['phiDichVu'].toString();
            donHangRequest.phiVanChuyen = donHangResponse!.phiVanChuyen;
            donHangRequest.soTien = total.toString();
            donHangRequest.tongTien = value['tongTien'].toString();
            donHangRequest.khuyenMai = value['khuyenMai'].toString();

            //update donHang
            donHangProvider.update(
              data: donHangRequest,
              onSuccess: (data) {
                sl.get<SharedPreferenceHelper>().typeAccount.then((value) {
                  if (value == KHACH_HANG) {
                    //success
                    Get.offAllNamed(
                      AppRoutes.V1_DASHBOARD,
                      predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD),
                    );
                    // final V1HomeController v1HomeController = Get.find();
                    // v1HomeController.getDonHang();
                  } else {
                    //success
                    Get.offAllNamed(
                      AppRoutes.V2_DASHBOARD,
                      predicate: ModalRoute.withName(AppRoutes.V2_DASHBOARD),
                    );
                    // final V2HomeController v2HomeController = Get.find();
                    // v2HomeController.getDonHang();
                  }
                  Get.back();
                });
              },
              onError: (error) {
                print("ProductDetailController onCheckoutClick onError $error");
              },
            );
          } else {
            //chua thanh toan
            sl.get<SharedPreferenceHelper>().typeAccount.then((value) {
              if (value == KHACH_HANG) {
                //success
                Get.offAllNamed(
                  AppRoutes.V1_DASHBOARD,
                  predicate: ModalRoute.withName(AppRoutes.V1_DASHBOARD),
                );
                // final V1HomeController v1HomeController = Get.find();
                // v1HomeController.getDonHang();
              } else {
                //success
                Get.offAllNamed(
                  AppRoutes.V2_DASHBOARD,
                  predicate: ModalRoute.withName(AppRoutes.V2_DASHBOARD),
                );
                // final V2HomeController v2HomeController = Get.find();
                // v2HomeController.getDonHang();
              }
              IZIAlert.info(
                  message:
                      "Vui lòng đợi xét duyệt nạp tiền và thanh toán lại sau!");
              Get.back();
            });
          }
        }
      },
    );
  }

  ///
  ///delete product
  ///
  void deleteProduct({required int index}) {
    chiTietDonHangProvider.delete(
      id: chiTietDonHangList[index].id.toString(),
      onSuccess: (data) {
        //reload data
        chiTietDonHangList.removeAt(index);
        getTotal(isReloadTotal: false);
        Get.back();
        update();
      },
      onError: (error) {
        print("ProductDetailController deleteProduct onError $error");
      },
    );
  }

  void onChanged(BuildContext context, int index,
      {String? quanlity, bool? isUpdate}) {
    //is change focus
    if (isUpdate != null &&
        isUpdate == true &&
        Validate.nullOrEmpty(quanlityControllerList[index].text) ==
            false) {
      getTotal(isReloadTotal: true);
      updateChiTietDonHang(
          index: index, quality: quanlityControllerList[index].text);
    }

    //is request
    if (quanlity != null && Validate.nullOrEmpty(quanlity) == false) {
      getTotal(isReloadTotal: true);
      updateChiTietDonHang(index: index, quality: quanlity);
    }
  }
}
