import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/response/base/api_response.dart';
import 'package:template/data/model/response/don_vi_response.dart';

class DonViRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DonViRepository();

  ///
  /// Get all don-vis
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/don-vis');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert don-vi-cung-cap to database
  ///
  Future<ApiResponse> add(DonViResponse data) async {
    try {
      final response = await dioClient!.post('/don-vis', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update don-vi-cung-cap to database
  ///
  Future<ApiResponse> update(DonViResponse data) async {
    try {
      final response = await dioClient!.put('/don-vis', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update don-vi-cung-cap to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/don-vis/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate don-vis "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/don-vis/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/don-vis/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find don-vi-cung-cap by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/don-vis/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
