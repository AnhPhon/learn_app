import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/vi_tien_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ViTienRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ViTienRepository();

  ///
  /// Get all vi-tiens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/vi-tiens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert vi-tien to database
  ///
  Future<ApiResponse> add(ViTienRequest data) async {
    try {
      final response = await dioClient!.post('/vi-tiens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update vi-tien to database
  ///
  Future<ApiResponse> update(ViTienRequest data) async {
    try {
      final response = await dioClient!.put('/vi-tiens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update vi-tien to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response = await dioClient!.delete('/vi-tiens/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate vi-tiens "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/vi-tiens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/vi-tiens/paginate?page=$page&limit=$limit$filter';
      }
      
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find vi-tien by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/vi-tiens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
