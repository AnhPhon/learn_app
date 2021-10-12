import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/cong_viec_nhan_vien_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class CongViecNhanVienRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  CongViecNhanVienRepository();

  ///
  /// Get all cong-viec-nhan-viens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/cong-viec-nhan-viens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert cong-viec-nhan-vien to database
  ///
  Future<ApiResponse> add(CongViecNhanVienRequest data) async {
    try {
      final response = await dioClient!.post('/cong-viec-nhan-viens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update cong-viec-nhan-vien to database
  ///
  Future<ApiResponse> update(CongViecNhanVienRequest data) async {
    try {
      final response = await dioClient!.put('/cong-viec-nhan-viens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update cong-viec-nhan-vien to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/cong-viec-nhan-viens/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate cong-viec-nhan-viens "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/cong-viec-nhan-viens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/cong-viec-nhan-viens/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find cong-viec-nhan-vien by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/cong-viec-nhan-viens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
