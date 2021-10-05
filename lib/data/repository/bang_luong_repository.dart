import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/bang_luong_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class BangLuongRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  BangLuongRepository();

  ///
  /// Get all bang-luongs
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/bang-luongs');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-luong to database
  ///
  Future<ApiResponse> add(BangLuongModel data) async {
    try {
      final response = await dioClient!.post('/bang-luongs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-luong to database
  ///
  Future<ApiResponse> update(BangLuongModel data) async {
    try {
      final response = await dioClient!.put('/bang-luongs', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-luong to database
  ///
  Future<ApiResponse> delete(String id, BangLuongModel data) async {
    try {
      final response =
          await dioClient!.delete('/bang-luongs/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate bang-luongs "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/bang-luongs/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/bang-luongs/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find bang-luong by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/bang-luongs/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
