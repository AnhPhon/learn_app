import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/cai_dat_chung_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class CaiDatChungRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  CaiDatChungRepository();

  ///
  /// Get all cai-dat-chungs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/cai-dat-chungs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert cai-dat-chung to database
  ///
  Future<ApiResponse> add(CaiDatChungRequest data) async {
    try {
      final response = await dioClient!.post('/cai-dat-chungs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update cai-dat-chung to database
  ///
  Future<ApiResponse> update(CaiDatChungRequest data) async {
    try {
      final response = await dioClient!.put('/cai-dat-chungs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update cai-dat-chung to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/cai-dat-chungs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate cai-dat-chungs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/cai-dat-chungs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/cai-dat-chungs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find cai-dat-chung by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/cai-dat-chungs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
