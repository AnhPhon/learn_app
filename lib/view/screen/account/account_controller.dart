import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/body/region.dart';
import 'package:template/provider/region_provider.dart';
import 'package:template/routes/app_routes.dart';

class AccountController extends GetxController {
  var counter = 1.obs;

  List<Region> regionsList = [];
  bool isLoading = true;

  void onRulesClick() {
    Get.toNamed(AppRoutes.RULES);
  }

  void onOrderClick() {
    Get.toNamed(AppRoutes.ORDER);
  }

  void increaseCounter() {
    RegionProvider().getRegions(onSuccess: (regions) {
      isLoading = false;
      regionsList.clear();
      regionsList.addAll(regions);
      update();
    }, onError: (error) {
      isLoading = false;
      Get.snackbar(
        "Hey i'm a Get SnackBar!", // title
        error.toString(), // message
        icon: const Icon(Icons.error_outline),
        shouldIconPulse: true,
        isDismissible: true,
        duration: const Duration(seconds: 3),
      );
      print(error);
      update();
    });

    // counter.value += 12;
    // // Get.to(PostsPage());
    // Get.snackbar(
    //   "Hey i'm a Get SnackBar!", // title
    //   "It's unbelievable! I'm using SnackBar without context!", // message
    //   icon: Icon(Icons.alarm),
    //   shouldIconPulse: true,
    //   isDismissible: true,
    //   duration: Duration(seconds: 3),
    // );
    // Get.offNamed(AppRoutes.POSTPAGE);
  }
}
