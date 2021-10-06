import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/chuyen_mon_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ChuyenMonRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ChuyenMonRepository();

  ///
  /// Get all chuyen-mons
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/chuyen-mons');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert chuyen-mon to database
  ///
  Future<ApiResponse> add(ChuyenMonModel data) async {
    try {
      final response = await dioClient!.post('/chuyen-mons', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update chuyen-mon to database
  ///
  Future<ApiResponse> update(ChuyenMonModel data) async {
    try {
      final response = await dioClient!.put('/chuyen-mons', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update chuyen-mon to database
  ///
  Future<ApiResponse> delete(String id, ChuyenMonModel data) async {
    try {
      final response =
          await dioClient!.delete('/chuyen-mons/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate chuyen-mons "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/chuyen-mons/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/chuyen-mons/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find chuyen-mon by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/chuyen-mons/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
