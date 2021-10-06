import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/don_hang_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class DonHangRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  DonHangRepository();

  ///
  /// Get all don-hangs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/don-hangs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert don-hang to database
  ///
  Future<ApiResponse> add(DonHangModel data) async {
    try {
      final response = await dioClient!.post('/don-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update don-hang to database
  ///
  Future<ApiResponse> update(DonHangModel data) async {
    try {
      final response = await dioClient!.put('/don-hangs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update don-hang to database
  ///
  Future<ApiResponse> delete(String id, DonHangModel data) async {
    try {
      final response =
          await dioClient!.delete('/don-hangs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate don-hangs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/don-hangs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/don-hangs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find don-hang by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/don-hangs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
