import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/don_vi_cung_cap_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DonViCungCapRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DonViCungCapRepository();

  ///
  /// Get all don-vi-cung-caps
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/don-vi-cung-caps');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert don-vi-cung-cap to database
  ///
  Future<ApiResponse> add(DonViCungCapRequest data) async {
    try {
      final response = await dioClient!.post('/don-vi-cung-caps', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update don-vi-cung-cap to database
  ///
  Future<ApiResponse> update(DonViCungCapRequest data) async {
    try {
      final response = await dioClient!.put('/don-vi-cung-caps', data: data.toJson());
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
          await dioClient!.delete('/don-vi-cung-caps/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate don-vi-cung-caps "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/don-vi-cung-caps/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/don-vi-cung-caps/paginate?page=$page&limit=$limit$filter';
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
      final String uri = '/don-vi-cung-caps/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
