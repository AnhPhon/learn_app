import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/view/basewidget/button/button_category.dart';
import 'package:template/view/basewidget/card/product_card.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/field_widget.dart';
import 'package:template/view/basewidget/home/home_widget.dart';
import 'package:template/view/basewidget/task_need_worker.dart';
import 'package:template/view/screen/v1-customer/component_customer/item_list_widget.dart';

import 'home_controller.dart';

class V2HomePage extends GetView<V2HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: GetBuilder<V2HomeController>(
        init: V2HomeController(),
        builder: (V2HomeController controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return HomeWidget(
            fullname: "NT, ${controller.fullname}",
            content: Column(
              children: [
                const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                // need update widget
                _needUpdateWidget(),
                const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),

                // category box widget
                _categoryBoxWidget(),

                // box
                _box(),

                // need people widget
                _needPeopleWidget(),

                // san pham widget
                _sanPhamWidget(context),

                // news
                _newsWidget()
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  /// need update widget
  ///
  Widget _needUpdateWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_DEFAULT,
        right: Dimensions.PADDING_SIZE_DEFAULT,
      ),
      child: Container(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [BoxShadow(blurRadius: 4, color: Color(0x1f000000))]),
        child: Row(
          children: [
            const Text(
              'Bạn cần hoàn thiện hồ sơ',
              style: TextStyle(
                color: Color(0xff4D4D4D),
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.FONT_SIZE_SMALL,
              ),
            ),
            const Icon(CupertinoIcons.bell_fill, color: ColorResources.PRIMARY),
            const Spacer(),
            GestureDetector(
              onTap: controller.onNeedUpdateClick,
              child: Container(
                width: 100,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                decoration: const BoxDecoration(
                  color: Color(0xff2196F3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  ),
                ),
                child: const Text(
                  "Cập nhật",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///
  /// category box widget
  ///
  Widget _categoryBoxWidget() {
    return SizedBox(
      height: 130,
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 100,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.contentGrid!.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: controller.contentGrid![index]["onTap"] as Function(),
            child: BtnCategory(
              label: controller.contentGrid![index]["label"].toString(),
              gradient:
                  controller.contentGrid![index]["gradient"] as RadialGradient,
              icon: controller.contentGrid![index]["icon"] as IconData,
            ),
          );
        },
      ),
    );
  }

  ///
  /// box
  ///
  Widget _box() {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: const BoxDecoration(
            color: Color(0xff2196F3),
            borderRadius: BorderRadius.all(
                Radius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL)),
          ),
          child: Row(
            children: const [
              SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.work,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Text(
                'Kết quả báo giá',
                style: TextStyle(
                    color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// field widget
  ///
  Widget fieldWidget(String title, Function() onTap, Widget widget) {
    const double _fontSize = Dimensions.FONT_SIZE_LARGE;
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _fontSize,
                  color: Color(0xff040404),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onTap,
                child: Row(
                  children: const [
                    Text(
                      "Xem thêm",
                      style: TextStyle(
                        color: Color(0xff2196f3),
                        fontSize: _fontSize,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xff2196f3),
                      size: _fontSize,
                    ),
                  ],
                ),
              )
            ],
          ),
          widget
        ],
      ),
    );
  }

  ///
  /// need people widget
  ///
  Widget _needPeopleWidget() {
    final int length = controller.donDichVuList.length > 2
        ? 2
        : controller.donDichVuList.length;
    final double len = length * 1.0;
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: FieldWidget(
        onTap: () => controller.onShortHandedPageClick(),
        title: "Công việc đang cần người",
        widget: SizedBox(
          height: (len > 0) ? 140 * len : 0,
          child: ListView.builder(
            itemCount: length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext ctx, index) {
              return TaskNeedWorker(
                nhanTask: controller.donDichVuList[index].taiKhoanNhanDon!,
                tenTask: controller.donDichVuList[index].tieuDe!,
                maTask:
                    "DH ${controller.donDichVuList[index].id!.substring(0, 6)}",
                trangThai:
                    controller.donDichVuList[index].idTrangThaiDonHang!.tieuDe!,
                imageURL: controller.donDichVuList[index].hinhAnhBanVe,
              );
            },
          ),
        ),
      ),
    );
  }

  ///
  /// _sanPhamWidget
  ///
  Widget _sanPhamWidget(BuildContext context) {
    final int length =
        controller.sanPhamList.length > 2 ? 2 : controller.sanPhamList.length;
    final double len = length * 1.0;
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: FieldWidget(
        onTap: () {
          //Sản phẩm
          Get.toNamed(AppRoutes.V2_PRODUCT);
        },
        title: "Sản phẩm",
        widget: SizedBox(
          height: 280,
          child: GridView.builder(
            padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 280,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  controller
                      .onClickProductDetail(controller.sanPhamList[index].id!);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                    ),
                  ),
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: ProductCard(
                    title: controller.sanPhamList[index].ten!,
                    image: controller.sanPhamList[index].hinhAnhSanPham!,
                    cost: PriceConverter.convertPrice(context, 100000),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  ///
  /// news widget
  ///
  Widget _newsWidget() {
    final int length =
        controller.tinTucList.length > 2 ? 2 : controller.tinTucList.length;
    final double len = length * 1.0;
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: FieldWidget(
        title: "Tin tức",
        onTap: () {
          controller.onClickHotNews();
        },
        widget: SizedBox(
          height: 140 * len + 50,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: length,
            itemBuilder: (
              BuildContext ctx,
              index,
            ) {
              return Padding(
                padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: ItemListWidget(
                  onTap: () {
                    controller
                        .onClickHotNewsDetail(controller.tinTucList[index].id!);
                  },
                  title: "Biệt thự 170 Nguyễn Đình Thi",
                  icon1: const Icon(Icons.remove_red_eye),
                  rowText1: controller.tinTucList[index].luotXem,
                  colorRowText1: ColorResources.BLACKGREY,
                  icon2: const Icon(Icons.monetization_on_outlined),
                  rowText2: controller.tinTucList[index].createdAt
                      .toString()
                      .substring(0, 10),
                  colorRowText2: ColorResources.BLACKGREY,
                  isStart: true,
                  urlImage: controller.tinTucList[index].hinhAnh!,
                  isSpaceBetween: true,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
