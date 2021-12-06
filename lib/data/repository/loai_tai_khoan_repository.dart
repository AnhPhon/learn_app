import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/loai_tai_khoan_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class LoaiTaiKhoanRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  LoaiTaiKhoanRepository();

  ///
  /// Get all loai-tai-khoans
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/loai-tai-khoans');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert loai-tai-khoan to database
  ///
  Future<ApiResponse> add(LoaiTaiKhoanRequest data) async {
    try {
      final response = await dioClient!.post('/loai-tai-khoans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-tai-khoan to database
  ///
  Future<ApiResponse> update(LoaiTaiKhoanRequest data) async {
    try {
      final response = await dioClient!.put('/loai-tai-khoans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update loai-tai-khoan to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/loai-tai-khoans/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate loai-tai-khoans "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/loai-tai-khoans/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/loai-tai-khoans/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find loai-tai-khoan by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/loai-tai-khoans/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
