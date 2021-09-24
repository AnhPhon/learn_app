import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/body/news_model.dart';
import 'package:template/provider/news_provider.dart';

class NewsDetailController extends GetxController {
  NewsProvider newsProvider = GetIt.I.get<NewsProvider>();

  List<NewsModel> newsDetailList = [];

  List title = ["YouTube's new features,let's take a look"];

  List subtitle = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  ];

  List categories = ["Công nghệ"];

  List time = ["45 phút"];

  void getAllNews() {
    newsProvider.all(onSuccess: (value) {
      newsDetailList = value;
      update();
    }, onError: (error) {
      print(error);
      update();
    });
  }
}
