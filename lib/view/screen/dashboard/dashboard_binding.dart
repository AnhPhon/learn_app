import 'package:get/get.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:template/view/screen/leaderboard/leaderboard_controller.dart';
import 'package:template/view/screen/posts/posts_controller.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PostsController>(() => PostsController());
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<LeaderBoardController>(() => LeaderBoardController());
  }
}
