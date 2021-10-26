import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/request/phi_app_request.dart';
import 'package:template/data/model/response/base/api_response.dart';

class PhiAppRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  PhiAppRepository();

  ///
  /// Get all phi-apps
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/phi-apps');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert phi-app to database
  ///
  Future<ApiResponse> add(PhiAppRequest data) async {
    try {
      final response = await dioClient!.post('/phi-apps', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update phi-app to database
  ///
  Future<ApiResponse> update(PhiAppRequest data) async {
    try {
      final response = await dioClient!.put('/phi-apps', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update phi-app to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response =
          await dioClient!.delete('/phi-apps/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate phi-apps "page": 1, "limit": 10, filter 
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/phi-apps/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/phi-apps/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find phi-app by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/phi-apps/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
