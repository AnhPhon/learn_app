import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/dieu_khoan_chinh_sach_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DieuKhoanChinhSachRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DieuKhoanChinhSachRepository();

  ///
  /// Get all dieu-khoan-chinh-sachs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/dieu-khoan-chinh-sachs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert dieu-khoan-chinh-sach to database
  ///
  Future<ApiResponse> add(DieuKhoanChinhSachModel data) async {
    try {
      final response = await dioClient!.post('/dieu-khoan-chinh-sachs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dieu-khoan-chinh-sach to database
  ///
  Future<ApiResponse> update(DieuKhoanChinhSachModel data) async {
    try {
      final response = await dioClient!.put('/dieu-khoan-chinh-sachs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update dieu-khoan-chinh-sach to database
  ///
  Future<ApiResponse> delete(String id, DieuKhoanChinhSachModel data) async {
    try {
      final response =
          await dioClient!.delete('/dieu-khoan-chinh-sachs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate dieu-khoan-chinh-sachs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/dieu-khoan-chinh-sachs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/dieu-khoan-chinh-sachs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find dieu-khoan-chinh-sach by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/dieu-khoan-chinh-sachs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
