import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V2HomeController extends GetxController {
  String fullname = "Nguyễn Văn A";

  List<Map<String, dynamic>>? contentGrid;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    // declare content grid
    contentGrid = [
      {
        "label": "Đăng ký việc",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffE7C550),
            Color(0xffBE8542),
          ],
        ),
        "icon": Icons.add_circle,
        "onTap": () {
          Get.toNamed(AppRoutes.V2_WORK_REGISTER);
        }
      },
      {
        "label": "Quản lý công việc",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xff97DBAE),
            Color(0xff3FA963),
          ],
        ),
        "icon": Icons.checklist_rtl_sharp,
        "onTap": () {
          onClickJobManagement();
        }
      },
      {
        "label": "Tin tuyển dụng",
        "gradient": const RadialGradient(
          radius: 1,
          colors: [
            Color(0xffF1E1A6),
            Color(0xffCEBB76),
          ],
        ),
        "icon": Icons.pending_actions,
        "onTap": () {
          onClickRecruitment();
        }
      },
    ];
  }

  ///
  ///go to shorthanded page
  ///
  void onShortHandedPageClick() {
    Get.toNamed(AppRoutes.V2_SHORTHANDED);
  }

  ///
  ///go to product page
  ///
  void onProductPageClick() {
    Get.toNamed(AppRoutes.V2_PRODUCT);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickHotNews() {
    Get.toNamed(AppRoutes.V2_NEWS);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickJobManagement() {
    Get.toNamed(AppRoutes.V2_JOB_MANAGEMENT);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickRecruitment() {
    Get.toNamed(AppRoutes.V2_CANDIDATE_RECRUITMENT);
  }

  ///
  /// Nhấn nút xem thêm tin nóng
  ///
  void onClickRegisterJob() {
    // Đăng ký viẹc mới
  }

  // on Need Update Click
  void onNeedUpdateClick() {
    
  }
}
