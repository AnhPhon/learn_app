import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/home_routes.dart';
import 'package:template/routes/route_path/transfers_routers.dart';

class TransfersSuccessController extends GetxController {


  ///
  /// go to home Page
  ///
  void onToHomePage(){
    Get.offAllNamed(
      HomeRoutes.DASH_BOARD,
      predicate: ModalRoute.withName(
        HomeRoutes.DASH_BOARD,
      ),
    );
  }

  ///
  /// go to other transfers 
  ///
  void onToOtherTransfersPage(){
    Get.toNamed(TransfersRouters.CONTACT);
    // Get.offAllNamed(
    //   TransfersRouters.CONTACT,
    //   predicate: ModalRoute.withName(
    //     TransfersRouters.CONTACT,
    //   ),
    // );
  }

  @override
  void onClose() {
    super.onClose();
  }
}
