import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V3HomeController extends GetxController {
  String fullname = "Nguyễn Văn A";
  List<Map<String, dynamic>>? threeFeatures;
  List<TinTucResponse> tinTucList = [];
  List<SanPhamResponse> sanPhamList = [];

  int number = 0;

  // khai báo is loading
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    sl.get<SharedPreferenceHelper>().userId.then((id) {
      // tìm kiếm tài khoản theo id user được login
      taiKhoanProvider.find(
        id: id!,
        onSuccess: (taiKhoanResponse) {
          // set lại full name theo tài khoản
          fullname = taiKhoanResponse.hoTen!;

          // read tin tuc
          _readTinTuc();

          // read Kho san Pham
          _readKhosanPham();

          // binding three feature
          _bindingThreeFeature();
        },
        onError: (error) {
          print(error);
        },
      );
    });
  }

  ///
  /// read tin tuc
  ///
  void _readTinTuc() {
    _tinTucProvider.paginate(
      page: 1,
      limit: 2,
      filter: "&sortBy=create_at:desc",
      onSuccess: (tinTucResponses) {
        // get tin tuc list
        tinTucList = tinTucResponses;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// read kho san pham
  ///
  void _readKhosanPham() {
    _sanPhamProvider.paginate(
      page: 1,
      limit: 2,
      filter: "&sortBy=create_at:desc",
      onSuccess: (sanPhamModels) {
        // get san pham list
        sanPhamList = sanPhamModels;

        // set is loading
        isLoading = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// binding three feature
  ///
  void _bindingThreeFeature() {
    threeFeatures = [
      {
        "icon": Icons.shop,
        "label": "Cửa hàng \ncủa bạn",
        "image": null,
        "gradient": const RadialGradient(colors: [
          Color(0xff8CE3E9),
          Color(0xff8CE3E9),
        ]),
        "onTap": () {
          onClickStore();
        }
      },
      {
        "icon": Icons.chat,
        "label": "Phản hồi \nbáo giá",
        "image": null,
        "gradient": const RadialGradient(colors: [
          Color(0xffC1E6EE),
          Color(0xffC1E6EE),
        ]),
        "onTap": () {
          onClickQuoteReponse();
        }
      },
      {
        "icon": Icons.request_page,
        "label": "Yêu cầu \nbáo giá",
        "image": null,
        "gradient": const RadialGradient(colors: [
          Color(0xff79B4B8),
          Color(0xff79B4B8),
        ]),
        "onTap": () {
          onClickQuoteRequest();
        }
      },
    ];
  }

  ///
  /// on Click News
  ///
  void onClickNews() {
    Get.toNamed(AppRoutes.V3_NEWS);
  }

  ///
  /// Tơi màn hình quản lý sản phẩm
  ///
  void onClickWareHouse() {
    Get.toNamed(AppRoutes.V3_WAREHOUSE);
  }

  ///
  /// yeu cầu báo giá
  ///
  void onClickQuoteRequest() {
    Get.toNamed(AppRoutes.V3_QUOTE_LIST);
  }

  ///
  /// Phản hòi báo giá
  ///
  void onClickQuoteReponse() {
    Get.toNamed(AppRoutes.V3_PHAN_HOI_BAO_GIA);
  }

  ///
  /// Cửa hàng
  ///
  void onClickStore() {
    Get.toNamed(AppRoutes.V3_STORE);
  }

  ///
  /// on Need Update Click
  ///
  void onNeedUpdateClick() {
    Get.toNamed(AppRoutes.V3_FINISH_UPDATE);
  }
}
