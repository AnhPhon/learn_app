import 'package:flutter/material.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/repository/splash_repo.dart';
import 'package:template/helper/api_checker.dart';
import 'package:package_info/package_info.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo splashRepo;
  SplashProvider({required this.splashRepo});
 
  PackageInfo? _packageInfo;
  bool _hasConnection = true; 
 
  PackageInfo? get packageInfo => _packageInfo;
  bool get hasConnection => _hasConnection; 

  // Future<bool> initConfig(BuildContext context) async {
  //   _hasConnection = true;
  //   final ApiResponse apiResponse = await splashRepo.getConfig();
  //   bool isSuccess;
  //   if (apiResponse.response.statusCode == 200) {
  //     _packageInfo = await PackageInfo.fromPlatform();
  //     isSuccess = true;
  //   } else {
  //     isSuccess = false;
  //     ApiChecker.checkApi(context, apiResponse);
  //     if (apiResponse.error.toString() ==
  //         'Connection to API server failed due to internet connection') {
  //       _hasConnection = false;
  //     }
  //   }
  //   notifyListeners();
  //   return isSuccess;
  // }
  //
  // void initSharedPrefData() {
  //   splashRepo.initSharedData();
  // }
}
