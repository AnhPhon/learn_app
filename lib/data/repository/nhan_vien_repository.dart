import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/nhan_vien_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class NhanVienRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  NhanVienRepository();

  ///
  /// Get all nhan-viens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/nhan-viens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert nhan-vien to database
  ///
  Future<ApiResponse> add(NhanVienRequest data) async {
    try {
      final response = await dioClient!.post('/nhan-viens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update nhan-vien to database
  ///
  Future<ApiResponse> update(NhanVienRequest data) async {
    try {
      final response = await dioClient!.put('/nhan-viens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update nhan-vien to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/nhan-viens/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate nhan-viens "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/nhan-viens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/nhan-viens/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find nhan-vien by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/nhan-viens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
