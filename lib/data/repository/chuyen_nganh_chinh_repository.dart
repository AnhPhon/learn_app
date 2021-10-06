import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/chuyen_nganh_chinh_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class ChuyenNganhChinhRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ChuyenNganhChinhRepository();

  ///
  /// Get all chuyen-nganh-chinhs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/chuyen-nganh-chinhs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert chuyen-nganh-chinh to database
  ///
  Future<ApiResponse> add(ChuyenNganhChinhModel data) async {
    try {
      final response = await dioClient!.post('/chuyen-nganh-chinhs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update chuyen-nganh-chinh to database
  ///
  Future<ApiResponse> update(ChuyenNganhChinhModel data) async {
    try {
      final response = await dioClient!.put('/chuyen-nganh-chinhs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update chuyen-nganh-chinh to database
  ///
  Future<ApiResponse> delete(String id, ChuyenNganhChinhModel data) async {
    try {
      final response =
          await dioClient!.delete('/chuyen-nganh-chinhs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate chuyen-nganh-chinhs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/chuyen-nganh-chinhs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/chuyen-nganh-chinhs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find chuyen-nganh-chinh by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/chuyen-nganh-chinhs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
