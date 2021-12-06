import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/date_converter.dart';
import 'package:template/helper/price_converter.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/dimensions.dart';
import 'package:template/utils/validate.dart';
import 'package:template/view/basewidget/button/button_category.dart';
import 'package:template/view/basewidget/card/product_card.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/field_widget.dart';
import 'package:template/view/basewidget/home/home_widget.dart';
import 'package:template/view/basewidget/task_need_worker.dart';
import 'package:template/view/screen/v2-builder/dashboard/dashboard_controller.dart';

import 'home_controller.dart';

// ignore: must_be_immutable
class V2HomePage extends GetView<V2HomeController> {
  V2DashboardController? v2DashboardController;

  V2HomePage({this.v2DashboardController});

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
            fullname: "Hi, ${controller.fullname}",
            soThongBao: controller.soThongBao,
            content: SmartRefresher(
              onLoading: controller.onLoading,
              onRefresh: controller.onRefresh,
              controller: controller.refreshController!,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                    // need update widget
                    _needUpdateWidget(),
                    const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                    // category box widget
                    _categoryBoxWidget(),

                    // box
                    ketQuaBaoGiaWidget(),
                    const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                    // need people widget
                    _needPeopleWidget(),
                    const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                    // san pham widget
                    _sanPhamWidget(context),
                    const SizedBox(height: Dimensions.MARGIN_SIZE_DEFAULT),

                    // news
                    _newsWidget(v2DashboardController!)
                  ],
                ),
              ),
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
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20)), boxShadow: [BoxShadow(blurRadius: 4, color: Color(0x1f000000))]),
      child: Row(
        children: [
          Row(
            children: const [
              Text(
                "Bạn cần hoàn thiện hồ sơ",
                style: TextStyle(
                  color: Color(0xff4D4D4D),
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.FONT_SIZE_SMALL,
                ),
              ),
            ],
          ),
          Stack(
            children: [
              const Icon(CupertinoIcons.bell_fill, color: ColorResources.PRIMARY),
              Positioned(
                right: 8,
                top: 5,
                child: Text(
                  controller.number.toString(),
                  style: const TextStyle(
                    color: ColorResources.WHITE,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  ),
                ),
              )
            ],
          ),
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
    );
  }

  ///
  /// category box widget
  ///
  Widget _categoryBoxWidget() {
    return SizedBox(
      height: 110,
      child: GridView.builder(
        padding: EdgeInsets.zero,
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
              label: controller.contentGrid![index]["label"] as List<String>,
              gradient: controller.contentGrid![index]["gradient"] as RadialGradient,
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
  Widget ketQuaBaoGiaWidget() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.V2_SHORTHANDED_RESULT)!.then((value) {
          controller.onRefresh();
        });
      },
      child: Container(
// <<<<<<< HEAD
//         padding: const EdgeInsets.symmetric(
//           vertical: Dimensions.PADDING_SIZE_SMALL,
//           horizontal: Dimensions.PADDING_SIZE_LARGE,
//         ),
// =======
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
// >>>>>>> develop
        decoration: const BoxDecoration(
          color: Color(0xff2196F3),
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.BORDER_RADIUS_EXTRA_SMALL)),
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
              style: TextStyle(color: Colors.white, fontSize: Dimensions.FONT_SIZE_LARGE),
            )
          ],
        ),
      ),
    );
  }

  ///
  /// field widget
  ///
  Widget fieldWidget(String title, Function() onTap, Widget widget) {
    const double _fontSize = Dimensions.FONT_SIZE_LARGE;
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.MARGIN_SIZE_DEFAULT),
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
// <<<<<<< HEAD
//     final int length = controller.donDichVuList.length > 2 ? 2 : controller.donDichVuList.length;
//     return FieldWidget(
//       onTap: () => controller.onShortHandedPageClick(),
//       title: "CÔNG VIỆC ĐANG CẦN NGƯỜI",
//       widget: Column(
//         children: List.generate(
//           length,
//           (index) => ItemListWidget(
//             // padding: const EdgeInsets.symmetric(
//             //   vertical: Dimensions.PADDING_SIZE_SMALL,
//             //   horizontal: Dimensions.PADDING_SIZE_LARGE,
//             // ),
//             // scaleHeight: 1.1,
//             textOverImage: true,
//             stringTextOverImage: controller.donDichVuList[index].idTinhTp!.ten,
//             title: controller.donDichVuList[index].tieuDe.toString(),
//             rowText1: "DH${controller.donDichVuList[index].id!.substring(0, 6)}",
//             rowText2: controller.donDichVuList[index].idTrangThaiDonDichVu!.tieuDe,
//             icon2: const Icon(
//               Icons.person_search,
//             ),
//             onTap: () => controller.onShortHandedPageClickItem(controller.donDichVuList[index]),
//             isSpaceBetween: true,
//             urlImage: controller.donDichVuList[index].idNhomDichVu!.hinhAnhDaiDien,
//           ),
// =======
    const double _fontSize = Dimensions.FONT_SIZE_LARGE;
    final int length = controller.donDichVuList.length > 2 ? 2 : controller.donDichVuList.length;
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "CÔNG VIỆC ĐANG CẦN NGƯỜI",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: _fontSize,
                color: Color(0xff040404),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => controller.onShortHandedPageClick(),
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
// >>>>>>> develop
        ),
        const SizedBox(height: Dimensions.MARGIN_SIZE_SMALL),
        Column(
          children: List.generate(
            length,
            (index) => ItemListWidget(
              textOverImage: true,
              stringTextOverImage: controller.donDichVuList[index].idTinhTp!.ten,
              title: controller.donDichVuList[index].tieuDe.toString(),
              rowText1: "DH${controller.donDichVuList[index].id!.substring(0, 6)}",
              rowText2: controller.donDichVuList[index].idTrangThaiDonDichVu!.tieuDe,
              icon2: const Icon(
                Icons.person_search,
              ),
              onTap: () => controller.onShortHandedPageClickItem(controller.donDichVuList[index]),
              isSpaceBetween: true,
              urlImage: controller.donDichVuList[index].idNhomDichVu!.hinhAnhDaiDien,
            ),
          ),
        )
      ],
    );
  }

  ///
  /// _sanPhamWidget
  ///
  Widget _sanPhamWidget(BuildContext context) {
    final int length = controller.sanPhamList.length > 2 ? 2 : controller.sanPhamList.length;
    return FieldWidget(
      onTap: () {
        //Sản phẩm
        Get.toNamed(AppRoutes.PRODUCT);
        // .then((value) => controller.getDonHang());
      },
      title: "SẢN PHẨM",
      widget: SizedBox(
        height: (length > 0) ? 300 : 0,
        child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 300,
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: length,
          itemBuilder: (BuildContext ctx, index) {
            return GestureDetector(
              onTap: () {
                controller.onClickProductDetail(controller.sanPhamList[index]);
              },
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
                child: ProductCard(
                  title: controller.sanPhamList[index].ten!,
                  image: controller.sanPhamList[index].hinhAnhDaiDien != null ? controller.sanPhamList[index].hinhAnhDaiDien.toString() : "",
                  cost: PriceConverter.convertPrice(context, double.parse(controller.sanPhamList[index].gia.toString())),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ///
  /// news widget
  ///
  Widget _newsWidget(V2DashboardController v2DashboardController) {
    final int length = controller.tinTucList.length > 2 ? 2 : controller.tinTucList.length;
    return FieldWidget(
      title: "TIN TỨC",
      onTap: () {
        controller.onClickHotNews(v2DashboardController);
      },
      widget: SizedBox(
        height: ((length > 0) ? 100.0 * length : 0) + 50,
        child: itemList(),
      ),
    );
  }

  ///
  ///item list
  ///
  Widget itemList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(
        left: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      ),
      itemCount: controller.tinTucList.length,
      itemBuilder: (BuildContext ctx, int index) {
        return ItemListWidget(
          onTap: () => controller.onClickHotNewsDetail(controller.tinTucList[index]),
          urlImage: controller.tinTucList[index].hinhAnh.toString(),
          title: controller.tinTucList[index].tieuDe.toString(),
          rowText1: DateConverter.formatDateTime(
            controller.tinTucList[index].createdAt.toString(),
          ),
          icon1: const Icon(
            Icons.calendar_today_outlined,
            color: ColorResources.GREY,
          ),
          colorRowText1: ColorResources.GREY,
          rowText2: controller.tinTucList[index].luotXem.toString(),
          icon2: const Icon(
            Icons.remove_red_eye,
            color: ColorResources.GREY,
          ),
          colorRowText2: ColorResources.GREY,
        );
      },
    );
  }
}
