import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/trang_thai_du_an_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TrangThaiDuAnRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TrangThaiDuAnRepository();

  ///
  /// Get all trang-thai-du-ans
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/trang-thai-du-ans');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert trang-thai-du-an to database
  ///
  Future<ApiResponse> add(TrangThaiDuAnRequest data) async {
    try {
      final response = await dioClient!.post('/trang-thai-du-ans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trang-thai-du-an to database
  ///
  Future<ApiResponse> update(TrangThaiDuAnRequest data) async {
    try {
      final response = await dioClient!.put('/trang-thai-du-ans', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trang-thai-du-an to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/trang-thai-du-ans/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate trang-thai-du-ans "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/trang-thai-du-ans/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/trang-thai-du-ans/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find trang-thai-du-an by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/trang-thai-du-ans/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
