import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/bang_bang_cap_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class BangBangCapRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  BangBangCapRepository();

  ///
  /// Get all bang-bang-caps
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/bang-bang-caps');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-bang-cap to database
  ///
  Future<ApiResponse> add(BangBangCapRequest data) async {
    try {
      final response = await dioClient!.post('/bang-bang-caps', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-bang-cap to database
  ///
  Future<ApiResponse> update(BangBangCapRequest data) async {
    try {
      final response = await dioClient!.put('/bang-bang-caps', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-bang-cap to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/bang-bang-caps/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate bang-bang-caps "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/bang-bang-caps/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/bang-bang-caps/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find bang-bang-cap by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/bang-bang-caps/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
