import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/nhom_cua_hang_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class NhomCuaHangRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  NhomCuaHangRepository();

  ///
  /// Get all nhom-cua-hangs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/nhom-cua-hangs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert nhom-cua-hang to database
  ///
  Future<ApiResponse> add(NhomCuaHangModel data) async {
    try {
      final response = await dioClient!.post('/nhom-cua-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update nhom-cua-hang to database
  ///
  Future<ApiResponse> update(NhomCuaHangModel data) async {
    try {
      final response = await dioClient!.put('/nhom-cua-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update nhom-cua-hang to database
  ///
  Future<ApiResponse> delete(String id, NhomCuaHangModel data) async {
    try {
      final response =
          await dioClient!.delete('/nhom-cua-hangs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate nhom-cua-hangs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/nhom-cua-hangs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/nhom-cua-hangs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find nhom-cua-hang by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/nhom-cua-hangs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
