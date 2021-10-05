import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/body/phuong_xa_model.dart';
import 'package:template/data/model/response/base/api_response.dart';

class PhuongXaRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  PhuongXaRepository();

  ///
  /// Get all phuong-xas
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/phuong-xas');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert phuong-xa to database
  ///
  Future<ApiResponse> add(PhuongXaModel data) async {
    try {
      final response = await dioClient!.post('/phuong-xas', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update phuong-xa to database
  ///
  Future<ApiResponse> update(PhuongXaModel data) async {
    try {
      final response = await dioClient!.put('/phuong-xas', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update phuong-xa to database
  ///
  Future<ApiResponse> delete(String id, PhuongXaModel data) async {
    try {
      final response =
          await dioClient!.delete('/phuong-xas/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate phuong-xas "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/phuong-xas/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/phuong-xas/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find phuong-xa by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/phuong-xas/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
