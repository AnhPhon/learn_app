import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/request/chi_tiet_don_hang_request.dart';
import 'package:template/data/model/request/don_hang_request.dart';
import 'package:template/data/model/response/chi_tiet_don_hang_response.dart';
import 'package:template/data/model/response/don_hang_response.dart';
import 'package:template/data/model/response/san_pham_response.dart';
import 'package:template/data/model/response/tai_khoan_response.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/chi_tiet_don_hang_provider.dart';
import 'package:template/provider/don_hang_provider.dart';
import 'package:template/provider/san_pham_provider.dart';
import 'package:template/provider/tai_khoan_provider.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/snack_bar.dart';

class V2ProductDetailController extends GetxController {
  //refresh controller for load more refresh
  RefreshController refreshController = RefreshController();

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

  //page for for load more refresh
  int pageMax = 1;
  int limitMax = 6;

  //quality product
  int quantityProduct = 1;

  //userId
  String userId = "";

  @override
  void onInit() {
    super.onInit();
    //binding ScrollController
    scrollController = ScrollController()..addListener(() {});

    //get arguments
    sanPhamResponse = Get.arguments as SanPhamResponse;

    //get load data
    getTaiKhoan().then((value) => getDonHang());
    getMoreProduct(isRefresh: true);
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
        print("V2ProductDetailController getTaiKhoan onError $error");
      },
    );
  }

  ///
  ///get donHang
  ///
  void getDonHang() {
    //get Donhang
    donHangProvider.paginate(
      page: 1,
      limit: 5,
      filter:
          "&idTaiKhoanMuaHang=$userId&idTrangThaiDonHang=616a39faea30f845b562876d&sortBy=created_at:desc",
      onSuccess: (data) {
        if (data.isNotEmpty) {
          donHangResponse = data.first;
          getChiTietDonHang(idDonHang: donHangResponse!.id.toString());
        }
      },
      onError: (error) {
        print("V2ProductDetailController getDonHang onError $error");
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
        print("V2ProductDetailController getChiTietDonHang onError $error");
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
          refreshController.loadNoData();
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
        print("V2ProductDetailController getMoreProduct onError $error");
      },
    );
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
  void decrementQuality() {
    if (quantityProduct > 1) {
      quantityProduct -= 1;
    }
    update();
  }

  ///
  /// incrementQuality
  ///
  void incrementQuality() {
    quantityProduct += 1;
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
  void addProductToCart() {
    //set data
    chiTietDonHangRequest.idSanPham = sanPhamResponse.id;
    chiTietDonHangRequest.soLuong = quantityProduct.toString();

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
                    int.parse(quantityProduct.toString()))
                .toString();
        chiTietDonHangRequest.id = chiTietDonHangList[
                chiTietDonHangList.indexWhere(
                    (element) => element.idSanPham!.id == sanPhamResponse.id)]
            .id;

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
                "V2ProductDetailController chiTietDonHangUpdate onError $error");
          },
        );
      } else {
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
            print("V2ProductDetailController chiTietDonHangAdd onError $error");
          },
        );
      }
    } else {
      //set data
      donHangRequest.idTrangThaiDonHang = "616a39faea30f845b562876d";
      donHangRequest.idTrangThaiThanhToan = "61615180e87a9124404abe82";
      donHangRequest.diaChi = taiKhoanResponse.diaChi;
      donHangRequest.idPhuongXa = taiKhoanResponse.idPhuongXa!.id;
      donHangRequest.idQuanHuyen = taiKhoanResponse.idQuanHuyen!.id;
      donHangRequest.idTinhTp = taiKhoanResponse.idTinhTp!.id;
      donHangRequest.idTaiKhoanMuaHang = userId;
      donHangRequest.idTaiKhoan = sanPhamResponse.idTaiKhoan!.id;
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
              print(
                  "V2ProductDetailController chiTietDonHangAdd onError $error");
            },
          );
        },
        onError: (error) {
          print("V2ProductDetailController donHangAdd onError $error");
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
    Get.toNamed(AppRoutes.V2_CART, arguments: donHang)!.then(
      (value) {
        if (value == true && donHangResponse != null) {
          getChiTietDonHang(idDonHang: donHangResponse!.id.toString());
        }
      },
    );
  }
}
