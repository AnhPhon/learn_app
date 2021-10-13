import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/du_an_khach_hang_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DuAnKhachHangRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DuAnKhachHangRepository();

  ///
  /// Get all du-an-khach-hangs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/du-an-khach-hangs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert du-an-khach-hang to database
  ///
  Future<ApiResponse> add(DuAnKhachHangRequest data) async {
    try {
      final response = await dioClient!.post('/du-an-khach-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update du-an-khach-hang to database
  ///
  Future<ApiResponse> update(DuAnKhachHangRequest data) async {
    try {
      final response = await dioClient!.put('/du-an-khach-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update du-an-khach-hang to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/du-an-khach-hangs/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate du-an-khach-hangs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/du-an-khach-hangs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/du-an-khach-hangs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find du-an-khach-hang by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/du-an-khach-hangs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
