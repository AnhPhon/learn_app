import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/app_routes.dart';

class V1G3OrderQuoteController extends GetxController{
  int currentSelected = 0;
  final ScrollController scrollController = ScrollController();

  //final List<

  int pageMax = 1;
  int currentMax = 15;
  bool reload = false;

  @override
  void onInit() {
    super.onInit();
    //loadData(reload: reload);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        currentMax = currentMax;
        pageMax += 1;
        // dreamOfNumbersProvider.getDreamList(
        //     onSuccess: (value) {
        //       dreamOfNumbersList = dreamOfNumbersList + value;
        //       update();
        //     },
        //     onError: (error) {
        //       update();
        //     },
        //     page: pageMax,
        //     limit: currentMax);
        Future.delayed(const Duration(seconds: 2)).then((value) => update());
      }
    });
  }

  // void loadData({bool? reload}) {
  //   isSearching = false;
  //   if (reload! || dreamOfNumbersList.isEmpty) {
  //     dreamOfNumbersList.clear();
  //     pageMax = 1;
  //     dreamOfNumbersProvider.getDreamList(
  //         onSuccess: (value) {
  //           dreamOfNumbersList = value;
  //           update();
  //         },
  //         onError: (error) {
  //           update();
  //         },
  //         page: pageMax,
  //         limit: currentMax);
  //     update();
  //   }
  // }

  ///
  /// Chọn item
  ///
  void onSelectedItem(int index){
    // Get item position index 
    currentSelected = index;
    update();
  }

  void onNextPage(){
    Get.toNamed(AppRoutes.V1_G3_ORDER_DETAIL);
  }

}