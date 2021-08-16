import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/utils/app_constants.dart' as app_constants;

class RegionRepo {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  RegionRepo();

  Future<ApiResponse> getRegions() async {
    try {
      final response = await dioClient!.get(app_constants.region_uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
