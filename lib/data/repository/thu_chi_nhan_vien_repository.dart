import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/thu_chi_nhan_vien_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ThuChiNhanVienRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ThuChiNhanVienRepository();

  ///
  /// Get all thu-chi-nhan-viens
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/thu-chi-nhan-viens');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert thu-chi-nhan-vien to database
  ///
  Future<ApiResponse> add(ThuChiNhanVienRequest data) async {
    try {
      final response = await dioClient!.post('/thu-chi-nhan-viens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thu-chi-nhan-vien to database
  ///
  Future<ApiResponse> update(ThuChiNhanVienRequest data) async {
    try {
      final response = await dioClient!.put('/thu-chi-nhan-viens', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update thu-chi-nhan-vien to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/thu-chi-nhan-viens/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate thu-chi-nhan-viens "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/thu-chi-nhan-viens/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/thu-chi-nhan-viens/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find thu-chi-nhan-vien by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/thu-chi-nhan-viens/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
