import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/utils/app_constants.dart' as app_constants;
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.dioClient, required this.sharedPreferences});

  // Future<ApiResponse> getConfig() async {
//   //   try {
//   //     final response = await dioClient.get(app_constants.CONFIG_URI);
//   //     return ApiResponse.withSuccess(response);
//   //   } catch (e) {
//   //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
//   //   }
//   // }
//   //
//   // Future<void> initSharedData() async {
//   //
//   // }

}
