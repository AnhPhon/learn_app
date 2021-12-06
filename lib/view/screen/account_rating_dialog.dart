import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';

class RatingPage extends StatelessWidget {
  final String linkAndroid;
  final String linkIos;
  const RatingPage({
    Key? key,
    required this.linkAndroid,
    required this.linkIos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(linkAndroid);
    print(linkIos);
    return Center(
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
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
              ),
              Image.asset(Images.logo),
              const SizedBox(
                height: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
              ),
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
                      "Chạm vào ngôi sao để xếp hạng nó trên App Store hoặc Google Play",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SUPER_LARGE),
                    ),
                    const SizedBox(
                      height: Dimensions.MARGIN_SIZE_SMALL,
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
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        alignment: Alignment.center,
                        height: DeviceUtils.getScaledHeight(context, .07),
                        width: double.infinity,
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
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        StoreRedirect.redirect(
                          androidAppId: linkAndroid,
                          iOSAppId: linkIos,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: DeviceUtils.getScaledHeight(context, .07),
                        width: double.infinity,
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
    );
  }
}
