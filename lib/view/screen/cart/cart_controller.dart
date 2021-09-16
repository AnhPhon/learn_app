import 'package:get/get.dart';
import 'package:template/view/screen/posts/posts_page.dart';

class CartController extends GetxController {

  void onBtnHomeClick(){
      Get.to(PostsPage());
  }

}
