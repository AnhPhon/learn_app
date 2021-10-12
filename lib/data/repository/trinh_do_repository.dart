import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/trinh_do_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class TrinhDoRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TrinhDoRepository();

  ///
  /// Get all trinh-dos
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/trinh-dos');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert trinh-do to database
  ///
  Future<ApiResponse> add(TrinhDoRequest data) async {
    try {
      final response = await dioClient!.post('/trinh-dos', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trinh-do to database
  ///
  Future<ApiResponse> update(TrinhDoRequest data) async {
    try {
      final response = await dioClient!.put('/trinh-dos', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update trinh-do to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/trinh-dos/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate trinh-dos "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/trinh-dos/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/trinh-dos/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find trinh-do by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/trinh-dos/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
