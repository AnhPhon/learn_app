import 'package:get/get.dart';
import 'package:template/view/screen/refer_friends/refer_friend_binding.dart';
import 'package:template/view/screen/refer_friends/refer_friends_page.dart';

class ReferFriendsRouters {
  static const String REFER_FRIENDS = "/refer_friends";
  static List<GetPage> referFriendsList = [
    GetPage(
      name: REFER_FRIENDS,
      page: () => ReferFriendsPage(),
      binding: ReferFriendBinding(),
    ),
  ];
}
