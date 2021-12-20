import 'package:get/get.dart';
import 'package:template/view/screen/refer_friends/refer_friends_controller.dart';

class ReferFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferFriendsController>(() => ReferFriendsController());
  }
}
