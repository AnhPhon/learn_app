

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarController extends GetxController{
  bool isSearch = false;

  void onChangedStatus(){
    isSearch = !isSearch;
    update();
  }

}