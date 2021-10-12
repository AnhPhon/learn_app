import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/images.dart';

class V1HomeController extends GetxController {
  ///
  /// go to Form Management Page
  ///

  List<Map<String, dynamic>>? threeFeatures;
  List<Map<String, dynamic>>? productList;
  List<Map<String, dynamic>>? contentGrid;

  @override
  void onInit() {
    super.onInit();

    // declare content grid
    contentGrid = [
      {
        "label": "Tạo đơn công việc",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffE7C550),
            Color(0xffBE8542),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_CREATE_WORK);
        }
      },
      {
        "label": "Báo giá VLXD",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xff97DBAE),
            Color(0xff3FA963),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_CREATE_WORK);
        }
      },
      {
        "label": "Dịch vụ thường xuyên",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffF1E1A6),
            Color(0xffCEBB76),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_CREATE_WORK);
        }
      },
      {
        "label": "Quản lý đơn tạo",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffDECFE5),
            Color(0xffA27DBF),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_FORM_MANAGEMENT);
        }
      },
      {
        "label": "Quản lý báo giá",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffC3E5AE),
            Color(0xff73AF4E),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_QUOTE_RESPONSE);
        }
      },
      {
        "label": "Tuyển dụng ứng viên",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffE7C550),
            Color(0xffBE8542),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_CANDICATE);
        }
      },
    ];

    // three features
    threeFeatures = [
      {
        "label": "Ảnh sản\nphẩm mẫu",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffB4DDFD),
            Color(0xffB4DDFD),
          ],
        ),
        "icon": CupertinoIcons.bag_fill,
        "onTap": () {}
      },
      {
        "label": "Quản lý\ncông việc",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffB4DDFD),
            Color(0xffB4DDFD),
          ],
        ),
        "icon": Icons.image,
        "onTap": () {
          Get.toNamed(AppRoutes.V1_JOB_MANAGEMENT);
        }
      },
      {
        "label": "Sản phẩm\nmẫu",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffB4DDFD),
            Color(0xffB4DDFD),
          ],
        ),
        "icon": Icons.image,
        "onTap": () {}
      },
    ];

    // product list
    productList = [
      {
        "title": "Điều hòa",
        "image": Images.V1Product1Home,
      },
      {
        "title": "Bơm nước",
        "image": Images.V1Product2Home,
      },
      {
        "title": "Bếp hồng ngoại",
        "image": Images.V1Product3Home,
      },
      {
        "title": "Kệ chắn bát",
        "image": Images.V1Product4Home,
      },
      {
        "title": "Khây đồ khô",
        "image": Images.V1Product5Home,
      },
      {
        "title": "Kệ son nồi",
        "image": Images.V1Product6Home,
      },
      {
        "title": "Kệ chắn bát",
        "image": Images.V1Product7Home,
      },
      {
        "title": "Khây đồ khô",
        "image": Images.V1Product8Home,
      },
      {
        "title": "Kệ son nồi",
        "image": Images.V1Product9Home,
      },
    ];
  }

  String fullname = "KH, Nguyễn Văn A";
  void onClickFormManagementPage() {
    Get.toNamed(AppRoutes.V1_FORM_MANAGEMENT);
  }

  ///
  /// Tới trang Tạo đơn công việc
  ///
  void onClickCreateWork() {
    Get.toNamed(AppRoutes.V1_CREATE_WORK);
  }

  /// go to Form List Page
  ///
  void onClickFormList() {
    Get.toNamed(AppRoutes.V1_FORM_LIST);
  }

  ///
  /// go to Product Page
  ///
  void onMoreProductList() {
    Get.toNamed(AppRoutes.V1_PRODUCT);
  }

  ///
  /// đến màn hình tuyển dung úng vieen
  ///
  void onClickCandicate() {
    Get.toNamed(AppRoutes.V1_CANDICATE);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickHotNews() {
    Get.toNamed(AppRoutes.V1_NEWS);
  }

  ///
  /// Quản lý công việc
  ///
  void onClickJobManagement() {
    //Get.toNamed(AppRoutes.V1_JOB_MANAGEMENT);
  }
}
