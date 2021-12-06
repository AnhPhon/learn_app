import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/tai_khoan_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TaiKhoanRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TaiKhoanRepository();

  ///
  /// Get all tai-khoans
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/tai-khoans');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert tai-khoan to database
  ///
  Future<ApiResponse> add(TaiKhoanRequest data) async {
    try {
      final response = await dioClient!.post('/tai-khoans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update tai-khoan to database
  ///
  Future<ApiResponse> update(TaiKhoanRequest data) async {
    try {
      final response = await dioClient!.put('/tai-khoans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update tai-khoan to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/tai-khoans/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate tai-khoans "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/tai-khoans/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/tai-khoans/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find tai-khoan by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/tai-khoans/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
