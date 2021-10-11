import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';
import 'package:template/utils/images.dart';

class V2ProductDetailController extends GetxController {
  String title = "Chi tiết sản phẩm";

  String imgProduct = Images.newsTemplate;

  String productSpecification =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Feugiat pretium nibh ipsum consequat nisl vel pretium lectus quam. Auctor elit sed vulputate mi sit amet mauris. Duis tristique sollicitudin nibh sit amet commodo. Adipiscing enim eu turpis egestas pretium aenean pharetra magna ac. Risus nullam eget felis eget nunc lobortis mattis. Placerat vestibulum lectus mauris ultrices eros in cursus. Sit amet risus nullam eget. Malesuada proin libero nunc consequat interdum. In aliquam sem fringilla ut morbi tincidunt augue. A diam sollicitudin tempor id. Interdum consectetur libero id faucibus nisl.\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Feugiat pretium nibh ipsum consequat nisl vel pretium lectus quam. Auctor elit sed vulputate mi sit amet mauris. Duis tristique sollicitudin nibh sit amet commodo. Adipiscing enim eu turpis egestas pretium aenean pharetra magna ac. Risus nullam eget felis eget nunc lobortis mattis. Placerat vestibulum lectus mauris ultrices eros in cursus. Sit amet risus nullam eget. Malesuada proin libero nunc consequat interdum. In aliquam sem fringilla ut morbi tincidunt augue. A diam sollicitudin tempor id. Interdum consectetur libero id faucibus nisl.\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Feugiat pretium nibh ipsum consequat nisl vel pretium lectus quam. Auctor elit sed vulputate mi sit amet mauris. Duis tristique sollicitudin nibh sit amet commodo. Adipiscing enim eu turpis egestas pretium aenean pharetra magna ac. Risus nullam eget felis eget nunc lobortis mattis. Placerat vestibulum lectus mauris ultrices eros in cursus. Sit amet risus nullam eget. Malesuada proin libero nunc consequat interdum. In aliquam sem fringilla ut morbi tincidunt augue. A diam sollicitudin tempor id. Interdum consectetur libero id faucibus nisl.";

  bool isLoadingMore = false;

  ///
  /// show more
  ///
  void loadingMore() {
    isLoadingMore = false;
    update();
  }

  ///
  /// show less
  ///
  void loadingLess() {
    isLoadingMore = true;
    update();
  }

  ///
  ///go to cart page
  ///
  void onCartClick() {
    Get.toNamed(AppRoutes.V2_CART);
  }
}
