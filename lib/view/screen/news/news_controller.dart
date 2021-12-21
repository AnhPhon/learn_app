import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/routes/route_path/news_routers.dart';

class NewsController extends GetxController {
  final RefreshController refreshController = RefreshController();
  final tabBarName = [
    'Phố biển',
    'Hot nhất',
    'Khuyến mãi',
  ];
  final List<Map<String, String>> data = [
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'row1Left': 'Ưu đãi từ Hà Nội Safe Food',
      'row1Right': 'Thứ ba, 20/11',
      'row2Left': 'Khuyến mãi Combo Hỗ Trợ Điều Trị Suy Nhược Cơ Thể',
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'row1Left': 'Ưu đãi từ Hà Nội Safe Food',
      'row1Right': 'Thứ ba, 20/11',
      'row2Left': 'Khuyến mãi Combo Hỗ Trợ Điều Trị Suy Nhược Cơ Thể',
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'row1Left': 'Ưu đãi từ Hà Nội Safe Food',
      'row1Right': 'Thứ ba, 20/11',
      'row2Left': 'Khuyến mãi Combo Hỗ Trợ Điều Trị Suy Nhược Cơ Thể',
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'row1Left': 'Ưu đãi từ Hà Nội Safe Food',
      'row1Right': 'Thứ ba, 20/11',
      'row2Left': 'Khuyến mãi Combo Hỗ Trợ Điều Trị Suy Nhược Cơ Thể',
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'row1Left': 'Ưu đãi từ Hà Nội Safe Food',
      'row1Right': 'Thứ ba, 20/11',
      'row2Left': 'Khuyến mãi Combo Hỗ Trợ Điều Trị Suy Nhược Cơ Thể',
    },
  ];
  final List<Map<String, String>> hot = [
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'row1Left': 'Ưu đãi từ Hà Nội Safe Food',
      'row1Right': 'Thứ ba, 20/11',
      'row2Left': 'Việt nam sắp có vắc xin điều trị Covid',
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'row1Left': 'Ưu đãi từ Hà Nội Safe Food',
      'row1Right': 'Thứ ba, 20/11',
      'row2Left': 'Việt nam sắp có vắc xin điều trị Covid',
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'row1Left': 'Ưu đãi từ Hà Nội Safe Food',
      'row1Right': 'Thứ ba, 20/11',
      'row2Left': 'Việt nam sắp có vắc xin điều trị Covid',
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'row1Left': 'Ưu đãi từ Hà Nội Safe Food',
      'row1Right': 'Thứ ba, 20/11',
      'row2Left': 'Việt nam sắp có vắc xin điều trị Covid',
    },
    {
      'image': "https://i.pinimg.com/474x/90/57/0a/90570addee2645866a597530721f37fd.jpg",
      'row1Left': 'Ưu đãi từ Hà Nội Safe Food',
      'row1Right': 'Thứ ba, 20/11',
      'row2Left': 'Việt nam sắp có vắc xin điều trị Covid',
    },
  ];
  int currentIndexTabBar = 0;

  @override
  void onInit() {}

  ///
  /// on press news card
  ///
  void onTapNewCard() {
    Get.toNamed(
      NewsRouters.NEWS_DETAIL,
    );
  }

  void onLoadMore() {
    Future.delayed(Duration(seconds: 2), () {
      refreshController.loadComplete();
    });
  }

  void onRefresh() {
    Future.delayed(Duration(seconds: 2), () {
      refreshController.resetNoData();
      refreshController.refreshCompleted();
    });
  }

  ///
  /// On change tab bar
  ///
  void onChangeTabBar({required int index}) {
    currentIndexTabBar = index;
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    refreshController.dispose();
    super.onClose();
  }
}
