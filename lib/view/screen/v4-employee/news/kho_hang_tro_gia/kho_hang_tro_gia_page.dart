import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/home/kho_hang_tro_gia/kho_hang_tro_gia_controller.dart';

class KhoHangTroGiaPage extends GetView<KhoHangTroGiaController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<KhoHangTroGiaController>(
        init: KhoHangTroGiaController(),
        builder: (controller) {
          if (controller.isLoading) {
            return Container(
                color: ColorResources.WHITE,
                child: const Center(child: CircularProgressIndicator()));
          }
          return Scaffold(
            backgroundColor: ColorResources.WHITE,
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios)),
              elevation: 1,
              centerTitle: true,
              backgroundColor: ColorResources.WHITE,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text(
                "Kho hàng trợ giá",
                style: TextStyle(color: ColorResources.BLACK),
              ),

              ///
              ///tabbar
              ///
              bottom: TabBar(
                controller: controller.tabController,
                isScrollable: true,
                indicatorColor: ColorResources.PRIMARY,
                labelColor: ColorResources.PRIMARY,
                unselectedLabelColor: Colors.grey,
                tabs: controller.categoriesList
                    .map((categories) => Tab(text: categories.name))
                    .toList(),
              ),
            ),

            ///
            ///tabbar view
            ///
            body: TabBarView(
              controller: controller.tabController,
              children: [
                ...List.generate(
                  controller.categoriesList.length,
                  (index) => GetBuilder<KhoHangTroGiaController>(
                      init: KhoHangTroGiaController(),
                      builder: (controller) {
                        if (controller.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.72,
                              crossAxisCount: 2,
                            ),
                            itemCount: controller.productWithIdCategList.length,
                            itemBuilder: (BuildContext context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.onProductClick(index);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorResources.WHITE),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 150,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          child: FadeInImage.assetNetwork(
                                            placeholder: Images.placeholder,
                                            image: controller
                                                .productWithIdCategList[index]
                                                .thumbnail!,
                                            fit: BoxFit.fill,
                                            imageErrorBuilder: (c, o, s) =>
                                                Image.asset(
                                              Images.placeholder,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          height: DeviceUtils.getScaledHeight(
                                              context, 0.01)),
                                      SizedBox(
                                        height: DeviceUtils.getScaledSize(
                                            context, 0.101),
                                        child: Text(
                                          controller
                                              .productWithIdCategList[index]
                                              .name!,
                                          maxLines: 2,
                                          style:
                                              Dimensions.fontSizeStyle14w600(),
                                        ),
                                      ),
                                      Text(PriceConverter.convertPrice(
                                          context,
                                          double.parse(controller
                                              .productWithIdCategList[index]
                                              .prices!)))
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                ).toList()
              ],
            ),
          );
        });
  }
}
