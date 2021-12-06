import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/helper/device_utils.dart';
import 'package:template/helper/dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/basewidget/button/button_category.dart';
import 'package:template/view/basewidget/component/item_list_widget.dart';
import 'package:template/view/basewidget/drawer/drawer_widget.dart';
import 'package:template/view/basewidget/field_widget.dart';
import 'package:template/view/basewidget/home/home_widget.dart';
import 'package:template/view/screen/v1-customer/dashboard/dashboard_controller.dart';
import 'home_controller.dart';

class V1HomePage extends GetView<V1HomeController> {
  final V1DashboardController? v1dashboardController;

  const V1HomePage({
    this.v1dashboardController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      body: GetBuilder<V1HomeController>(
        init: V1HomeController(),
        builder: (V1HomeController controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return HomeWidget(
            // cart: CartHomePage(
            //   getToNamed: controller.onCartClick,
            //   quanlity: controller.chiTietDonHangList.length,
            // ),
            soThongBao: controller.soThongBao,
            fullname: "KH, ${controller.fullname}",
            content: SmartRefresher(
              controller: controller.refreshController!,
              onRefresh: controller.onRefresh,
              onLoading: controller.onLoading,
              child: ListView(
                children: [
                  // category box widget
                  _categoryBoxWidget(),

                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  // three feature widget
                  _threeFeatureWidget(),
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  // product
                  _productWidget(context, controller),

                  // news widget
                  _newsWidget(controller: controller)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// category box widget
  ///
  Widget _categoryBoxWidget() {
    return SizedBox(
      height: 220,
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 100,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: controller.contentGrid![index]["onTap"] as Function(),
            child: BtnCategory(
              label: controller.contentGrid![index]["label"] as List<String>,
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
  /// three feature widget
  ///
  Widget _threeFeatureWidget() {
    return SizedBox(
      height: 120,
      child: GridView.builder(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: controller.threeFeatures!.length,
          mainAxisExtent: 100,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.threeFeatures!.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: controller.threeFeatures![index]["onTap"] as Function(),
            child: BtnCategory(
              label: controller.threeFeatures![index]["label"] as List<String>,
              gradient: controller.threeFeatures![index]["gradient"]
                  as RadialGradient,
              icon: controller.threeFeatures![index]["icon"] as IconData,
              iconColor: ColorResources.BLACK,
            ),
          );
        },
      ),
    );
  }

  ///
  /// image widget
  ///
  Widget _imageWidget(BuildContext context, String title, String url) {
    return SizedBox(
      width: DeviceUtils.getScaledWidth(context, .28),
      height: 110,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: DeviceUtils.getScaledWidth(context, .28),
              height: 110,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  topRight: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomLeft: Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                  bottomRight:
                      Radius.circular(Dimensions.BORDER_RADIUS_DEFAULT),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  )
                ],
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            top: 110 / 2 - 18 / 2,
            child: Container(
              width: DeviceUtils.getScaledWidth(context, .28),
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromRGBO(42, 53, 71, 1),
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      offset: Offset(2, 0),
                    ),
                    Shadow(
                      color: Colors.white,
                      offset: Offset(0, 2),
                    ),
                    Shadow(
                      color: Colors.white,
                      offset: Offset(0, -2),
                    ),
                    Shadow(
                      color: Colors.white,
                      offset: Offset(-2, 0),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// product widget
  ///
  Widget _productWidget(BuildContext context, V1HomeController controller) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      child: FieldWidget(
        title: "Danh mục sản phẩm".toUpperCase(),
        onTap: () => controller.onMoreProductList(),
        widget: SizedBox(
          height: 370,
          width: DeviceUtils.getScaledWidth(context, 1),
          child: GridView.builder(
            padding:
                const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 120,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.danhMucList.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  controller.onMoreCategoryProduct(index: index);
                },
                child: _imageWidget(
                  context,
                  controller.danhMucList[index].ten!,
                  (controller.danhMucList[index].hinhAnh == null)
                      ? Images.location_example
                      : controller.danhMucList[index].hinhAnh!,
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
  Widget _newsWidget({required V1HomeController controller}) {
    final int size =
        controller.tinTucList.length <= 2 ? controller.tinTucList.length : 2;
    return FieldWidget(
      title: "Tin tức".toUpperCase(),
      onTap: () {
        controller.onClickHotNews(v1dashboardController!);
      },
      widget: SizedBox(
        height: 110 * size * 1.0 + 30,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.tinTucList.length <= 2
              ? controller.tinTucList.length
              : 2,
          padding: EdgeInsets.zero,
          itemBuilder: (
            BuildContext ctx,
            index,
          ) {
            return Column(
              children: [
                ItemListWidget(
                  urlImage: controller.tinTucList[index].hinhAnh.toString(),
                  onTap: () {
                    controller.goToNewPageClick(controller.tinTucList[index]);
                  },
                  title: controller.tinTucList[index].tieuDe.toString(),
                  colorRowText2: ColorResources.GREY,
                  icon1: const Icon(Icons.remove_red_eye_sharp),
                  rowText1: controller.tinTucList[index].luotXem,
                  icon2: const Icon(Icons.calendar_today),
                  rowText2: DateConverter.readMongoToString(
                    controller.tinTucList[index].createdAt!,
                  ),
                  isSpaceBetween: true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
