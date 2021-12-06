import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/request/chi_tiet_don_hang_request.dart';
import 'package:template/data/model/request/don_hang_request.dart';
import 'package:template/data/model/response/chi_tiet_don_hang_response.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/data/model/response/nhap_kho_hang_dai_ly_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chi_tiet_don_hang_provider.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/provider/nhap_kho_hang_dai_ly_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/snack_bar.dart';

class ProductDetailController extends GetxController {
  //refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

  //TextEditingController
  TextEditingController quanlityController = TextEditingController(text: '1');

  // initialize scroll controller
  ScrollController? scrollController;

  //TaiKhoan
  TaiKhoanProvider taiKhoanProvider = GetIt.I.get<TaiKhoanProvider>();
  TaiKhoanResponse taiKhoanResponse = TaiKhoanResponse();

  //SanPham
  SanPhamProvider sanPhamProvider = GetIt.I.get<SanPhamProvider>();
  List<SanPhamResponse> sanPhamList = [];
  SanPhamResponse sanPhamResponse = SanPhamResponse();

  //DonHang
  DonHangProvider donHangProvider = GetIt.I.get<DonHangProvider>();
  DonHangResponse? donHangResponse;
  DonHangRequest donHangRequest = DonHangRequest();

  //NhapKhoHangDaiLy
  NhapKhoHangDaiLyProvider nhapKhoHangDaiLyProvider =
      GetIt.I.get<NhapKhoHangDaiLyProvider>();
  List<NhapKhoHangDaiLyResponse> nhapKhoHangDaiLyList = [];
  int stock = 0;

  //ChiTietDonHang
  ChiTietDonHangProvider chiTietDonHangProvider =
      GetIt.I.get<ChiTietDonHangProvider>();
  List<ChiTietDonHangResponse> chiTietDonHangList = [];
  ChiTietDonHangRequest chiTietDonHangRequest = ChiTietDonHangRequest();

  //title appbar
  String title = "Chi tiết sản phẩm";

  //loading
  bool isLoading = true;
  bool isLoadingMore = false;
  bool isLoadingStock = true;

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 6;

  //userId
  String userId = "";

  //timer
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    //binding ScrollController
    scrollController = ScrollController()..addListener(() {});

    //get arguments
    sanPhamResponse = Get.arguments as SanPhamResponse;

    //get load data
    getStock();
    getTaiKhoan().then((value) => getDonHang());
    getMoreProduct(isRefresh: true);
  }

  @override
  void onClose() {
    refreshController.dispose();
    scrollController!.dispose();
    quanlityController.dispose();
    super.onClose();
  }

  ///
  ///get taiKhoan
  ///
  Future<void> getTaiKhoan() async {
    //get user id
    userId = (await sl.get<SharedPreferenceHelper>().userId)!;

    //get TaiKhoan
    taiKhoanProvider.find(
      id: userId,
      onSuccess: (data) {
        taiKhoanResponse = data;
      },
      onError: (error) {
        print("ProductDetailController getTaiKhoan onError $error");
      },
    );
  }

  ///
  ///get donHang
  ///
  void getDonHang() {
    //clear data
    donHangResponse = null;
    chiTietDonHangList.clear();
    update();

    //get Donhang
    donHangProvider.paginate(
      page: 1,
      limit: 10,
      filter:
          "&idTaiKhoanMuaHang=$userId&idTrangThaiDonHang=$TRANG_THAI_DON_HANG_MOI_TAO&idTrangThaiThanhToan=$CHUA_THANH_TOAN&sortBy=created_at:desc",
      onSuccess: (data) {
        if (data.isNotEmpty) {
          donHangResponse = data.first;
          getChiTietDonHang(idDonHang: donHangResponse!.id.toString());
        }
      },
      onError: (error) {
        print("ProductDetailController getDonHang onError $error");
      },
    );
  }

  ///
  ///get ChiTietDonHang
  ///
  void getChiTietDonHang({required String idDonHang}) {
    chiTietDonHangProvider.paginate(
      page: 1,
      limit: 100,
      filter: "&idDonHang=$idDonHang&sortBy=created_at:desc",
      onSuccess: (data) {
        chiTietDonHangList = data;
        update();
      },
      onError: (error) {
        print("ProductDetailController getChiTietDonHang onError $error");
      },
    );
  }

  ///
  ///get stock
  ///
  void getStock() {
    nhapKhoHangDaiLyProvider.paginate(
      page: 1,
      limit: 100,
      filter:
          "&idTaiKhoan=${sanPhamResponse.idTaiKhoan!.id}&idSanPham=${sanPhamResponse.id}",
      onSuccess: (data) {
        //check is not empty
        if (data.isNotEmpty) {
          int nhap = 0;
          int xuat = 0;
          nhapKhoHangDaiLyList = data;
          for (final item in data) {
            if (item.loai == "1") {
              nhap += int.parse(item.soLuong.toString());
            } else if (item.loai == "2") {
              xuat += int.parse(item.soLuong.toString());
            }
            if (item.id == nhapKhoHangDaiLyList.last.id) {
              stock = nhap - xuat;
            }
          }
        }

        isLoadingStock = false;
        update();
      },
      onError: (error) {
        print("ProductDetailController getStock onError $error");
      },
    );
  }

  ///
  ///get more product
  ///
  void getMoreProduct({required bool isRefresh}) {
    //isRefresh
    if (isRefresh) {
      pageMax = 1;
      sanPhamList.clear();
    } else {
      //is load more
      pageMax++;
    }

    //check is not empty
    if (sanPhamResponse.idDanhMucSanPham != null) {
      //load sanPhamList
      sanPhamProvider.paginate(
        page: pageMax,
        limit: limitMax,
        filter:
            "&idDanhMucSanPham=${sanPhamResponse.idDanhMucSanPham!.id}&sortBy=created_at:desc",
        onSuccess: (data) {
          data.removeWhere((element) => element.id == sanPhamResponse.id);
          //check is empty
          if (data.isEmpty) {
            if (isRefresh) {
              refreshController.refreshCompleted();
            } else {
              refreshController.loadNoData();
            }
          } else {
            //isRefresh
            if (isRefresh) {
              sanPhamList = data;
              refreshController.refreshCompleted();
            } else {
              //is load more
              sanPhamList = sanPhamList.toList() + data;
              refreshController.loadComplete();
            }
          }

          isLoading = false;
          update();
        },
        onError: (error) {
          print("ProductDetailController getMoreProduct onError $error");
        },
      );
    } else {
      refreshController.loadFailed();
      isLoading = false;
      update();
    }
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    //isloading
    isLoading = true;

    //reset noData
    refreshController.resetNoData();

    //load sanPham
    getMoreProduct(isRefresh: true);
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    //load sanPham
    getMoreProduct(isRefresh: false);
  }

  ///
  /// show more
  ///
  void loadingMore() {
    isLoadingMore = false;
    update();
  }

  ///
  /// show less
  ///
  void loadingLess() {
    isLoadingMore = true;
    update();
  }

  ///
  /// decrementQuality
  ///
  void decrementQuality({required int onTap}) {
    //check quanlity > 1
    if (int.parse(quanlityController.text) > 1) {
      //set data
      int quanlity = int.parse(quanlityController.text);
      if (onTap == 0) {
        //if onPress
        quanlity--;
        quanlityController.text = quanlity.toString();
      } else if (onTap == 1) {
        //if onLongPress
        timer = Timer.periodic(const Duration(milliseconds: 200), (t) {
          quanlity--;
          quanlityController.text = quanlity.toString();
          if (quanlity == 1) {
            timer.cancel();
          }
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
  /// incrementQuality
  ///
  void incrementQuality({required int onTap}) {
    //set data
    int quanlity = int.parse(quanlityController.text);
    if (onTap == 0) {
      //if onPress
      quanlity++;
      quanlityController.text = quanlity.toString();
    } else if (onTap == 1) {
      //if onLongPress
      timer = Timer.periodic(const Duration(milliseconds: 200), (t) {
        quanlity++;
        quanlityController.text = quanlity.toString();
        update();
      });
    } else if (onTap == 2 || onTap == 3) {
      //cancel
      timer.cancel();
    }
    update();
  }

  ///
  ///on get Product
  ///
  void onGetProduct({required int index}) {
    //back top
    scrollToTop();

    //reload data
    sanPhamResponse = sanPhamList[index];
    getMoreProduct(isRefresh: true);
  }

  ///
  ///scroll to top when click other product
  ///
  void scrollToTop() {
    scrollController!.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  ///
  ///add Product To Cart
  ///
  void addProductToCart(String quanlity) {
    //set data
    chiTietDonHangRequest.idSanPham = sanPhamResponse.id;
    chiTietDonHangRequest.soLuong = quanlity;

    //check is not empty
    if (donHangResponse != null) {
      final index = chiTietDonHangList
          .indexWhere((element) => element.idSanPham!.id == sanPhamResponse.id);
      chiTietDonHangRequest.idDonHang = donHangResponse!.id;

      //already exits
      if (index != -1) {
        //set data
        chiTietDonHangRequest.soLuong =
            (int.parse(chiTietDonHangList[index].soLuong.toString()) +
                    int.parse(quanlity))
                .toString();
        chiTietDonHangRequest.id = chiTietDonHangList[
                chiTietDonHangList.indexWhere(
                    (element) => element.idSanPham!.id == sanPhamResponse.id)]
            .id;
        chiTietDonHangRequest.donGia =
            (int.parse(chiTietDonHangRequest.soLuong!) *
                    int.parse(sanPhamResponse.gia!))
                .toString();

        //update chiTietDonHang
        chiTietDonHangProvider.update(
          data: chiTietDonHangRequest,
          onSuccess: (chiTietDonHangUpdate) {
            //reload cart btn
            getDonHang();

            //show snackbar
            SnackBarUtils.showSnackBarSuccess(
              title: "Thành công",
              message: "Thêm sản phẩm vào giỏ hàng thành công",
            );
          },
          onError: (error) {
            print(
                "ProductDetailController chiTietDonHangUpdate onError $error");
          },
        );
      } else {
        //set data
        chiTietDonHangRequest.donGia =
            (int.parse(chiTietDonHangRequest.soLuong!) *
                    int.parse(sanPhamResponse.gia!))
                .toString();

        //create new chiTietDonHang
        chiTietDonHangProvider.add(
          data: chiTietDonHangRequest,
          onSuccess: (chiTietDonHangAdd) {
            //reload cart btn
            getDonHang();

            //show snackbar
            SnackBarUtils.showSnackBarSuccess(
              title: "Thành công",
              message: "Thêm sản phẩm vào giỏ hàng thành công",
            );
          },
          onError: (error) {
            print("ProductDetailController chiTietDonHangAdd onError $error");
          },
        );
      }
    } else {
      //set data
      donHangRequest.idTrangThaiDonHang = TRANG_THAI_DON_HANG_MOI_TAO;
      // donHangRequest.idHinhThucThanhToan = THANH_TOAN_CHUYEN_KHOAN;
      donHangRequest.idTrangThaiThanhToan = CHUA_THANH_TOAN;
      donHangRequest.diaChi = taiKhoanResponse.diaChi;
      if (taiKhoanResponse.idPhuongXa != null) {
        donHangRequest.idPhuongXa = taiKhoanResponse.idPhuongXa!.id;
      } else {
        donHangRequest.idPhuongXa = null;
      }
      donHangRequest.idQuanHuyen = taiKhoanResponse.idQuanHuyen!.id;
      donHangRequest.idTinhTp = taiKhoanResponse.idTinhTp!.id;
      donHangRequest.idTaiKhoanMuaHang = userId;
      donHangRequest.loaiVanChuyen = "1";
      donHangRequest.isUpdateDonHang = "1";
      donHangRequest.soTien = "0";
      donHangRequest.tongTien = "0";
      donHangRequest.phiDichVu = "0";
      donHangRequest.phiVanChuyen = "0";

      //create new DonHang
      donHangProvider.add(
        data: donHangRequest,
        onSuccess: (donHangAdd) {
          //set data
          chiTietDonHangRequest.idDonHang = donHangAdd.id;
          chiTietDonHangRequest.donGia =
              (int.parse(chiTietDonHangRequest.soLuong!) *
                      int.parse(sanPhamResponse.gia!))
                  .toString();

          //create new chiTietDonHang
          chiTietDonHangProvider.add(
            data: chiTietDonHangRequest,
            onSuccess: (chiTietDonHangAdd) {
              //reload cart btn
              getDonHang();

              //show snackbar
              Alert.success(message: 'Thêm sản phẩm vào giỏ hàng thành công');
            },
            onError: (error) {
              print("ProductDetailController chiTietDonHangAdd onError $error");
            },
          );
        },
        onError: (error) {
          print("ProductDetailController donHangAdd onError $error");
        },
      );
    }
  }

  ///
  ///go to cart page
  ///
  void onCartClick() {
    final Map<String, dynamic> donHang = {
      "donHang": donHangResponse,
      "chiTietDonHangList": chiTietDonHangList,
    };
    Get.toNamed(AppRoutes.CART, arguments: donHang)!.then(
      (value) {
        //reload data
        if (value == true && donHangResponse != null) {
          getChiTietDonHang(idDonHang: donHangResponse!.id.toString());
        }
      },
    );
  }
}