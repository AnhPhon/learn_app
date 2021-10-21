import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/lich_su_vi_tien_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class LichSuViTienRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  LichSuViTienRepository();

  ///
  /// Get all lich-su-vi-tiens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/lich-su-vi-tiens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert lich-su-vi-tien to database
  ///
  Future<ApiResponse> add(LichSuViTienRequest data) async {
    try {
      final response = await dioClient!.post('/lich-su-vi-tiens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update lich-su-vi-tien to database
  ///
  Future<ApiResponse> update(LichSuViTienRequest data) async {
    try {
      final response = await dioClient!.put('/lich-su-vi-tiens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update lich-su-vi-tien to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/lich-su-vi-tiens/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate lich-su-vi-tiens "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/lich-su-vi-tiens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/lich-su-vi-tiens/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find lich-su-vi-tien by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/lich-su-vi-tiens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
