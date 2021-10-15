import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';

class V1AccountController extends GetxController {
  String title = "Tài khoản";

  double rating = 0;

  String urlImage =
      "https://upload.wikimedia.org/wikipedia/commons/1/1e/Default-avatar.jpg";

  String name = "username";

  String email = "email@gmail.com";

  

  ///
  ///go to profile page
  ///
  void onProfileClick() {
    Get.toNamed(AppRoutes.V1_PROFILE);
  }

  ///
  ///go to profile page
  ///
  void onPersonalInfoClick() {
    Get.toNamed(AppRoutes.V1_PERSONAL_INFORMATION);
  }

  ///
  ///go to point-based page
  ///
  void onPointBasedPageClick() {
    Get.toNamed(AppRoutes.V1_POINT_BASED);
  }

  ///
  ///go to wallet page
  ///
  void onWalletPageClick() {
    Get.toNamed(AppRoutes.V1_WALLET);
  }

  ///
  ///go to rules page
  ///
  void onRulesPageClick() {
    Get.toNamed(AppRoutes.V1_RULES);
  }

  ///
  ///go to intoduce page
  ///
  void onIntroducePageClick() {
    Get.toNamed(AppRoutes.V1_INTRODUCE);
  }

  ///
  ///go to help page
  ///
  void onHelpPageClick() {
    Get.toNamed(AppRoutes.V1_HELP);
  }

  ///
  ///go to job management page
  ///
  void onJobManagementClick() {
    Get.toNamed(AppRoutes.V1_JOB_MANAGEMENT);
  }

  ///
  ///go to mail page
  ///
  void onMailClick() {
    Get.toNamed(AppRoutes.V1_MAIL);
  }

  ///
  ///go to my order page
  ///
  void onMyOrderClick() {
    Get.toNamed(AppRoutes.V1_MY_ORDER);
  }

  ///
  ///show dialog rating
  ///
  void showDialogRating(BuildContext context) {
    Get.dialog(
      Center(
        child: Container(
          height: DeviceUtils.getScaledHeight(context, .5),
          margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
          ),
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS_SMALL),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Đánh giá",
                  style: TextStyle(
                    fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(Images.logo),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Bạn có thích Five Star System?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Chạm vào ngôi sao để xếp hạng nó trên app Store",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE),
                      ),
                      const SizedBox(
                        height: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                      ),
                      RatingBar.builder(
                        minRating: 1,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: Dimensions.MARGIN_SIZE_LARGE,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Expanded(
                        child: Container(
                          height: DeviceUtils.getScaledHeight(context, .07),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 2,
                                color: ColorResources.GREY,
                              ),
                              right: BorderSide(
                                color: ColorResources.GREY,
                              ),
                            ),
                          ),
                          child: const Align(
                            child: Text("Bỏ qua"),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Expanded(
                        child: Container(
                          height: DeviceUtils.getScaledHeight(context, .07),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 2,
                                color: ColorResources.GREY,
                              ),
                              left: BorderSide(
                                color: ColorResources.GREY,
                              ),
                            ),
                          ),
                          child: const Align(
                            child: Text("Đánh giá"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
