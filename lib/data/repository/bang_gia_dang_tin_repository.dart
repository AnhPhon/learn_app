import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/bang_gia_dang_tin_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class BangGiaDangTinRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  BangGiaDangTinRepository();

  ///
  /// Get all bang-gia-dang-tins
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/bang-gia-dang-tins');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-gia-dang-tin to database
  ///
  Future<ApiResponse> add(BangGiaDangTinRequest data) async {
    try {
      final response = await dioClient!.post('/bang-gia-dang-tins', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-gia-dang-tin to database
  ///
  Future<ApiResponse> update(BangGiaDangTinRequest data) async {
    try {
      final response = await dioClient!.put('/bang-gia-dang-tins', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-gia-dang-tin to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/bang-gia-dang-tins/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate bang-gia-dang-tins "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/bang-gia-dang-tins/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/bang-gia-dang-tins/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find bang-gia-dang-tin by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/bang-gia-dang-tins/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
