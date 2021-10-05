import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/kho_hang_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class KhoHangRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  KhoHangRepository();

  ///
  /// Get all kho-hangs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/kho-hangs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert kho-hang to database
  ///
  Future<ApiResponse> add(KhoHangModel data) async {
    try {
      final response = await dioClient!.post('/kho-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update kho-hang to database
  ///
  Future<ApiResponse> update(KhoHangModel data) async {
    try {
      final response = await dioClient!.put('/kho-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update kho-hang to database
  ///
  Future<ApiResponse> delete(String id, KhoHangModel data) async {
    try {
      final response =
          await dioClient!.delete('/kho-hangs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate kho-hangs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/kho-hangs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/kho-hangs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find kho-hang by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/kho-hangs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
