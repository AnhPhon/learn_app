import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/view/screen/v2-builder/finish_update/finish_update_page.dart';


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
        "onTap": () {}
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
        "onTap": () {}
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
          Get.toNamed(AppRoutes.V2_CANDIDATE_RECRUITMENT);
        }
      },
    ];
  }

  ///
  ///go to shorthanded page
  ///
  void onShortHandedPageClick() {
  }

  ///
  ///go to product page
  ///
  void onProductPageClick() {
    Get.toNamed(AppRoutes.V2_PRODUCT);
  }

  void onNeedUpdateClick() {
    Get.to(V2FinishUpdatePage());
  }
}
