import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/device_utils.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/images.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:template/view/screen/home/kho_hang_tro_gia/kho_hang_tro_gia_controller.dart';

class KhoHangTroGiaPage extends GetView<KhoHangTroGiaController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<KhoHangTroGiaController>(
        init: KhoHangTroGiaController(),
        builder: (KhoHangTroGiaController value) {
          return DefaultTabController(
            length: controller.categoriesName.length,
            child: Scaffold(
              backgroundColor: ColorResources.WHITE,
              appBar: AppBar(
                leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios)),
                elevation: 1,
                backgroundColor: ColorResources.WHITE,
                iconTheme: const IconThemeData(color: Colors.black),
                title: const Text(
                  "Kho hàng trợ giá",
                  style: TextStyle(color: ColorResources.BLACK),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  indicatorColor: ColorResources.PRIMARY,
                  labelColor: ColorResources.PRIMARY,
                  unselectedLabelColor: Colors.grey,
                  tabs: [...controller.categoriesName.map((e) => Tab(text: e))],
                ),
              ),
              body: TabBarView(
                children: [
                  ...List.generate(
                    controller.categoriesName.length,
                    (index) => GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.72,
                          crossAxisCount: 2,
                        ),
                        itemCount: controller.nameProduct.length,
                        itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.onProductClick();
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 150,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                          image: AssetImage(Images.sp3),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  SizedBox(
                                      height: DeviceUtils.getScaledHeight(
                                          context, 0.01)),
                                  Text(
                                    controller.nameProduct[index].toString(),
                                    maxLines: 2,
                                    style: Dimensions.fontSizeStyle14w600(),
                                  ),
                                  Text(PriceConverter.convertPrice(
                                      context, 180000))
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }
}
